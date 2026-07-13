import 'package:get/get.dart';

import '../../../core/errors/api_exception.dart';
import '../../../data/models/leave_balance_model.dart';
import '../../../data/models/leave_plan_request_model.dart';
import '../../../data/models/leave_request_model.dart';
import '../../../data/repositories/leave_balances_repository.dart';
import '../../../data/repositories/leave_plan_requests_repository.dart';
import '../../../data/repositories/leave_requests_repository.dart';
import '../../auth/controllers/auth_controller.dart';

class DashboardController extends GetxController {
  DashboardController({
    required this._leaveBalancesRepository,
    required this.leaveRequestsRepository,
    required this.leavePlanRequestsRepository,
  });

  final LeaveBalancesRepository _leaveBalancesRepository;
  final LeaveRequestsRepository leaveRequestsRepository;
  final LeavePlanRequestsRepository leavePlanRequestsRepository;
  final _authController = Get.find<AuthController>();

  final balances = <LeaveBalanceModel>[].obs;
  final isLoadingBalances = true.obs;
  final balancesError = RxnString();

  final pendingRequestsCount = 0.obs;
  final isLoadingPendingCount = true.obs;
  final pendingCountError = RxnString();

  static const int _pageSize = 100;

  @override
  void onInit() {
    super.onInit();
    fetchBalances();
    fetchPendingRequestsCount();
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
  /// submissions awaiting approval - distinct from the Approvals queue
  /// (items awaiting *my* approval as a team owner). The backend has no
  /// "my pending requests" endpoint or status filter, so every page is
  /// walked and filtered client-side, same pattern/rationale as
  /// ApprovalsController.fetchApprovals.
  Future<void> fetchPendingRequestsCount() async {
    isLoadingPendingCount.value = true;
    pendingCountError.value = null;
    try {
      final currentUserId = _authController.currentUser.value?.id;
      final requests = await _fetchAllLeaveRequests();
      final planRequests = await _fetchAllLeavePlanRequests();

      final requestsCount = requests
          .where((r) => r.isPending && r.ownerId == currentUserId)
          .length;
      final planRequestsCount = planRequests
          .where((r) => r.isPending && r.ownerId == currentUserId)
          .length;
      pendingRequestsCount.value = requestsCount + planRequestsCount;
    } on ApiException catch (e) {
      pendingCountError.value = e.message;
    } finally {
      isLoadingPendingCount.value = false;
    }
  }

  Future<List<LeaveRequestModel>> _fetchAllLeaveRequests() async {
    final all = <LeaveRequestModel>[];
    var skip = 0;
    while (true) {
      final page = await leaveRequestsRepository.fetchLeaveRequests(
        skip: skip,
        limit: _pageSize,
      );
      all.addAll(page.data);
      skip += page.data.length;
      if (page.data.length < _pageSize || all.length >= page.count) break;
    }
    return all;
  }

  Future<List<LeavePlanRequestModel>> _fetchAllLeavePlanRequests() async {
    final all = <LeavePlanRequestModel>[];
    var skip = 0;
    while (true) {
      final page = await leavePlanRequestsRepository.fetchLeavePlanRequests(
        skip: skip,
        limit: _pageSize,
      );
      all.addAll(page.data);
      skip += page.data.length;
      if (page.data.length < _pageSize || all.length >= page.count) break;
    }
    return all;
  }
}
