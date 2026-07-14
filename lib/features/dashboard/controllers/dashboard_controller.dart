import 'package:get/get.dart';

import '../../../core/errors/api_exception.dart';
import '../../../data/models/leave_balance_model.dart';
import '../../../data/repositories/approvals_repository.dart';
import '../../../data/repositories/leave_balances_repository.dart';

class DashboardController extends GetxController {
  DashboardController({
    required this._leaveBalancesRepository,
    required this.approvalsRepository,
  });

  final LeaveBalancesRepository _leaveBalancesRepository;
  final ApprovalsRepository approvalsRepository;

  final balances = <LeaveBalanceModel>[].obs;
  final isLoadingBalances = true.obs;
  final balancesError = RxnString();

  final pendingApprovalsCount = 0.obs;
  final isLoadingPendingApprovals = true.obs;
  final pendingApprovalsError = RxnString();

  @override
  void onInit() {
    super.onInit();
    fetchBalances();
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
