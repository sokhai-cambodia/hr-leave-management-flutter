import 'package:dio/dio.dart';

import '../../core/errors/api_exception.dart';
import '../models/leave_recommendation_model.dart';

class RecommendsRepository {
  RecommendsRepository({required this._dio});

  final Dio _dio;

  /// Fetches AI-recommended leave-plan dates for the given year.
  ///
  /// The backend returns 404 for two distinct cases ("no plannable leave
  /// type" vs "no remaining balance") — both surface via [ApiException] with
  /// the backend's actual detail message, so callers must not collapse them
  /// into one generic "not found" state.
  Future<LeaveRecommendationsModel> fetchRecommendations({
    required int year,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/recommends/leave-plan',
        queryParameters: {'year': year},
      );
      return LeaveRecommendationsModel.fromJson(response.data!);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}
