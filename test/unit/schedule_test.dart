import 'package:flutter_test/flutter_test.dart';
import 'package:hr_leave_management/data/models/leave_balance_model.dart';
import 'package:hr_leave_management/data/models/public_holiday_model.dart';
import 'package:hr_leave_management/data/models/schedule_model.dart';
import 'package:hr_leave_management/data/models/user_summary.dart';
import 'package:hr_leave_management/features/schedule/controllers/schedule_controller.dart';

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

  group('ScheduleController.groupHolidaysByDay', () {
    test('groups same-day holidays into one entry with both items', () {
      final grouped = ScheduleController.groupHolidaysByDay([
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

  group('ScheduleController.groupTeamLeaveByDay', () {
    const owner = UserSummary(
      id: 'u1',
      email: 'alice@example.com',
      fullName: 'Alice',
    );
    const leaveType = LeaveTypeSummary(
      id: 'lt1',
      code: 'AL',
      name: 'Annual Leave',
    );

    test('a single-day entry produces exactly one key', () {
      const entry = TeamLeaveEntryModel(
        id: 'e1',
        source: 'leave_plan_request',
        owner: owner,
        leaveType: leaveType,
        startDate: '2026-07-20',
        endDate: '2026-07-20',
      );

      final grouped = ScheduleController.groupTeamLeaveByDay([entry]);

      expect(grouped.keys, [DateTime(2026, 7, 20)]);
      expect(grouped[DateTime(2026, 7, 20)], equals([entry]));
    });

    test('a multi-day range produces one key per covered day', () {
      const entry = TeamLeaveEntryModel(
        id: 'e2',
        source: 'leave_request',
        owner: owner,
        leaveType: leaveType,
        startDate: '2026-07-10',
        endDate: '2026-07-12',
      );

      final grouped = ScheduleController.groupTeamLeaveByDay([entry]);

      expect(
        grouped.keys,
        containsAll([
          DateTime(2026, 7, 10),
          DateTime(2026, 7, 11),
          DateTime(2026, 7, 12),
        ]),
      );
      expect(grouped[DateTime(2026, 7, 11)], equals([entry]));
    });

    test('two entries overlapping the same day both appear in that key', () {
      const entryA = TeamLeaveEntryModel(
        id: 'e3',
        source: 'leave_request',
        owner: owner,
        leaveType: leaveType,
        startDate: '2026-07-14',
        endDate: '2026-07-16',
      );
      const entryB = TeamLeaveEntryModel(
        id: 'e4',
        source: 'leave_plan_request',
        owner: owner,
        leaveType: leaveType,
        startDate: '2026-07-15',
        endDate: '2026-07-15',
      );

      final grouped = ScheduleController.groupTeamLeaveByDay([entryA, entryB]);

      expect(grouped[DateTime(2026, 7, 15)], containsAll([entryA, entryB]));
    });
  });
}
