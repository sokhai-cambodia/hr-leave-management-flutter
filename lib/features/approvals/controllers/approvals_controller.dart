import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/errors/api_exception.dart';
import '../../../data/models/leave_plan_request_model.dart';
import '../../../data/models/leave_request_model.dart';
import '../../../data/repositories/leave_plan_requests_repository.dart';
import '../../../data/repositories/leave_requests_repository.dart';
import '../../auth/controllers/auth_controller.dart';

class ApprovalsController extends GetxController {
  ApprovalsController({
    required this.leaveRequestsRepository,
    required this.leavePlanRequestsRepository,
  });

  final LeaveRequestsRepository leaveRequestsRepository;
  final LeavePlanRequestsRepository leavePlanRequestsRepository;
  final _authController = Get.find<AuthController>();

  final pendingLeaveRequests = <LeaveRequestModel>[].obs;
  final pendingLeavePlanRequests = <LeavePlanRequestModel>[].obs;
  final isLoading = false.obs;
  final errorMessage = RxnString();

  /// IDs currently being approved/rejected, so their row can show a spinner
  /// and ignore repeat taps instead of firing the action twice.
  final processingIds = <String>{}.obs;

  static const int _pageSize = 100;

  @override
  void onInit() {
    super.onInit();
    fetchApprovals();
  }

  Future<void> fetchApprovals() async {
    isLoading.value = true;
    errorMessage.value = null;

    try {
      final currentUserId = _authController.currentUser.value?.id;
      pendingLeaveRequests.value = await _fetchAllLeaveRequests(currentUserId);
      pendingLeavePlanRequests.value = await _fetchAllLeavePlanRequests(
        currentUserId,
      );
    } on ApiException catch (e) {
      errorMessage.value = e.message;
    } finally {
      isLoading.value = false;
    }
  }

  /// Backend-filtered to `approverId`/`status: pending` (Task 11.1), so the
  /// result set is already just the queue - still walks every page in case
  /// it exceeds one page, but no client-side filtering is needed anymore.
  Future<List<LeaveRequestModel>> _fetchAllLeaveRequests(
    String? approverId,
  ) async {
    final all = <LeaveRequestModel>[];
    var skip = 0;
    while (true) {
      final page = await leaveRequestsRepository.fetchLeaveRequests(
        skip: skip,
        limit: _pageSize,
        approverId: approverId,
        status: 'pending',
      );
      all.addAll(page.data);
      skip += page.data.length;
      if (page.data.length < _pageSize || all.length >= page.count) break;
    }
    return all;
  }

  Future<List<LeavePlanRequestModel>> _fetchAllLeavePlanRequests(
    String? approverId,
  ) async {
    final all = <LeavePlanRequestModel>[];
    var skip = 0;
    while (true) {
      final page = await leavePlanRequestsRepository.fetchLeavePlanRequests(
        skip: skip,
        limit: _pageSize,
        approverId: approverId,
        status: 'pending',
      );
      all.addAll(page.data);
      skip += page.data.length;
      if (page.data.length < _pageSize || all.length >= page.count) break;
    }
    return all;
  }

  Future<void> approveLeaveRequest(String id) async {
    if (!processingIds.add(id)) return;
    try {
      await leaveRequestsRepository.approveLeaveRequest(id);
      pendingLeaveRequests.removeWhere((r) => r.id == id);
      Get.snackbar(
        'Approved',
        'Leave request approved.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withValues(alpha: 0.1),
        colorText: Colors.green[800],
      );
    } on ApiException catch (e) {
      Get.snackbar(
        'Error',
        e.message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.1),
        colorText: Colors.red[800],
      );
    } finally {
      processingIds.remove(id);
    }
  }

  Future<void> rejectLeaveRequest(String id) async {
    if (!processingIds.add(id)) return;
    try {
      await leaveRequestsRepository.rejectLeaveRequest(id);
      pendingLeaveRequests.removeWhere((r) => r.id == id);
      Get.snackbar(
        'Rejected',
        'Leave request rejected.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange.withValues(alpha: 0.1),
        colorText: Colors.orange[800],
      );
    } on ApiException catch (e) {
      Get.snackbar(
        'Error',
        e.message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.1),
        colorText: Colors.red[800],
      );
    } finally {
      processingIds.remove(id);
    }
  }

  Future<void> approveLeavePlanRequest(String id) async {
    if (!processingIds.add(id)) return;
    try {
      await leavePlanRequestsRepository.approveLeavePlanRequest(id);
      pendingLeavePlanRequests.removeWhere((r) => r.id == id);
      Get.snackbar(
        'Approved',
        'Leave plan request approved.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withValues(alpha: 0.1),
        colorText: Colors.green[800],
      );
    } on ApiException catch (e) {
      Get.snackbar(
        'Error',
        e.message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.1),
        colorText: Colors.red[800],
      );
    } finally {
      processingIds.remove(id);
    }
  }

  Future<void> rejectLeavePlanRequest(String id) async {
    if (!processingIds.add(id)) return;
    try {
      await leavePlanRequestsRepository.rejectLeavePlanRequest(id);
      pendingLeavePlanRequests.removeWhere((r) => r.id == id);
      Get.snackbar(
        'Rejected',
        'Leave plan request rejected.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange.withValues(alpha: 0.1),
        colorText: Colors.orange[800],
      );
    } on ApiException catch (e) {
      Get.snackbar(
        'Error',
        e.message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.1),
        colorText: Colors.red[800],
      );
    } finally {
      processingIds.remove(id);
    }
  }
}
