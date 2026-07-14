import 'package:dio/dio.dart';

import '../../core/errors/api_exception.dart';
import '../models/pending_approvals_count_model.dart';

class ApprovalsRepository {
  ApprovalsRepository({required this._dio});

  final Dio _dio;

  /// `GET /approvals/pending-count` - cheap combined count of pending items
  /// assigned to the current user as approver, for a nav badge. The full
  /// queue itself still comes from `LeaveRequestsRepository`/
  /// `LeavePlanRequestsRepository` filtered by `approverId`/`status`.
  Future<PendingApprovalsCountModel> fetchPendingCount() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/approvals/pending-count',
      );
      return PendingApprovalsCountModel.fromJson(response.data!);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}
