import 'leave_balance_model.dart';
import 'user_summary.dart';

class LeaveRequestModel {
  const LeaveRequestModel({
    required this.id,
    required this.startDate,
    required this.endDate,
    this.description,
    required this.ownerId,
    required this.leaveTypeId,
    required this.amount,
    required this.status,
    required this.requestedAt,
    this.submittedAt,
    this.approverId,
    this.approvalAt,
    required this.owner,
    required this.leaveType,
    this.approver,
  });

  final String id;
  final DateTime startDate;
  final DateTime endDate;
  final String? description;
  final String ownerId;
  final String leaveTypeId;
  final double amount;
  final String status; // 'draft' | 'pending' | 'approved' | 'rejected'
  final DateTime requestedAt;
  final DateTime? submittedAt;
  final String? approverId;
  final DateTime? approvalAt;
  final UserSummary owner;
  final LeaveTypeSummary leaveType;
  final UserSummary? approver;

  factory LeaveRequestModel.fromJson(Map<String, dynamic> json) {
    return LeaveRequestModel(
      id: json['id'] as String,
      startDate: DateTime.parse(json['start_date'] as String),
      endDate: DateTime.parse(json['end_date'] as String),
      description: json['description'] as String?,
      ownerId: json['owner_id'] as String,
      leaveTypeId: json['leave_type_id'] as String,
      amount: (json['amount'] as num).toDouble(),
      status: json['status'] as String,
      requestedAt: DateTime.parse(json['requested_at'] as String),
      submittedAt: json['submitted_at'] != null
          ? DateTime.parse(json['submitted_at'] as String)
          : null,
      approverId: json['approver_id'] as String?,
      approvalAt: json['approval_at'] != null
          ? DateTime.parse(json['approval_at'] as String)
          : null,
      owner: UserSummary.fromJson(json['owner'] as Map<String, dynamic>),
      leaveType: LeaveTypeSummary.fromJson(
        json['leave_type'] as Map<String, dynamic>,
      ),
      approver: json['approver'] != null
          ? UserSummary.fromJson(json['approver'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'start_date': startDate.toIso8601String().split('T')[0],
      'end_date': endDate.toIso8601String().split('T')[0],
      'description': description,
      'owner_id': ownerId,
      'leave_type_id': leaveTypeId,
      'amount': amount,
      'status': status,
      'requested_at': requestedAt.toIso8601String(),
      'submitted_at': submittedAt?.toIso8601String(),
      'approver_id': approverId,
      'approval_at': approvalAt?.toIso8601String(),
      'owner': owner.toJson(),
      'leave_type': {
        'id': leaveType.id,
        'code': leaveType.code,
        'name': leaveType.name,
      },
      'approver': approver?.toJson(),
    };
  }

  bool get isDraft => status == 'draft';
  bool get isPending => status == 'pending';
  bool get isApproved => status == 'approved';
  bool get isRejected => status == 'rejected';
}
