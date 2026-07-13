import 'package:dio/dio.dart';

import '../../core/errors/api_exception.dart';
import '../models/notification_model.dart';

class NotificationsRepository {
  NotificationsRepository({required this._dio});

  final Dio _dio;

  Future<NotificationsPage> fetchNotifications({
    int skip = 0,
    int limit = 20,
    bool? isRead,
  }) async {
    try {
      final queryParameters = <String, dynamic>{'skip': skip, 'limit': limit};
      if (isRead != null) queryParameters['is_read'] = isRead;

      final response = await _dio.get<Map<String, dynamic>>(
        '/notifications/',
        queryParameters: queryParameters,
      );
      final data = response.data!['data'] as List;
      return NotificationsPage(
        data: data
            .map((e) => NotificationModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        count: response.data!['count'] as int,
        unreadCount: response.data!['unread_count'] as int,
      );
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  /// `GET /notifications/unread-count` - cheap count for badge polling, per
  /// the backend's documented recommendation (don't use
  /// [fetchNotifications] just to read a count).
  Future<int> fetchUnreadCount() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/notifications/unread-count',
      );
      return response.data!['count'] as int;
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<void> markRead(String id) async {
    try {
      await _dio.put('/notifications/$id/read');
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<void> markAllRead() async {
    try {
      await _dio.put('/notifications/mark-all-read');
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}
