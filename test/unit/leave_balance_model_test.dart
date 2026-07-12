import 'package:flutter_test/flutter_test.dart';
import 'package:hr_leave_management/data/models/leave_balance_model.dart';

void main() {
  group('LeaveBalanceModel.fromJson', () {
    test('parses balance, taken_balance and available_balance as sent by the server', () {
      final balance = LeaveBalanceModel.fromJson({
        'id': 'b1',
        'year': '2026',
        'balance': 18,
        'taken_balance': 3.5,
        'available_balance': 14.5,
        'leave_type_id': 'lt1',
        'owner_id': 'u1',
        'leave_type': {'id': 'lt1', 'code': 'AL', 'name': 'Annual Leave'},
      });

      expect(balance.balance, 18.0);
      expect(balance.takenBalance, 3.5);
      expect(balance.availableBalance, 14.5);
      // available_balance is trusted from the server, not recomputed —
      // deliberately not asserting balance - takenBalance == availableBalance.
      expect(balance.leaveType.code, 'AL');
      expect(balance.leaveType.name, 'Annual Leave');
    });

    test('parses integer-valued balance fields sent without a decimal point', () {
      final balance = LeaveBalanceModel.fromJson({
        'id': 'b2',
        'year': '2026',
        'balance': 10,
        'taken_balance': 0,
        'available_balance': 10,
        'leave_type': {'id': 'lt2', 'code': 'SL', 'name': 'Sick Leave'},
      });

      expect(balance.balance, 10.0);
      expect(balance.takenBalance, 0.0);
      expect(balance.availableBalance, 10.0);
    });
  });
}
