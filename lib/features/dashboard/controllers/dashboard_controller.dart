import 'package:get/get.dart';

import '../../../core/errors/api_exception.dart';
import '../../../data/models/leave_balance_model.dart';
import '../../../data/repositories/approvals_repository.dart';
import '../../../data/repositories/leave_balances_repository.dart';
import '../../../data/repositories/leave_plan_requests_repository.dart';
import '../../../data/repositories/leave_requests_repository.dart';
import '../../auth/controllers/auth_controller.dart';

class DashboardController extends GetxController {
  DashboardController({
    required this._leaveBalancesRepository,
    required this.leaveRequestsRepository,
    required this.leavePlanRequestsRepository,
    required this.approvalsRepository,
  });

  final LeaveBalancesRepository _leaveBalancesRepository;
  final LeaveRequestsRepository leaveRequestsRepository;
  final LeavePlanRequestsRepository leavePlanRequestsRepository;
  final ApprovalsRepository approvalsRepository;
  final _authController = Get.find<AuthController>();

  final balances = <LeaveBalanceModel>[].obs;
  final isLoadingBalances = true.obs;
  final balancesError = RxnString();

  final pendingRequestsCount = 0.obs;
  final isLoadingPendingCount = true.obs;
  final pendingCountError = RxnString();

  final pendingApprovalsCount = 0.obs;
  final isLoadingPendingApprovals = true.obs;
  final pendingApprovalsError = RxnString();

  @override
  void onInit() {
    super.onInit();
    fetchBalances();
    fetchPendingRequestsCount();
    fetchPendingApprovalsCount();
  }

  Future<void> fetchBalances() async {
    isLoadingBalances.value = true;
    balancesError.value = null;
    try {
      balances.value = await _leaveBalancesRepository.fetchMyBalances();
    } on ApiException catch (e) {
      balancesError.value = e.message;
    } finally {
      isLoadingBalances.value = false;
    }
  }

  /// "Pending Requests" on the dashboard means the employee's own
  /// submissions awaiting approval - distinct from "Pending Approvals"
  /// (items awaiting *my* approval as a team owner, see
  /// [fetchPendingApprovalsCount]). Backend-filtered via
  /// `owner_id`/`status` query params, reading just `count` at `limit: 1` -
  /// no row hydration or page-walking needed.
  Future<void> fetchPendingRequestsCount() async {
    isLoadingPendingCount.value = true;
    pendingCountError.value = null;
    try {
      final currentUserId = _authController.currentUser.value?.id;
      final requestsPage = await leaveRequestsRepository.fetchLeaveRequests(
        ownerId: currentUserId,
        status: 'pending',
        limit: 1,
      );
      final planRequestsPage = await leavePlanRequestsRepository
          .fetchLeavePlanRequests(
            ownerId: currentUserId,
            status: 'pending',
            limit: 1,
          );
      pendingRequestsCount.value = requestsPage.count + planRequestsPage.count;
    } on ApiException catch (e) {
      pendingCountError.value = e.message;
    } finally {
      isLoadingPendingCount.value = false;
    }
  }

  /// Total pending items assigned to the current user as approver
  /// (`GET /approvals/pending-count`) - drives the tappable "Pending
  /// Approvals" card, shown only to team owners (see
  /// `AuthController.isApprover`), which opens the Approvals queue.
  Future<void> fetchPendingApprovalsCount() async {
    isLoadingPendingApprovals.value = true;
    pendingApprovalsError.value = null;
    try {
      final result = await approvalsRepository.fetchPendingCount();
      pendingApprovalsCount.value = result.total;
    } on ApiException catch (e) {
      pendingApprovalsError.value = e.message;
    } finally {
      isLoadingPendingApprovals.value = false;
    }
  }
}
