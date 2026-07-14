import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app/routes/app_routes.dart';
import '../app/theme/app_theme.dart';
import '../features/notifications/controllers/notifications_controller.dart';

/// Shared Scaffold wrapper for *pushed* secondary screens (detail views,
/// approvals, recommendations, notifications, admin) - these live outside
/// the bottom-nav shell ([MainShellView]) and get a back arrow from the
/// navigator instead of a drawer. Also bakes in the notifications bell +
/// unread badge (Task 12.1) so every screen gets it for free.
class AppShellScaffold extends StatelessWidget {
  const AppShellScaffold({
    super.key,
    required this.title,
    required this.body,
    this.actions,
    this.floatingActionButton,
  });

  final String title;
  final Widget body;
  final List<Widget>? actions;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [...?actions, const NotificationsBellButton()],
      ),
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }
}

/// Public so [MainShellView]'s own AppBar (the bottom-nav tabs) can reuse
/// the same bell + unread badge.
class NotificationsBellButton extends StatelessWidget {
  const NotificationsBellButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NotificationsController>();

    return Obx(() {
      final count = controller.unreadCount.value;
      return Stack(
        alignment: Alignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () => Get.toNamed(Routes.notifications),
          ),
          if (count > 0)
            Positioned(
              right: 6,
              top: 6,
              child: IgnorePointer(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 1,
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  decoration: const BoxDecoration(
                    color: AppColors.danger,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    count > 9 ? '9+' : '$count',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
        ],
      );
    });
  }
}
