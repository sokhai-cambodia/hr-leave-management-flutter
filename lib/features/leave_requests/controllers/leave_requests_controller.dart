import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/errors/api_exception.dart';
import '../../../data/models/leave_request_model.dart';
import '../../../data/models/leave_type_model.dart';
import '../../../data/repositories/leave_requests_repository.dart';
import '../../../data/repositories/leave_types_repository.dart';
import '../../auth/controllers/auth_controller.dart';

class LeaveRequestsController extends GetxController {
  LeaveRequestsController({required this.leaveRequestsRepository});

  final LeaveRequestsRepository leaveRequestsRepository;
  final _leaveTypesRepository = Get.find<LeaveTypesRepository>();
  final _authController = Get.find<AuthController>();

  // List View State
  final leaveRequests = <LeaveRequestModel>[].obs;
  final isLoading = false.obs;
  final isMoreLoading = false.obs;
  final hasMore = true.obs;
  final errorMessage = RxnString();
  int _skip = 0;
  static const int _limit = 20;

  // Detail View State
  final currentRequest = Rxn<LeaveRequestModel>();
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
    fetchLeaveRequests(isRefresh: true);
  }

  /// Fetches leave requests with pagination (infinite scroll). Scoped to
  /// the current user's own submissions (`owner_id`) - without this, the
  /// backend's base visibility scope for non-superusers also includes rows
  /// where the user is the approver, and superusers get every row in the
  /// system, both of which would show up mixed into what's meant to be a
  /// personal "my requests" list. The Approvals screen is the dedicated
  /// place to see items awaiting approval (Task 11.1).
  Future<void> fetchLeaveRequests({bool isRefresh = false}) async {
    if (isRefresh) {
      _skip = 0;
      hasMore.value = true;
      leaveRequests.clear();
      isLoading.value = true;
      errorMessage.value = null;
    } else {
      if (isMoreLoading.value || !hasMore.value) return;
      isMoreLoading.value = true;
    }

    try {
      final result = await leaveRequestsRepository.fetchLeaveRequests(
        skip: _skip,
        limit: _limit,
        ownerId: _authController.currentUser.value?.id,
      );

      leaveRequests.addAll(result.data);
      _skip += result.data.length;

      if (result.data.length < _limit || leaveRequests.length >= result.count) {
        hasMore.value = false;
      }
    } on ApiException catch (e) {
      if (isRefresh) {
        errorMessage.value = e.message;
      } else {
        Get.snackbar(
          'Error',
          'Failed to load more leave requests: ${e.message}',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } finally {
      isLoading.value = false;
      isMoreLoading.value = false;
    }
  }

  /// Fetches a single request's details
  Future<void> fetchRequestDetail(String id) async {
    isDetailLoading.value = true;
    detailErrorMessage.value = null;
    currentRequest.value = null;

    try {
      final request = await leaveRequestsRepository.fetchLeaveRequest(id);
      currentRequest.value = request;
    } on ApiException catch (e) {
      detailErrorMessage.value = e.message;
    } finally {
      isDetailLoading.value = false;
    }
  }

  /// Fetches active leave types for dropdown
  Future<void> fetchLeaveTypes() async {
    isLoadingLeaveTypes.value = true;
    formErrorMessage.value = null;
    try {
      final allTypes = await _leaveTypesRepository.fetchLeaveTypes();
      // Filter for active leave types
      leaveTypes.value = allTypes.where((t) => t.isActive).toList();
    } on ApiException catch (e) {
      formErrorMessage.value = e.message;
    } finally {
      isLoadingLeaveTypes.value = false;
    }
  }

  /// Creates a draft leave request
  Future<bool> createRequest({
    required DateTime startDate,
    required DateTime endDate,
    String? description,
    required String leaveTypeId,
  }) async {
    isSubmitting.value = true;
    formErrorMessage.value = null;

    try {
      final newRequest = await leaveRequestsRepository.createLeaveRequest(
        startDate: startDate,
        endDate: endDate,
        description: description,
        leaveTypeId: leaveTypeId,
      );
      // Insert at top of list
      leaveRequests.insert(0, newRequest);
      return true;
    } on ApiException catch (e) {
      formErrorMessage.value = e.message;
      return false;
    } finally {
      isSubmitting.value = false;
    }
  }

  /// Updates a draft leave request
  Future<bool> updateRequest(
    String id, {
    required DateTime startDate,
    required DateTime endDate,
    String? description,
    required String leaveTypeId,
  }) async {
    isSubmitting.value = true;
    formErrorMessage.value = null;

    try {
      final updatedRequest = await leaveRequestsRepository.updateLeaveRequest(
        id,
        startDate: startDate,
        endDate: endDate,
        description: description,
        leaveTypeId: leaveTypeId,
      );

      // Update in list
      final index = leaveRequests.indexWhere((r) => r.id == id);
      if (index != -1) {
        leaveRequests[index] = updatedRequest;
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

  /// Deletes a draft leave request
  Future<bool> deleteRequest(String id) async {
    try {
      await leaveRequestsRepository.deleteLeaveRequest(id);
      leaveRequests.removeWhere((r) => r.id == id);
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

  /// Creates a draft then immediately submits it (the form's "Submit"
  /// action). Returns the resulting request whether submission succeeded
  /// (status `pending`) or failed (stays `draft`, but the draft is still
  /// created and reachable in the list/detail) so the caller can navigate
  /// to it either way. Returns null only if creation itself failed.
  Future<LeaveRequestModel?> createAndSubmitRequest({
    required DateTime startDate,
    required DateTime endDate,
    String? description,
    required String leaveTypeId,
  }) async {
    isSubmitting.value = true;
    formErrorMessage.value = null;

    LeaveRequestModel created;
    try {
      created = await leaveRequestsRepository.createLeaveRequest(
        startDate: startDate,
        endDate: endDate,
        description: description,
        leaveTypeId: leaveTypeId,
      );
      leaveRequests.insert(0, created);
    } on ApiException catch (e) {
      formErrorMessage.value = e.message;
      isSubmitting.value = false;
      return null;
    }

    try {
      // Dio's own connect/receive timeouts don't cover this: on some devices
      // the request never reaches the transport layer at all (observed hang
      // in the token-read step of the auth interceptor, before dispatch), so
      // this call needs its own hard ceiling or a stall here would spin the
      // UI forever with no feedback - the created draft must stay reachable.
      final submitted = await leaveRequestsRepository
          .submitLeaveRequest(created.id)
          .timeout(
            const Duration(seconds: 20),
            onTimeout: () => throw ApiException(
              'The submit request timed out. Your draft was saved - open it '
              'from the list to retry submitting.',
            ),
          );
      final index = leaveRequests.indexWhere((r) => r.id == created.id);
      if (index != -1) {
        leaveRequests[index] = submitted;
      }
      Get.snackbar(
        'Success',
        'Leave request submitted successfully.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withValues(alpha: 0.1),
        colorText: Colors.green[800],
      );
      return submitted;
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
      return created;
    } finally {
      isSubmitting.value = false;
    }
  }

  /// Submits a draft leave request
  Future<bool> submitRequest(String id) async {
    isSubmitting.value = true;
    try {
      final updatedRequest = await leaveRequestsRepository.submitLeaveRequest(
        id,
      );

      // Update in list
      final index = leaveRequests.indexWhere((r) => r.id == id);
      if (index != -1) {
        leaveRequests[index] = updatedRequest;
      }
      if (currentRequest.value?.id == id) {
        currentRequest.value = updatedRequest;
      }

      // Show success message
      Get.snackbar(
        'Success',
        'Leave request submitted successfully.',
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
