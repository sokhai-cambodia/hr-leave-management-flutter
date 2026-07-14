import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';
import '../../../app/theme/app_theme.dart';
import '../../../data/models/leave_balance_model.dart';
import '../../../data/models/user_model.dart';
import '../../../widgets/stat_card.dart';
import '../../auth/controllers/auth_controller.dart';
import '../../leave_plan_requests/views/leave_plan_request_form_view.dart';
import '../../leave_requests/views/leave_request_form_view.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final dashboardController = Get.find<DashboardController>();

    return Obx(() {
      final user = authController.currentUser.value;
      final isApprover = authController.isApprover.value;

      final balances = dashboardController.balances;
      final isLoadingBalances = dashboardController.isLoadingBalances.value;
      final balancesError = dashboardController.balancesError.value;

      final pendingApprovalsCount =
          dashboardController.pendingApprovalsCount.value;
      final isLoadingPendingApprovals =
          dashboardController.isLoadingPendingApprovals.value;
      final pendingApprovalsError =
          dashboardController.pendingApprovalsError.value;

      return ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _ProfileCard(user: user),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _QuickActionButton(
                  icon: Icons.request_page_outlined,
                  label: 'Request Leave',
                  color: AppColors.primary,
                  onTap: () => Get.to(() => const LeaveRequestFormView()),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _QuickActionButton(
                  icon: Icons.event_note_outlined,
                  label: 'Plan Leave',
                  color: AppColors.warning,
                  onTap: () => Get.to(() => const LeavePlanRequestFormView()),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: StatCard(
                    label: 'Available Days',
                    value: _availableDaysSummary(
                      balances: balances,
                      isLoading: isLoadingBalances,
                      hasError: balancesError != null,
                    ),
                    color: AppColors.info,
                  ),
                ),
                if (isApprover) ...[
                  const SizedBox(width: 12),
                  Expanded(
                    child: StatCard(
                      label: 'Pending Approvals',
                      value: _pendingCountSummary(
                        count: pendingApprovalsCount,
                        isLoading: isLoadingPendingApprovals,
                        hasError: pendingApprovalsError != null,
                      ),
                      color: AppColors.warning,
                      onTap: () => Get.toNamed(Routes.approvals),
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Leave Balances',
            style: Theme.of(context).textTheme.titleMedium,
          ),
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
          Card(
            clipBehavior: Clip.antiAlias,
            child: ListTile(
              leading: const Icon(Icons.auto_awesome_outlined),
              title: const Text('Recommendations'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Get.toNamed(Routes.recommendations),
            ),
          ),
        ],
      );
    });
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

/// Pastel rounded-rect action tile, mirrors the reference design's
/// Check In/Check Out button row on the home screen.
class _QuickActionButton extends StatelessWidget {
  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final pastel = AppColors.pastel(color);
    return Material(
      color: pastel.background,
      borderRadius: BorderRadius.circular(AppShapes.cardRadius),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppShapes.cardRadius),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          child: Column(
            children: [
              Icon(icon, color: pastel.foreground),
              const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: pastel.foreground,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
              backgroundColor: AppColors.pastel(AppColors.primary).background,
              foregroundColor: AppColors.primary,
              child: Text(
                _initials(user?.fullName ?? user?.email),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
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
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            Text('available', style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
