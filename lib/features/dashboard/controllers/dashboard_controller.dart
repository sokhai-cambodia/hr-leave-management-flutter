import 'package:get/get.dart';

import '../../../core/errors/api_exception.dart';
import '../../../data/models/leave_balance_model.dart';
import '../../../data/repositories/leave_balances_repository.dart';

class DashboardController extends GetxController {
  DashboardController({required this._leaveBalancesRepository});

  final LeaveBalancesRepository _leaveBalancesRepository;

  final balances = <LeaveBalanceModel>[].obs;
  final isLoadingBalances = true.obs;
  final balancesError = RxnString();

  @override
  void onInit() {
    super.onInit();
    fetchBalances();
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
}
