import 'user_summary.dart';

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

/// Mirrors the backend's `LeaveBalancePublic` response, returned by both
/// `GET /leave-balances/me` (owner/owner_id present but unused there) and
/// the admin `GET /leave-balances/` list. `available_balance` is trusted as
/// sent by the server (`balance - taken_balance`), never recomputed
/// client-side. `ownerId`/`owner` are nullable since the `/me` endpoint's
/// caller already knows the owner is themselves and doesn't need them.
class LeaveBalanceModel {
  const LeaveBalanceModel({
    required this.id,
    required this.year,
    required this.balance,
    required this.takenBalance,
    required this.availableBalance,
    required this.leaveType,
    this.ownerId,
    this.owner,
  });

  final String id;
  final String year;
  final double balance;
  final double takenBalance;
  final double availableBalance;
  final LeaveTypeSummary leaveType;
  final String? ownerId;
  final UserSummary? owner;

  factory LeaveBalanceModel.fromJson(Map<String, dynamic> json) {
    final ownerJson = json['owner'] as Map<String, dynamic>?;
    return LeaveBalanceModel(
      id: json['id'] as String,
      year: json['year'] as String,
      balance: (json['balance'] as num).toDouble(),
      takenBalance: (json['taken_balance'] as num).toDouble(),
      availableBalance: (json['available_balance'] as num).toDouble(),
      leaveType: LeaveTypeSummary.fromJson(
        json['leave_type'] as Map<String, dynamic>,
      ),
      ownerId: json['owner_id'] as String?,
      owner: ownerJson != null ? UserSummary.fromJson(ownerJson) : null,
    );
  }
}
