import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/errors/api_exception.dart';
import '../../../data/models/leave_plan_request_model.dart';
import '../../../data/models/leave_type_model.dart';
import '../../../data/repositories/leave_plan_requests_repository.dart';
import '../../../data/repositories/leave_types_repository.dart';

class LeavePlanRequestsController extends GetxController {
  LeavePlanRequestsController({
    required this.leavePlanRequestsRepository,
  });

  final LeavePlanRequestsRepository leavePlanRequestsRepository;
  final _leaveTypesRepository = Get.find<LeaveTypesRepository>();

  // List View State
  final leavePlanRequests = <LeavePlanRequestModel>[].obs;
  final isLoading = false.obs;
  final isMoreLoading = false.obs;
  final hasMore = true.obs;
  final errorMessage = RxnString();
  int _skip = 0;
  static const int _limit = 20;

  // Detail View State
  final currentRequest = Rxn<LeavePlanRequestModel>();
  final isDetailLoading = false.obs;
  final detailErrorMessage = RxnString();

  // Form View State
  final leaveTypes = <LeaveTypeModel>[].obs;
  final isLoadingLeaveTypes = false.obs;
  final formErrorMessage = RxnString();
  final isSubmitting = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchLeavePlanRequests(isRefresh: true);
  }

  /// Pure, testable function to verify if a new date is already in the list
  static bool isDuplicateDate(List<DateTime> dates, DateTime newDate) {
    return dates.any((d) =>
        d.year == newDate.year &&
        d.month == newDate.month &&
        d.day == newDate.day);
  }

  /// Fetches leave plan requests with pagination (infinite scroll)
  Future<void> fetchLeavePlanRequests({bool isRefresh = false}) async {
    if (isRefresh) {
      _skip = 0;
      hasMore.value = true;
      leavePlanRequests.clear();
      isLoading.value = true;
      errorMessage.value = null;
    } else {
      if (isMoreLoading.value || !hasMore.value) return;
      isMoreLoading.value = true;
    }

    try {
      final result = await leavePlanRequestsRepository.fetchLeavePlanRequests(
        skip: _skip,
        limit: _limit,
      );

      leavePlanRequests.addAll(result.data);
      _skip += result.data.length;

      if (result.data.length < _limit || leavePlanRequests.length >= result.count) {
        hasMore.value = false;
      }
    } on ApiException catch (e) {
      if (isRefresh) {
        errorMessage.value = e.message;
      } else {
        Get.snackbar(
          'Error',
          'Failed to load more leave plan requests: ${e.message}',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } finally {
      isLoading.value = false;
      isMoreLoading.value = false;
    }
  }

  /// Fetches a single leave plan request's details
  Future<void> fetchRequestDetail(String id) async {
    isDetailLoading.value = true;
    detailErrorMessage.value = null;
    currentRequest.value = null;

    try {
      final request = await leavePlanRequestsRepository.fetchLeavePlanRequest(id);
      currentRequest.value = request;
    } on ApiException catch (e) {
      detailErrorMessage.value = e.message;
    } finally {
      isDetailLoading.value = false;
    }
  }

  /// Fetches active leave types filtered for planning (is_allow_plan == true)
  Future<void> fetchLeaveTypes() async {
    isLoadingLeaveTypes.value = true;
    formErrorMessage.value = null;
    try {
      final allTypes = await _leaveTypesRepository.fetchLeaveTypes();
      // Filter for active leave types that allow plan
      leaveTypes.value = allTypes
          .where((t) => t.isActive && t.isAllowPlan)
          .toList();
    } on ApiException catch (e) {
      formErrorMessage.value = e.message;
    } finally {
      isLoadingLeaveTypes.value = false;
    }
  }

  /// Creates a draft leave plan request
  Future<bool> createRequest({
    String? description,
    required String leaveTypeId,
    required List<DateTime> dates,
  }) async {
    isSubmitting.value = true;
    formErrorMessage.value = null;

    try {
      final newRequest = await leavePlanRequestsRepository.createLeavePlanRequest(
        description: description,
        leaveTypeId: leaveTypeId,
        dates: dates,
      );
      leavePlanRequests.insert(0, newRequest);
      return true;
    } on ApiException catch (e) {
      formErrorMessage.value = e.message;
      return false;
    } finally {
      isSubmitting.value = false;
    }
  }

  /// Updates a draft leave plan request
  Future<bool> updateRequest(
    String id, {
    String? description,
    required String leaveTypeId,
    required List<DateTime> dates,
  }) async {
    isSubmitting.value = true;
    formErrorMessage.value = null;

    try {
      final updatedRequest = await leavePlanRequestsRepository.updateLeavePlanRequest(
        id,
        description: description,
        leaveTypeId: leaveTypeId,
        dates: dates,
      );

      final index = leavePlanRequests.indexWhere((r) => r.id == id);
      if (index != -1) {
        leavePlanRequests[index] = updatedRequest;
      }
      if (currentRequest.value?.id == id) {
        currentRequest.value = updatedRequest;
      }
      return true;
    } on ApiException catch (e) {
      formErrorMessage.value = e.message;
      return false;
    } finally {
      isSubmitting.value = false;
    }
  }

  /// Deletes a draft leave plan request
  Future<bool> deleteRequest(String id) async {
    try {
      await leavePlanRequestsRepository.deleteLeavePlanRequest(id);
      leavePlanRequests.removeWhere((r) => r.id == id);
      if (currentRequest.value?.id == id) {
        currentRequest.value = null;
      }
      return true;
    } on ApiException catch (e) {
      Get.snackbar(
        'Error',
        'Failed to delete request: ${e.message}',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  }

  /// Submits a draft leave plan request
  Future<bool> submitRequest(String id) async {
    isSubmitting.value = true;
    try {
      final updatedRequest = await leavePlanRequestsRepository.submitLeavePlanRequest(id);

      final index = leavePlanRequests.indexWhere((r) => r.id == id);
      if (index != -1) {
        leavePlanRequests[index] = updatedRequest;
      }
      if (currentRequest.value?.id == id) {
        currentRequest.value = updatedRequest;
      }

      Get.snackbar(
        'Success',
        'Leave plan request submitted successfully.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withValues(alpha: 0.1),
        colorText: Colors.green[800],
      );

      return true;
    } on ApiException catch (e) {
      String userFriendlyMessage = e.message;
      if (e.statusCode == 422 || e.message.contains('No approver found')) {
        userFriendlyMessage =
            "You don't have a line approver assigned yet, contact an admin";
      }
      Get.snackbar(
        'Submission Failed',
        userFriendlyMessage,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.1),
        colorText: Colors.red[800],
        duration: const Duration(seconds: 5),
      );
      return false;
    } finally {
      isSubmitting.value = false;
    }
  }
}
