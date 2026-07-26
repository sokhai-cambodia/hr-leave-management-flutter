import 'user_summary.dart';

/// Mirrors the backend's `AuditLogPublic` shape (`GET /audit-logs/`).
/// Read-only trail - there is no create/edit/delete for this resource, it's
/// written internally by the backend's `AuditService` as a side effect of
/// the mutations it describes (see `SPEC.md` §7).
class AuditLogModel {
  const AuditLogModel({
    required this.id,
    required this.action,
    required this.entityType,
    required this.entityId,
    required this.summary,
    required this.createdAt,
    this.actor,
  });

  final String id;
  final String action; // create, update, delete, submit, approve, reject
  final String entityType; // e.g. "leave_type", "leave_request"
  final String entityId;
  final String summary;
  final DateTime createdAt;

  /// The user who performed the action - null if that user was later
  /// deleted (the backend FK is `ON DELETE SET NULL`, so the entry survives).
  final UserSummary? actor;

  factory AuditLogModel.fromJson(Map<String, dynamic> json) {
    final actorJson = json['actor'] as Map<String, dynamic>?;
    return AuditLogModel(
      id: json['id'] as String,
      action: json['action'] as String,
      entityType: json['entity_type'] as String,
      entityId: json['entity_id'] as String,
      summary: json['summary'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      actor: actorJson != null ? UserSummary.fromJson(actorJson) : null,
    );
  }
}
