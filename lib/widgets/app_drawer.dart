import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app/routes/app_routes.dart';
import '../features/auth/controllers/auth_controller.dart';

/// Persistent side nav, included on every authenticated screen via
/// [AppShellScaffold] — the "shell" for Task 2.1. Item visibility reacts to
/// [AuthController.currentUser] (superuser branch) and
/// [AuthController.isApprover] (Task 2.2).
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();

    return Obx(() {
      final user = controller.currentUser.value;
      final isSuperuser = user?.isSuperuser ?? false;
      final isApprover = controller.isApprover.value;

      return Drawer(
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(user?.fullName ?? 'HR Leave Management'),
                accountEmail: Text(user?.email ?? ''),
                currentAccountPicture: CircleAvatar(
                  child: Text(_initials(user?.fullName ?? user?.email)),
                ),
              ),
              _NavTile(
                icon: Icons.dashboard_outlined,
                label: 'Dashboard',
                route: Routes.dashboard,
              ),
              _NavTile(
                icon: Icons.beach_access_outlined,
                label: 'Public Holidays',
                route: Routes.publicHolidays,
              ),
              _NavTile(
                icon: Icons.event_note_outlined,
                label: 'Leave Plan Requests',
                route: Routes.leavePlanRequests,
              ),
              _NavTile(
                icon: Icons.request_page_outlined,
                label: 'Leave Requests',
                route: Routes.leaveRequests,
              ),
              _NavTile(
                icon: Icons.auto_awesome_outlined,
                label: 'Recommendations',
                route: Routes.recommendations,
              ),
              if (isApprover)
                _NavTile(
                  icon: Icons.fact_check_outlined,
                  label: 'Approvals',
                  route: Routes.approvals,
                ),
              _NavTile(
                icon: Icons.person_outline,
                label: 'Settings / Profile',
                route: Routes.profile,
              ),
              if (isSuperuser) ...[
                const Divider(),
                const Padding(
                  padding: EdgeInsets.fromLTRB(16, 8, 16, 4),
                  child: Text(
                    'Admin',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                _NavTile(
                  icon: Icons.rule_outlined,
                  label: 'Policies',
                  route: Routes.adminPolicies,
                ),
                _NavTile(
                  icon: Icons.beach_access_outlined,
                  label: 'Public Holidays',
                  route: Routes.adminPublicHolidays,
                ),
                _NavTile(
                  icon: Icons.category_outlined,
                  label: 'Leave Types',
                  route: Routes.adminLeaveTypes,
                ),
                _NavTile(
                  icon: Icons.groups_outlined,
                  label: 'Teams',
                  route: Routes.adminTeams,
                ),
                _NavTile(
                  icon: Icons.account_balance_wallet_outlined,
                  label: 'Leave Balances',
                  route: Routes.adminLeaveBalances,
                ),
                _NavTile(
                  icon: Icons.admin_panel_settings_outlined,
                  label: 'Users',
                  route: Routes.adminUsers,
                ),
              ],
              const Divider(),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Log out'),
                onTap: controller.logout,
              ),
            ],
          ),
        ),
      );
    });
  }

  static String _initials(String? value) {
    final trimmed = value?.trim() ?? '';
    return trimmed.isEmpty ? '?' : trimmed[0].toUpperCase();
  }
}

class _NavTile extends StatelessWidget {
  const _NavTile({
    required this.icon,
    required this.label,
    required this.route,
  });

  final IconData icon;
  final String label;
  final String route;

  @override
  Widget build(BuildContext context) {
    final isCurrent = Get.currentRoute == route;
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      selected: isCurrent,
      selectedTileColor: Theme.of(
        context,
      ).colorScheme.primary.withValues(alpha: 0.08),
      onTap: () {
        Navigator.of(context).pop();
        // toNamed (not offAllNamed) - a normal push keeps the prior screen
        // on the stack so the system back button returns to it instead of
        // exiting the app (there'd be nothing left to pop otherwise).
        if (!isCurrent) Get.toNamed(route);
      },
    );
  }
}
