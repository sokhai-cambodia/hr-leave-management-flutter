import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';
import '../../../app/theme/app_theme.dart';
import '../../auth/controllers/auth_controller.dart';

class ProfileView extends GetView<AuthController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final user = controller.currentUser.value;
      final isSuperuser = user?.isSuperuser ?? false;
      final role = isSuperuser
          ? 'Superuser'
          : controller.isApprover.value
          ? 'Team owner / approver'
          : 'Employee';

      return ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: AppColors.pastel(
                      AppColors.primary,
                    ).background,
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
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(user?.email ?? ''),
                        const SizedBox(height: 16),
                        _InfoRow(
                          label: 'Team',
                          value: user?.team?.name ?? 'No team assigned',
                        ),
                        _InfoRow(label: 'Role', value: role),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isSuperuser) ...[
            const SizedBox(height: 16),
            Card(
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 12, 16, 4),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Admin',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  _AdminTile(
                    icon: Icons.rule_outlined,
                    label: 'Policies',
                    route: Routes.adminPolicies,
                  ),
                  _AdminTile(
                    icon: Icons.beach_access_outlined,
                    label: 'Public Holidays',
                    route: Routes.adminPublicHolidays,
                  ),
                  _AdminTile(
                    icon: Icons.category_outlined,
                    label: 'Leave Types',
                    route: Routes.adminLeaveTypes,
                  ),
                  _AdminTile(
                    icon: Icons.groups_outlined,
                    label: 'Teams',
                    route: Routes.adminTeams,
                  ),
                  _AdminTile(
                    icon: Icons.account_balance_wallet_outlined,
                    label: 'Leave Balances',
                    route: Routes.adminLeaveBalances,
                  ),
                  _AdminTile(
                    icon: Icons.admin_panel_settings_outlined,
                    label: 'Users',
                    route: Routes.adminUsers,
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 16),
          OutlinedButton.icon(
            onPressed: controller.logout,
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.danger,
              side: const BorderSide(color: AppColors.danger),
              minimumSize: const Size.fromHeight(54),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppShapes.buttonRadius),
              ),
            ),
            icon: const Icon(Icons.logout),
            label: const Text('Log out'),
          ),
        ],
      );
    });
  }

  static String _initials(String? value) {
    final trimmed = value?.trim() ?? '';
    return trimmed.isEmpty ? '?' : trimmed[0].toUpperCase();
  }
}

class _AdminTile extends StatelessWidget {
  const _AdminTile({
    required this.icon,
    required this.label,
    required this.route,
  });

  final IconData icon;
  final String label;
  final String route;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => Get.toNamed(route),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(label, style: Theme.of(context).textTheme.bodySmall),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
