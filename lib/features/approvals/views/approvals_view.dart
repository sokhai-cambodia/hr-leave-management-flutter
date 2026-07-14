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
                  color: Colors.black.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(AppShapes.pillRadius),
                ),
                child: const TabBar(
                  tabs: [
                    Tab(text: 'Leave Requests'),
                    Tab(text: 'Leave Plans'),
                  ],
                ),
              ),
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
        return const _EmptyApprovalsState(
          message: 'No leave requests waiting for your approval.',
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
        return const _EmptyApprovalsState(
          message: 'No leave plans waiting for your approval.',
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
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      request.owner.fullName ?? request.owner.email,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  _TypeBadge(label: request.leaveType.name),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 16,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${_formatDate(request.startDate)} to ${_formatDate(request.endDate)}',
                    style: TextStyle(color: Colors.grey[800], fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.timelapse_outlined,
                    size: 16,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${request.amount} ${request.amount == 1 ? "Day" : "Days"}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              if (request.description != null &&
                  request.description!.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text(
                  request.description!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 13,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
              const SizedBox(height: 16),
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
                          side: const BorderSide(color: AppColors.danger),
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
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      request.owner.fullName ?? request.owner.email,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  _TypeBadge(label: request.leaveType.name),
                ],
              ),
              const SizedBox(height: 12),
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
                      style: TextStyle(color: Colors.grey[800], fontSize: 14),
                    ),
                  ),
                ],
              ),
              if (request.description != null &&
                  request.description!.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text(
                  request.description!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 13,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
              const SizedBox(height: 16),
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
                          side: const BorderSide(color: AppColors.danger),
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

class _EmptyApprovalsState extends StatelessWidget {
  const _EmptyApprovalsState({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.fact_check_outlined, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            const Text(
              'All caught up',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}

/// Pill tag for the leave type, mirroring the status-badge shape used on
/// the Leaves list cards - every approvals-inbox item is implicitly
/// "pending" so the badge slot here carries the type instead of a status.
class _TypeBadge extends StatelessWidget {
  const _TypeBadge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppShapes.pillRadius),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.5)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: AppColors.primary,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
