import 'user_summary.dart';

/// Mirrors the backend's `NotificationPublic` shape (`GET /notifications/`).
class NotificationModel {
  const NotificationModel({
    required this.id,
    required this.eventType,
    required this.entityType,
    required this.entityId,
    required this.message,
    required this.isRead,
    required this.createdAt,
    this.actor,
  });

  final String id;
  final String eventType; // e.g. "leave_request.submitted"
  final String entityType; // "leave_request" | "leave_plan_request"
  final String entityId;
  final String message;
  final bool isRead;
  final DateTime createdAt;

  /// The user who triggered the event - null if that user was later
  /// deleted (per PROJECT_FEATURES.md's documented nullability).
  final UserSummary? actor;

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    final actorJson = json['actor'] as Map<String, dynamic>?;
    return NotificationModel(
      id: json['id'] as String,
      eventType: json['event_type'] as String,
      entityType: json['entity_type'] as String,
      entityId: json['entity_id'] as String,
      message: json['message'] as String,
      isRead: json['is_read'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
      actor: actorJson != null ? UserSummary.fromJson(actorJson) : null,
    );
  }

  NotificationModel copyWith({bool? isRead}) {
    return NotificationModel(
      id: id,
      eventType: eventType,
      entityType: entityType,
      entityId: entityId,
      message: message,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt,
      actor: actor,
    );
  }
}

/// `NotificationsPublic` - unlike `PaginatedResult`, also carries
/// `unread_count`, which is always the caller's total unread count
/// regardless of any `is_read` filter applied to `data`/`count`.
class NotificationsPage {
  const NotificationsPage({
    required this.data,
    required this.count,
    required this.unreadCount,
  });

  final List<NotificationModel> data;
  final int count;
  final int unreadCount;
}
