import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';
import '../../../app/theme/app_theme.dart';
import '../../../data/models/user_model.dart';
import '../../../widgets/app_shell_scaffold.dart';
import '../../auth/controllers/auth_controller.dart';

class DashboardView extends GetView<AuthController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShellScaffold(
      title: 'Dashboard',
      body: Obx(() {
        final user = controller.currentUser.value;
        final isSuperuser = user?.isSuperuser ?? false;
        final isApprover = controller.isApprover.value;

        final tiles = <_NavTileData>[
          _NavTileData(
            'Public Holidays',
            Icons.beach_access_outlined,
            Routes.publicHolidays,
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
          if (isApprover)
            _NavTileData(
              'Approvals',
              Icons.fact_check_outlined,
              Routes.approvals,
            ),
          _NavTileData('Profile', Icons.person_outline, Routes.profile),
          if (isSuperuser) ...[
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
            const Row(
              children: [
                Expanded(
                  child: _PlaceholderStatCard(
                    label: 'Leave Balances',
                    value: '—',
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: _PlaceholderStatCard(
                    label: 'Pending Requests',
                    value: '—',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const _PlaceholderStatCard(
              label: 'Recent Activity',
              value: 'Nothing yet',
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
  const _PlaceholderStatCard({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 4),
            Text(value, style: Theme.of(context).textTheme.titleLarge),
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
        onTap: () => Get.offAllNamed(data.route),
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
