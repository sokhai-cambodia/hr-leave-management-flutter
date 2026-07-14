import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/theme/app_theme.dart';
import '../../../data/models/leave_plan_request_model.dart';
import '../../../data/models/leave_request_model.dart';
import '../../../widgets/app_shell_scaffold.dart';
import '../controllers/approvals_controller.dart';

class ApprovalsView extends StatelessWidget {
  const ApprovalsView({super.key});

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  void _confirmReject(VoidCallback onConfirmed) {
    Get.dialog(
      AlertDialog(
        title: const Text('Reject Request'),
        content: const Text(
          'Are you sure you want to reject this request? This action cannot be undone.',
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              Get.back();
              onConfirmed();
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.danger),
            child: const Text('Reject'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ApprovalsController>();

    return DefaultTabController(
      length: 2,
      child: AppShellScaffold(
        title: 'Approvals',
        body: Column(
          children: [
            const TabBar(
              tabs: [
                Tab(text: 'Leave Requests'),
                Tab(text: 'Leave Plans'),
              ],
            ),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.errorMessage.value != null) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 64,
                            color: AppColors.danger,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            controller.errorMessage.value!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: controller.fetchApprovals,
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return TabBarView(
                  children: [
                    _buildLeaveRequestsTab(controller),
                    _buildLeavePlanRequestsTab(controller),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLeaveRequestsTab(ApprovalsController controller) {
    return Obx(() {
      final items = controller.pendingLeaveRequests;
      if (items.isEmpty) {
        return const Center(
          child: Text('No leave requests waiting for your approval.'),
        );
      }
      return RefreshIndicator(
        onRefresh: controller.fetchApprovals,
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: items.length,
          itemBuilder: (context, index) =>
              _buildLeaveRequestCard(controller, items[index]),
        ),
      );
    });
  }

  Widget _buildLeavePlanRequestsTab(ApprovalsController controller) {
    return Obx(() {
      final items = controller.pendingLeavePlanRequests;
      if (items.isEmpty) {
        return const Center(
          child: Text('No leave plans waiting for your approval.'),
        );
      }
      return RefreshIndicator(
        onRefresh: controller.fetchApprovals,
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: items.length,
          itemBuilder: (context, index) =>
              _buildLeavePlanRequestCard(controller, items[index]),
        ),
      );
    });
  }

  Widget _buildLeaveRequestCard(
    ApprovalsController controller,
    LeaveRequestModel request,
  ) {
    return Obx(() {
      final isProcessing = controller.processingIds.contains(request.id);
      return Card(
        margin: const EdgeInsets.only(bottom: 12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                request.owner.fullName ?? request.owner.email,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                request.leaveType.name,
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.date_range_outlined,
                    size: 16,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${_formatDate(request.startDate)} to ${_formatDate(request.endDate)} '
                    '(${request.amount == 1 ? "1 day" : "${request.amount} days"})',
                    style: const TextStyle(fontSize: 13),
                  ),
                ],
              ),
              if (request.description != null &&
                  request.description!.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  request.description!,
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 13,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
              const SizedBox(height: 12),
              if (isProcessing)
                const Center(child: CircularProgressIndicator())
              else
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => _confirmReject(
                          () => controller.rejectLeaveRequest(request.id),
                        ),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.danger,
                        ),
                        child: const Text('Reject'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () =>
                            controller.approveLeaveRequest(request.id),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.success,
                        ),
                        child: const Text('Approve'),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildLeavePlanRequestCard(
    ApprovalsController controller,
    LeavePlanRequestModel request,
  ) {
    return Obx(() {
      final isProcessing = controller.processingIds.contains(request.id);
      final sortedDetails = List<LeavePlanDetailModel>.from(request.details)
        ..sort((a, b) => a.leaveDate.compareTo(b.leaveDate));
      final datesPreview = sortedDetails
          .map((d) => _formatDate(d.leaveDate))
          .join(', ');

      return Card(
        margin: const EdgeInsets.only(bottom: 12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                request.owner.fullName ?? request.owner.email,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                request.leaveType.name,
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 16,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      datesPreview.isEmpty ? 'No dates selected' : datesPreview,
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                ],
              ),
              if (request.description != null &&
                  request.description!.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  request.description!,
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 13,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
              const SizedBox(height: 12),
              if (isProcessing)
                const Center(child: CircularProgressIndicator())
              else
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => _confirmReject(
                          () => controller.rejectLeavePlanRequest(request.id),
                        ),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.danger,
                        ),
                        child: const Text('Reject'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () =>
                            controller.approveLeavePlanRequest(request.id),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.success,
                        ),
                        child: const Text('Approve'),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      );
    });
  }
}
