import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/app_shell_scaffold.dart';
import '../../auth/controllers/auth_controller.dart';

class ProfileView extends GetView<AuthController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShellScaffold(
      title: 'Profile',
      body: Obx(() {
        final user = controller.currentUser.value;
        final role = user?.isSuperuser == true
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user?.fullName ?? 'Unnamed user',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
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
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: controller.logout,
              icon: const Icon(Icons.logout),
              label: const Text('Log out'),
            ),
          ],
        );
      }),
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
