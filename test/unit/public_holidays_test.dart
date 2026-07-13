import 'package:flutter_test/flutter_test.dart';
import 'package:hr_leave_management/data/models/public_holiday_model.dart';
import 'package:hr_leave_management/features/public_holidays/controllers/public_holidays_controller.dart';

void main() {
  const newYear = PublicHolidayModel(
    id: 'h1',
    date: '2026-01-01',
    name: "New Year's Day",
  );
  const secondNewYearEvent = PublicHolidayModel(
    id: 'h2',
    date: '2026-01-01',
    name: 'Bank Holiday',
  );
  const independenceDay = PublicHolidayModel(
    id: 'h3',
    date: '2026-07-04',
    name: 'Independence Day',
  );
  const decemberHoliday = PublicHolidayModel(
    id: 'h4',
    date: '2025-12-31',
    name: "New Year's Eve",
  );

  group('PublicHolidaysController.groupByDay', () {
    test('groups same-day holidays into one entry with both items', () {
      final grouped = PublicHolidaysController.groupByDay([
        newYear,
        secondNewYearEvent,
        independenceDay,
      ]);

      expect(grouped[DateTime(2026, 1, 1)], hasLength(2));
      expect(
        grouped[DateTime(2026, 1, 1)],
        containsAll([newYear, secondNewYearEvent]),
      );
      expect(grouped[DateTime(2026, 7, 4)], equals([independenceDay]));
    });
  });

  group('PublicHolidaysController.holidaysInMonth', () {
    test('filters to exactly the given month, handling a year boundary', () {
      final all = [newYear, secondNewYearEvent, independenceDay, decemberHoliday];

      final january2026 = PublicHolidaysController.holidaysInMonth(
        all,
        DateTime(2026, 1, 1),
      );
      expect(january2026, containsAll([newYear, secondNewYearEvent]));
      expect(january2026, isNot(contains(decemberHoliday)));

      final december2025 = PublicHolidaysController.holidaysInMonth(
        all,
        DateTime(2025, 12, 1),
      );
      expect(december2025, equals([decemberHoliday]));

      final july2026 = PublicHolidaysController.holidaysInMonth(
        all,
        DateTime(2026, 7, 1),
      );
      expect(july2026, equals([independenceDay]));
    });
  });
}
