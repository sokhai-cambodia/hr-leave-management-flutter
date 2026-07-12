import 'package:get/get.dart';

import '../../../core/errors/api_exception.dart';
import '../../../data/models/leave_recommendation_model.dart';
import '../../../data/repositories/leave_types_repository.dart';
import '../../../data/repositories/recommends_repository.dart';

class RecommendationsController extends GetxController {
  RecommendationsController({
    required this.recommendsRepository,
    required this.leaveTypesRepository,
  });

  final RecommendsRepository recommendsRepository;
  final LeaveTypesRepository leaveTypesRepository;

  final selectedYear = DateTime.now().year.obs;
  final recommendations = Rxn<LeaveRecommendationsModel>();
  final leaveTypeName = RxnString();
  final isLoading = false.obs;
  final errorMessage = RxnString();

  @override
  void onInit() {
    super.onInit();
    fetchRecommendations();
  }

  void changeYear(int year) {
    if (year == selectedYear.value) return;
    selectedYear.value = year;
    fetchRecommendations();
  }

  Future<void> fetchRecommendations() async {
    isLoading.value = true;
    errorMessage.value = null;
    recommendations.value = null;
    leaveTypeName.value = null;

    try {
      final result = await recommendsRepository.fetchRecommendations(
        year: selectedYear.value,
      );
      recommendations.value = result;
      await _resolveLeaveTypeName(result.leaveTypeId);
    } on ApiException catch (e) {
      errorMessage.value = e.message;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _resolveLeaveTypeName(String leaveTypeId) async {
    try {
      final types = await leaveTypesRepository.fetchLeaveTypes();
      for (final type in types) {
        if (type.id == leaveTypeId) {
          leaveTypeName.value = type.name;
          break;
        }
      }
    } on ApiException {
      // Non-critical: the recommendation list still renders without a name.
    }
  }
}
