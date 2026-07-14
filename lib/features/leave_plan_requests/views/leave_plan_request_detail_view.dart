import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/theme/app_theme.dart';
import '../../../data/models/leave_plan_request_model.dart';
import '../controllers/leave_plan_requests_controller.dart';
import 'leave_plan_request_form_view.dart';

class LeavePlanRequestDetailView extends StatefulWidget {
  const LeavePlanRequestDetailView({super.key, required this.requestId});

  final String requestId;

  @override
  State<LeavePlanRequestDetailView> createState() =>
      _LeavePlanRequestDetailViewState();
}

class _LeavePlanRequestDetailViewState
    extends State<LeavePlanRequestDetailView> {
  final LeavePlanRequestsController controller =
      Get.find<LeavePlanRequestsController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchRequestDetail(widget.requestId);
    });
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '-';
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  String _formatDateTime(DateTime? date) {
    if (date == null) return '-';
    final dateStr = _formatDate(date);
    final timeStr =
        '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    return '$dateStr $timeStr';
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return AppColors.success;
      case 'pending':
        return AppColors.warning;
      case 'rejected':
        return AppColors.danger;
      case 'draft':
      default:
        return Colors.grey;
    }
  }

  void _confirmDelete(BuildContext context, String id) {
    Get.dialog(
      AlertDialog(
        title: const Text('Delete Leave Plan'),
        content: const Text(
          'Are you sure you want to delete this draft leave plan request? This action cannot be undone.',
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          TextButton(
            onPressed: () async {
              Get.back(); // close dialog
              final success = await controller.deleteRequest(id);
              if (success) {
                Get.back(); // go back to list
                Get.snackbar(
                  'Success',
                  'Leave plan request deleted successfully.',
                  snackPosition: SnackPosition.BOTTOM,
                );
              }
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.danger),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plan Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        if (controller.isDetailLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.detailErrorMessage.value != null) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64, color: AppColors.danger),
                  const SizedBox(height: 16),
                  Text(
                    controller.detailErrorMessage.value!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () =>
                        controller.fetchRequestDetail(widget.requestId),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        }

        final request = controller.currentRequest.value;
        if (request == null) {
          return const Center(child: Text('Leave plan request not found.'));
        }

        final statusColor = _getStatusColor(request.status);
        final sortedDetails = List<LeavePlanDetailModel>.from(request.details)
          ..sort((a, b) => a.leaveDate.compareTo(b.leaveDate));

        return Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  // Main Info Card
                  Card(
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
                                  request.leaveType.name,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: statusColor.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: statusColor.withValues(alpha: 0.5),
                                  ),
                                ),
                                child: Text(
                                  request.status.toUpperCase(),
                                  style: TextStyle(
                                    color: statusColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const Divider(),
                          const SizedBox(height: 12),
                          _buildDetailRow(
                            Icons.schedule_outlined,
                            'Total Planned Days',
                            '${request.amount} ${request.amount == 1 ? "Day" : "Days"}',
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Planned Dates Card
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Planned Dates',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          if (sortedDetails.isEmpty)
                            const Text('No dates planned.')
                          else
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: sortedDetails.map((detail) {
                                return Chip(
                                  label: Text(
                                    _formatDate(detail.leaveDate),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  avatar: const Icon(
                                    Icons.calendar_today_outlined,
                                    size: 14,
                                  ),
                                  backgroundColor: Theme.of(context).cardColor,
                                );
                              }).toList(),
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Description Card
                  if (request.description != null &&
                      request.description!.isNotEmpty) ...[
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Description',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              request.description!,
                              style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 14,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],

                  // Timeline / Lifecycle metadata Card
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Request Timeline & Workflow',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildTimelineRow(
                            'Created by',
                            request.owner.fullName ?? request.owner.email,
                            true,
                          ),
                          _buildTimelineRow(
                            'Created at',
                            _formatDateTime(request.requestedAt),
                            true,
                          ),
                          _buildTimelineRow(
                            'Submitted at',
                            request.submittedAt != null
                                ? _formatDateTime(request.submittedAt)
                                : 'Not submitted yet',
                            request.submittedAt != null,
                          ),
                          _buildTimelineRow(
                            'Line approver',
                            request.approver?.fullName ??
                                request.approver?.email ??
                                'None assigned',
                            request.approver != null,
                          ),
                          if (request.status == 'approved' ||
                              request.status == 'rejected')
                            _buildTimelineRow(
                              request.status == 'approved'
                                  ? 'Approved at'
                                  : 'Rejected at',
                              _formatDateTime(request.approvalAt),
                              true,
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Sticky Bottom Panel for Draft Actions
            if (request.isDraft)
              SafeArea(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, -4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Obx(
                        () => controller.isSubmitting.value
                            ? const Center(child: CircularProgressIndicator())
                            : Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () =>
                                          controller.submitRequest(request.id),
                                      child: const Text('Submit Request'),
                                    ),
                                  ),
                                ],
                              ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () => Get.to(
                                () =>
                                    LeavePlanRequestFormView(request: request),
                              ),
                              icon: const Icon(Icons.edit_outlined),
                              label: const Text('Edit Plan'),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () =>
                                  _confirmDelete(context, request.id),
                              icon: const Icon(Icons.delete_outline),
                              label: const Text('Delete'),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: AppColors.danger,
                                side: BorderSide(
                                  color: AppColors.danger.withValues(
                                    alpha: 0.5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
          ],
        );
      }),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: Colors.grey[600]),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTimelineRow(String label, String value, bool isSubTextActive) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 4),
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: isSubTextActive ? AppColors.primary : Colors.grey[400],
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label,
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: isSubTextActive ? Colors.black87 : Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
