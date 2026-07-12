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
  final selectedDates = <DateTime>{}.obs;

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

  bool isSelected(DateTime date) => selectedDates.contains(date);

  void toggleDateSelection(DateTime date) {
    if (selectedDates.contains(date)) {
      selectedDates.remove(date);
    } else {
      selectedDates.add(date);
    }
  }

  bool get isAllSelected {
    final dates = recommendations.value?.data ?? const [];
    return dates.isNotEmpty &&
        dates.every((item) => selectedDates.contains(item.leaveDate));
  }

  void toggleSelectAll() {
    final dates = recommendations.value?.data ?? const [];
    if (isAllSelected) {
      selectedDates.clear();
    } else {
      selectedDates.addAll(dates.map((item) => item.leaveDate));
    }
  }

  Future<void> fetchRecommendations() async {
    isLoading.value = true;
    errorMessage.value = null;
    recommendations.value = null;
    leaveTypeName.value = null;
    selectedDates.clear();

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
