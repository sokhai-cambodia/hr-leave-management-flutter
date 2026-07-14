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

/// Persistent bottom-tab shell (Home / Leaves / Calendar / Profile)
/// replacing the previous hamburger-drawer nav. `IndexedStack` keeps all 4
/// tab bodies mounted simultaneously so each tab's own GetX controller
/// state and initial fetch survive tab switches with no extra keep-alive
/// plumbing.
class MainShellView extends StatelessWidget {
  const MainShellView({super.key});

  static const _titles = ['Home', 'Leaves', 'Calendar', 'Profile'];

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MainShellController>();

    return Obx(() {
      final index = controller.selectedIndex.value;

      return Scaffold(
        backgroundColor: AppColors.lightBackground,
        appBar: AppBar(
          backgroundColor: AppColors.lightBackground,
          automaticallyImplyLeading: false,
          titleSpacing: AppSpacing.lg,
          title: Text(
            _titles[index],
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: AppSpacing.lg),
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.lightFieldFill,
                  shape: BoxShape.circle,
                ),
                child: const NotificationsBellButton(),
              ),
            ),
          ],
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
        bottomNavigationBar: BottomAppBar(
          padding: EdgeInsets.zero,
          shape: const CircularNotchedRectangle(),
          notchMargin: 8,
          color: AppColors.lightSurface,
          elevation: 8,
          child: SizedBox(
            height: 64,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NavItem(
                  icon: Icons.home_outlined,
                  activeIcon: Icons.home,
                  label: 'Home',
                  selected: index == 0,
                  onTap: () => controller.changeTab(0),
                ),
                _NavItem(
                  icon: Icons.event_note_outlined,
                  activeIcon: Icons.event_note,
                  label: 'Leaves',
                  selected: index == 1,
                  onTap: () => controller.changeTab(1),
                ),
                const SizedBox(width: 40),
                _NavItem(
                  icon: Icons.calendar_month_outlined,
                  activeIcon: Icons.calendar_month,
                  label: 'Calendar',
                  selected: index == 2,
                  onTap: () => controller.changeTab(2),
                ),
                _NavItem(
                  icon: Icons.person_outline,
                  activeIcon: Icons.person,
                  label: 'Profile',
                  selected: index == 3,
                  onTap: () => controller.changeTab(3),
                ),
              ],
            ),
          ),
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
              leading: const Icon(Icons.edit_calendar_outlined),
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

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.primary : Colors.black45;
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(selected ? activeIcon : icon, color: color, size: 24),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 11,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
