import 'package:get/get.dart';

import '../../../core/errors/api_exception.dart';
import '../../../data/models/public_holiday_model.dart';
import '../../../data/models/schedule_model.dart';
import '../../../data/repositories/schedule_repository.dart';

class ScheduleController extends GetxController {
  ScheduleController({required this.scheduleRepository});

  final ScheduleRepository scheduleRepository;

  final schedule = Rxn<ScheduleModel>();
  final isLoading = true.obs;
  final errorMessage = RxnString();
  final focusedMonth = Rx<DateTime>(
    DateTime(DateTime.now().year, DateTime.now().month),
  );

  @override
  void onInit() {
    super.onInit();
    fetchSchedule();
  }

  /// Re-fetches for [focusedMonth] - unlike the old Public Holidays screen
  /// (Task 10.1), `GET /schedule/` is month-scoped server-side (no
  /// "fetch everything once" mode exists here), so changing months means a
  /// fresh network call, not a local re-filter.
  Future<void> fetchSchedule() async {
    isLoading.value = true;
    errorMessage.value = null;
    try {
      final month = focusedMonth.value;
      schedule.value = await scheduleRepository.fetchSchedule(
        year: month.year,
        month: month.month,
      );
    } on ApiException catch (e) {
      errorMessage.value = e.message;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> changeMonth(DateTime newMonth) async {
    focusedMonth.value = DateTime(newMonth.year, newMonth.month);
    await fetchSchedule();
  }

  /// Groups public holidays by day (day-normalized `DateTime`) for the
  /// calendar's marker lookup - dates parsed transiently here only, never
  /// round-tripped back to the wire (same rationale as Task 10.1's
  /// PublicHolidaysController.groupByDay, which this supersedes).
  static Map<DateTime, List<PublicHolidayModel>> groupHolidaysByDay(
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

  /// Expands each team-leave entry's [startDate, endDate] range into one
  /// key per covered day, so a multi-day leave request shows a marker on
  /// every day it spans, not just its start.
  static Map<DateTime, List<TeamLeaveEntryModel>> groupTeamLeaveByDay(
    List<TeamLeaveEntryModel> entries,
  ) {
    final grouped = <DateTime, List<TeamLeaveEntryModel>>{};
    for (final entry in entries) {
      var day = DateTime.parse(entry.startDate);
      final end = DateTime.parse(entry.endDate);
      while (!day.isAfter(end)) {
        final key = DateTime(day.year, day.month, day.day);
        grouped.putIfAbsent(key, () => []).add(entry);
        day = day.add(const Duration(days: 1));
      }
    }
    return grouped;
  }
}
