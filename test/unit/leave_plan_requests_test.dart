import 'package:flutter_test/flutter_test.dart';
import 'package:hr_leave_management/features/leave_plan_requests/controllers/leave_plan_requests_controller.dart';

void main() {
  group('LeavePlanRequestsController.isDuplicateDate', () {
    test('detects duplicate dates correctly regardless of time of day', () {
      final dates = [
        DateTime(2026, 7, 12),
        DateTime(2026, 7, 15),
      ];

      // Exact match
      expect(
        LeavePlanRequestsController.isDuplicateDate(dates, DateTime(2026, 7, 12)),
        isTrue,
      );
      expect(
        LeavePlanRequestsController.isDuplicateDate(dates, DateTime(2026, 7, 15)),
        isTrue,
      );

      // Different time of day on same date
      expect(
        LeavePlanRequestsController.isDuplicateDate(
          dates,
          DateTime(2026, 7, 12, 14, 30, 45),
        ),
        isTrue,
      );

      // Distinct dates (no match)
      expect(
        LeavePlanRequestsController.isDuplicateDate(dates, DateTime(2026, 7, 13)),
        isFalse,
      );
      expect(
        LeavePlanRequestsController.isDuplicateDate(dates, DateTime(2025, 7, 12)),
        isFalse,
      );
    });
  });
}
