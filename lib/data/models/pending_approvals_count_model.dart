/// Mirrors the backend's `GET /approvals/pending-count` response - a cheap
/// combined count (no row hydration) of pending items assigned to the
/// current user as approver, for a nav badge.
class PendingApprovalsCountModel {
  const PendingApprovalsCountModel({
    required this.leaveRequests,
    required this.leavePlanRequests,
    required this.total,
  });

  final int leaveRequests;
  final int leavePlanRequests;
  final int total;

  factory PendingApprovalsCountModel.fromJson(Map<String, dynamic> json) {
    return PendingApprovalsCountModel(
      leaveRequests: json['leave_requests'] as int,
      leavePlanRequests: json['leave_plan_requests'] as int,
      total: json['total'] as int,
    );
  }
}
