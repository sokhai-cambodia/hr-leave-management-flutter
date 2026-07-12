class LeaveTypeSummary {
  const LeaveTypeSummary({
    required this.id,
    required this.code,
    required this.name,
  });

  final String id;
  final String code;
  final String name;

  factory LeaveTypeSummary.fromJson(Map<String, dynamic> json) {
    return LeaveTypeSummary(
      id: json['id'] as String,
      code: json['code'] as String,
      name: json['name'] as String,
    );
  }
}

/// Mirrors the backend's `LeaveBalancePublic` response from
/// `GET /leave-balances/me`. `available_balance` is trusted as sent by the
/// server (`balance - taken_balance`), never recomputed client-side.
class LeaveBalanceModel {
  const LeaveBalanceModel({
    required this.id,
    required this.year,
    required this.balance,
    required this.takenBalance,
    required this.availableBalance,
    required this.leaveType,
  });

  final String id;
  final String year;
  final double balance;
  final double takenBalance;
  final double availableBalance;
  final LeaveTypeSummary leaveType;

  factory LeaveBalanceModel.fromJson(Map<String, dynamic> json) {
    return LeaveBalanceModel(
      id: json['id'] as String,
      year: json['year'] as String,
      balance: (json['balance'] as num).toDouble(),
      takenBalance: (json['taken_balance'] as num).toDouble(),
      availableBalance: (json['available_balance'] as num).toDouble(),
      leaveType: LeaveTypeSummary.fromJson(
        json['leave_type'] as Map<String, dynamic>,
      ),
    );
  }
}
