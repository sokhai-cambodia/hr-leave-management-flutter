import 'package:flutter/material.dart';

import '../../app/theme/app_theme.dart';
import '../../features/leave_plan_requests/views/leave_plan_requests_view.dart';
import '../../features/leave_requests/views/leave_requests_view.dart';

/// The "Leaves" bottom-nav tab: a pill-styled segmented control switching
/// between Leave Requests and Leave Plan Requests, matching the reference
/// design's segmented-tab pattern (in place of two separate nav entries).
class LeavesTabView extends StatefulWidget {
  const LeavesTabView({super.key});

  @override
  State<LeavesTabView> createState() => _LeavesTabViewState();
}

class _LeavesTabViewState extends State<LeavesTabView>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController = TabController(
    length: 2,
    vsync: this,
  );

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.md,
            AppSpacing.lg,
            AppSpacing.sm,
          ),
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.xs),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.06)
                  : Colors.black.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(AppShapes.pillRadius),
            ),
            child: TabBar(
              controller: _tabController,
              tabs: const [
                Tab(text: 'Requests'),
                Tab(text: 'Plans'),
              ],
            ),
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: const [LeaveRequestsView(), LeavePlanRequestsView()],
          ),
        ),
      ],
    );
  }
}
