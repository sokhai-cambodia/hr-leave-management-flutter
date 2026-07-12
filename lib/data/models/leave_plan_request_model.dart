import 'leave_balance_model.dart';
import 'user_summary.dart';

class LeavePlanDetailModel {
  const LeavePlanDetailModel({
    this.id,
    required this.leaveDate,
  });

  final String? id;
  final DateTime leaveDate;

  factory LeavePlanDetailModel.fromJson(Map<String, dynamic> json) {
    return LeavePlanDetailModel(
      id: json['id'] as String?,
      leaveDate: DateTime.parse(json['leave_date'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'leave_date': leaveDate.toIso8601String().split('T')[0],
    };
  }
}

class LeavePlanRequestModel {
  const LeavePlanRequestModel({
    required this.id,
    this.description,
    required this.ownerId,
    required this.leaveTypeId,
    required this.requestedAt,
    this.submittedAt,
    this.approverId,
    this.approvalAt,
    required this.status,
    required this.amount,
    required this.details,
    required this.owner,
    required this.leaveType,
    this.approver,
  });

  final String id;
  final String? description;
  final String ownerId;
  final String leaveTypeId;
  final DateTime requestedAt;
  final DateTime? submittedAt;
  final String? approverId;
  final DateTime? approvalAt;
  final String status; // 'draft' | 'pending' | 'approved' | 'rejected'
  final int amount;
  final List<LeavePlanDetailModel> details;
  final UserSummary owner;
  final LeaveTypeSummary leaveType;
  final UserSummary? approver;

  factory LeavePlanRequestModel.fromJson(Map<String, dynamic> json) {
    final detailsList = json['details'] as List? ?? [];
    return LeavePlanRequestModel(
      id: json['id'] as String,
      description: json['description'] as String?,
      ownerId: json['owner_id'] as String,
      leaveTypeId: json['leave_type_id'] as String,
      requestedAt: DateTime.parse(json['requested_at'] as String),
      submittedAt: json['submitted_at'] != null
          ? DateTime.parse(json['submitted_at'] as String)
          : null,
      approverId: json['approver_id'] as String?,
      approvalAt: json['approval_at'] != null
          ? DateTime.parse(json['approval_at'] as String)
          : null,
      status: json['status'] as String,
      amount: json['amount'] as int,
      details: detailsList
          .map((e) => LeavePlanDetailModel.fromJson(e as Map<String, dynamic>))
          .toList(),
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
      'description': description,
      'owner_id': ownerId,
      'leave_type_id': leaveTypeId,
      'requested_at': requestedAt.toIso8601String(),
      'submitted_at': submittedAt?.toIso8601String(),
      'approver_id': approverId,
      'approval_at': approvalAt?.toIso8601String(),
      'status': status,
      'amount': amount,
      'details': details.map((d) => d.toJson()).toList(),
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
