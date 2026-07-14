import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/theme/app_theme.dart';
import '../../features/dashboard/views/dashboard_view.dart';
import '../../features/leave_plan_requests/views/leave_plan_request_form_view.dart';
import '../../features/leave_requests/views/leave_request_form_view.dart';
import '../../features/profile/views/profile_view.dart';
import '../../features/schedule/views/schedule_view.dart';
import '../../widgets/app_shell_scaffold.dart';
import 'leaves_tab_view.dart';
import 'main_shell_controller.dart';

/// Persistent bottom-tab shell (Dashboard / Leaves / Schedule / Profile)
/// replacing the previous hamburger-drawer nav. `IndexedStack` keeps all 4
/// tab bodies mounted simultaneously so each tab's own GetX controller
/// state and initial fetch survive tab switches with no extra keep-alive
/// plumbing.
class MainShellView extends StatelessWidget {
  const MainShellView({super.key});

  static const _titles = ['Dashboard', 'Leaves', 'Schedule', 'Profile'];

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MainShellController>();

    return Obx(() {
      final index = controller.selectedIndex.value;
      return Scaffold(
        appBar: AppBar(
          title: Text(_titles[index]),
          actions: const [NotificationsBellButton()],
        ),
        body: IndexedStack(
          index: index,
          children: const [
            DashboardView(),
            LeavesTabView(),
            ScheduleView(),
            ProfileView(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showQuickActionSheet(context),
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: index,
          onTap: controller.changeTab,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_outlined),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.event_note_outlined),
              label: 'Leaves',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month_outlined),
              label: 'Schedule',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'Profile',
            ),
          ],
        ),
      );
    });
  }

  void _showQuickActionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppShapes.cardRadius),
        ),
      ),
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.request_page_outlined),
              title: const Text('Request Leave'),
              onTap: () {
                Navigator.of(sheetContext).pop();
                Get.to(() => const LeaveRequestFormView());
              },
            ),
            ListTile(
              leading: const Icon(Icons.event_note_outlined),
              title: const Text('Plan Leave'),
              onTap: () {
                Navigator.of(sheetContext).pop();
                Get.to(() => const LeavePlanRequestFormView());
              },
            ),
          ],
        ),
      ),
    );
  }
}
