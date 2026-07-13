import 'package:dio/dio.dart';

import '../../core/errors/api_exception.dart';
import '../models/schedule_model.dart';

class ScheduleRepository {
  ScheduleRepository({required this._dio});

  final Dio _dio;

  /// `GET /schedule/?year&month` - public holidays + the caller's team's
  /// approved leave for the given month.
  Future<ScheduleModel> fetchSchedule({
    required int year,
    required int month,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/schedule/',
        queryParameters: {'year': year, 'month': month},
      );
      return ScheduleModel.fromJson(response.data!);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}
