import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';
import '../../../app/theme/app_theme.dart';
import '../../../data/models/leave_balance_model.dart';
import '../../../data/models/user_model.dart';
import '../../../widgets/app_shell_scaffold.dart';
import '../../auth/controllers/auth_controller.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final dashboardController = Get.find<DashboardController>();

    return AppShellScaffold(
      title: 'Dashboard',
      body: Obx(() {
        final user = authController.currentUser.value;
        final isSuperuser = user?.isSuperuser ?? false;
        final isApprover = authController.isApprover.value;

        final balances = dashboardController.balances;
        final isLoadingBalances = dashboardController.isLoadingBalances.value;
        final balancesError = dashboardController.balancesError.value;

        final pendingApprovalsCount = dashboardController.pendingApprovalsCount.value;
        final isLoadingPendingApprovals =
            dashboardController.isLoadingPendingApprovals.value;
        final pendingApprovalsError = dashboardController.pendingApprovalsError.value;

        final tiles = <_NavTileData>[
          _NavTileData(
            'Schedule',
            Icons.calendar_month_outlined,
            Routes.schedule,
          ),
          _NavTileData(
            'Leave Plan Requests',
            Icons.event_note_outlined,
            Routes.leavePlanRequests,
          ),
          _NavTileData(
            'Leave Requests',
            Icons.request_page_outlined,
            Routes.leaveRequests,
          ),
          _NavTileData(
            'Recommendations',
            Icons.auto_awesome_outlined,
            Routes.recommendations,
          ),
          if (isSuperuser) ...[
            _NavTileData(
              'Manage Public Holidays',
              Icons.edit_calendar_outlined,
              Routes.adminPublicHolidays,
            ),
            _NavTileData('Policies', Icons.rule_outlined, Routes.adminPolicies),
            _NavTileData(
              'Leave Types',
              Icons.category_outlined,
              Routes.adminLeaveTypes,
            ),
            _NavTileData(
              'Teams',
              Icons.groups_outlined,
              Routes.adminTeams,
            ),
            _NavTileData(
              'Leave Balances',
              Icons.account_balance_wallet_outlined,
              Routes.adminLeaveBalances,
            ),
            _NavTileData(
              'Users',
              Icons.admin_panel_settings_outlined,
              Routes.adminUsers,
            ),
          ],
        ];

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _ProfileCard(user: user),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _PlaceholderStatCard(
                    label: 'Available Days',
                    value: _availableDaysSummary(
                      balances: balances,
                      isLoading: isLoadingBalances,
                      hasError: balancesError != null,
                    ),
                  ),
                ),
                if (isApprover) ...[
                  const SizedBox(width: 12),
                  Expanded(
                    child: _PlaceholderStatCard(
                      label: 'Pending Approvals',
                      value: _pendingCountSummary(
                        count: pendingApprovalsCount,
                        isLoading: isLoadingPendingApprovals,
                        hasError: pendingApprovalsError != null,
                      ),
                      onTap: () => Get.toNamed(Routes.approvals),
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 20),
            Text('Leave Balances', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            _LeaveBalancesSection(
              isLoading: isLoadingBalances,
              error: balancesError,
              balances: balances,
              onRetry: dashboardController.fetchBalances,
            ),
            const SizedBox(height: 20),
            Text('Quick actions', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.3,
              children: [for (final tile in tiles) _NavGridTile(data: tile)],
            ),
          ],
        );
      }),
    );
  }

  static String _availableDaysSummary({
    required List<LeaveBalanceModel> balances,
    required bool isLoading,
    required bool hasError,
  }) {
    if (isLoading) return '—';
    if (hasError) return 'N/A';
    final total = balances.fold<double>(
      0,
      (sum, balance) => sum + balance.availableBalance,
    );
    return _formatDays(total);
  }

  static String _pendingCountSummary({
    required int count,
    required bool isLoading,
    required bool hasError,
  }) {
    if (isLoading) return '—';
    if (hasError) return 'N/A';
    return count.toString();
  }

  static String _formatDays(double value) {
    return value == value.roundToDouble()
        ? value.toStringAsFixed(0)
        : value.toStringAsFixed(1);
  }
}

class _ProfileCard extends StatelessWidget {
  const _ProfileCard({required this.user});

  final UserModel? user;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              child: Text(_initials(user?.fullName ?? user?.email)),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user?.fullName ?? 'Unnamed user',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(user?.email ?? ''),
                  const SizedBox(height: 4),
                  Text(
                    user?.team?.name ?? 'No team assigned',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static String _initials(String? value) {
    final trimmed = value?.trim() ?? '';
    return trimmed.isEmpty ? '?' : trimmed[0].toUpperCase();
  }
}

class _PlaceholderStatCard extends StatelessWidget {
  const _PlaceholderStatCard({
    required this.label,
    required this.value,
    this.onTap,
  });

  final String label;
  final String value;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: Theme.of(context).textTheme.bodySmall),
                  const SizedBox(height: 4),
                  Text(value, style: Theme.of(context).textTheme.titleLarge),
                ],
              ),
              if (onTap != null)
                const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}

class _LeaveBalancesSection extends StatelessWidget {
  const _LeaveBalancesSection({
    required this.isLoading,
    required this.error,
    required this.balances,
    required this.onRetry,
  });

  final bool isLoading;
  final String? error;
  final List<LeaveBalanceModel> balances;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 24),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (error != null) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(error!, textAlign: TextAlign.center),
              const SizedBox(height: 8),
              OutlinedButton(onPressed: onRetry, child: const Text('Retry')),
            ],
          ),
        ),
      );
    }

    if (balances.isEmpty) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text('No leave balances yet.'),
        ),
      );
    }

    return Column(
      children: [
        for (final balance in balances) _LeaveBalanceTile(balance: balance),
      ],
    );
  }
}

class _LeaveBalanceTile extends StatelessWidget {
  const _LeaveBalanceTile({required this.balance});

  final LeaveBalanceModel balance;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('${balance.leaveType.name} (${balance.leaveType.code})'),
        subtitle: Text(
          'Balance ${DashboardView._formatDays(balance.balance)} · '
          'Taken ${DashboardView._formatDays(balance.takenBalance)}',
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              DashboardView._formatDays(balance.availableBalance),
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text('available', style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}

class _NavTileData {
  const _NavTileData(this.label, this.icon, this.route);

  final String label;
  final IconData icon;
  final String route;
}

class _NavGridTile extends StatelessWidget {
  const _NavGridTile({required this.data});

  final _NavTileData data;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(AppShapes.cardRadius),
        // toNamed (not offAllNamed) - keeps Dashboard on the stack so back
        // returns here instead of exiting the app.
        onTap: () => Get.toNamed(data.route),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                data.icon,
                size: 28,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 8),
              Text(
                data.label,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
