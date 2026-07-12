import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';

/// Minimal post-login screen — superseded by the real app shell/dashboard
/// in Phase 2.
class WelcomeView extends GetView<AuthController> {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HR Leave Management'),
        actions: [
          IconButton(
            onPressed: controller.logout,
            icon: const Icon(Icons.logout),
            tooltip: 'Log out',
          ),
        ],
      ),
      body: Obx(() {
        final user = controller.currentUser.value;
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle_outline, size: 64),
              const SizedBox(height: 16),
              Text(
                user?.fullName != null ? 'Welcome, ${user!.fullName}!' : 'Welcome!',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(user?.email ?? ''),
            ],
          ),
        );
      }),
    );
  }
}
