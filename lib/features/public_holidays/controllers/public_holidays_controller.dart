import 'package:get/get.dart';

import '../../../core/errors/api_exception.dart';
import '../../../data/models/public_holiday_model.dart';
import '../../../data/repositories/public_holidays_repository.dart';

class PublicHolidaysController extends GetxController {
  PublicHolidaysController({required this.publicHolidaysRepository});

  final PublicHolidaysRepository publicHolidaysRepository;

  final holidays = <PublicHolidayModel>[].obs;
  final isLoading = false.obs;
  final errorMessage = RxnString();
  final focusedMonth = Rx<DateTime>(DateTime.now());

  @override
  void onInit() {
    super.onInit();
    fetchHolidays();
  }

  /// Single fetch with a generous limit - public holidays is a small
  /// admin-managed master-data table (no server-side month/year filter
  /// exists), same rationale as [TeamsAdminController]'s one-shot
  /// `fetchUsersPage(limit: 200)` for its owner picker.
  Future<void> fetchHolidays() async {
    isLoading.value = true;
    errorMessage.value = null;
    try {
      final page = await publicHolidaysRepository.fetchPublicHolidays(
        limit: 500,
      );
      holidays.value = page.data;
    } on ApiException catch (e) {
      errorMessage.value = e.message;
    } finally {
      isLoading.value = false;
    }
  }

  /// Groups holidays by day (day-normalized `DateTime`, no time component)
  /// so same-day duplicates group together. `date` is parsed from its wire
  /// "YYYY-MM-DD" string form transiently here only - never round-tripped
  /// back to the API, so no timezone-drift risk.
  static Map<DateTime, List<PublicHolidayModel>> groupByDay(
    List<PublicHolidayModel> holidays,
  ) {
    final grouped = <DateTime, List<PublicHolidayModel>>{};
    for (final holiday in holidays) {
      final parsed = DateTime.parse(holiday.date);
      final key = DateTime(parsed.year, parsed.month, parsed.day);
      grouped.putIfAbsent(key, () => []).add(holiday);
    }
    return grouped;
  }

  /// Filters holidays whose parsed date falls in the given [month]'s
  /// year/month, for the list-below-calendar section.
  static List<PublicHolidayModel> holidaysInMonth(
    List<PublicHolidayModel> holidays,
    DateTime month,
  ) {
    return holidays.where((holiday) {
      final parsed = DateTime.parse(holiday.date);
      return parsed.year == month.year && parsed.month == month.month;
    }).toList();
  }
}
