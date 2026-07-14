import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/theme/app_theme.dart';
import '../../../data/models/leave_plan_request_model.dart';
import '../controllers/leave_plan_requests_controller.dart';
import 'leave_plan_request_detail_view.dart';
import 'leave_plan_request_form_view.dart';

class LeavePlanRequestsView extends StatefulWidget {
  const LeavePlanRequestsView({super.key});

  @override
  State<LeavePlanRequestsView> createState() => _LeavePlanRequestsViewState();
}

class _LeavePlanRequestsViewState extends State<LeavePlanRequestsView> {
  final LeavePlanRequestsController controller =
      Get.find<LeavePlanRequestsController>();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      controller.fetchLeavePlanRequests(isRefresh: false);
    }
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
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

  @override
  Widget build(BuildContext context) {
    return Obx(() {
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
                Icon(Icons.error_outline, size: 64, color: AppColors.danger),
                const SizedBox(height: 16),
                Text(
                  controller.errorMessage.value!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () =>
                      controller.fetchLeavePlanRequests(isRefresh: true),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        );
      }

      if (controller.leavePlanRequests.isEmpty) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.event_note_outlined,
                  size: 64,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 16),
                const Text(
                  'No leave plan requests found.',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'Submit your first multi-date leave plan by tapping the + button.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[600]),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () =>
                      Get.to(() => const LeavePlanRequestFormView()),
                  child: const Text('Plan Leave'),
                ),
              ],
            ),
          ),
        );
      }

      return RefreshIndicator(
        onRefresh: () => controller.fetchLeavePlanRequests(isRefresh: true),
        child: ListView.builder(
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          itemCount:
              controller.leavePlanRequests.length +
              (controller.hasMore.value ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == controller.leavePlanRequests.length) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Center(
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(strokeWidth: 2.5),
                  ),
                ),
              );
            }

            final request = controller.leavePlanRequests[index];
            return _buildPlanCard(request);
          },
        ),
      );
    });
  }

  Widget _buildPlanCard(LeavePlanRequestModel request) {
    final statusColor = _getStatusColor(request.status);
    final sortedDetails = List<LeavePlanDetailModel>.from(request.details)
      ..sort((a, b) => a.leaveDate.compareTo(b.leaveDate));
    final datesPreview = sortedDetails
        .map((d) => _formatDate(d.leaveDate))
        .join(', ');

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () =>
            Get.to(() => LeavePlanRequestDetailView(requestId: request.id)),
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
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
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
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(
                    Icons.date_range_outlined,
                    size: 16,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${request.amount} ${request.amount == 1 ? "Date planned" : "Dates planned"}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
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
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
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
            ],
          ),
        ),
      ),
    );
  }
}
