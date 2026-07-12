import 'package:dio/dio.dart';

import '../../core/errors/api_exception.dart';
import '../models/paginated_result.dart';
import '../models/public_holiday_model.dart';

class PublicHolidaysRepository {
  PublicHolidaysRepository({required this._dio});

  final Dio _dio;

  Future<PaginatedResult<PublicHolidayModel>> fetchPublicHolidays({
    int skip = 0,
    int limit = 20,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/public-holidays/',
        queryParameters: {'skip': skip, 'limit': limit},
      );
      final data = response.data!['data'] as List;
      final count = response.data!['count'] as int;
      final list = data
          .map((e) => PublicHolidayModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return PaginatedResult(data: list, count: count);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<PublicHolidayModel> createPublicHoliday({
    required String date,
    required String name,
    String? description,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '/public-holidays/',
        data: {'date': date, 'name': name, 'description': description},
      );
      return PublicHolidayModel.fromJson(response.data!);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<PublicHolidayModel> updatePublicHoliday(
    String id, {
    required String date,
    required String name,
    String? description,
  }) async {
    try {
      final response = await _dio.put<Map<String, dynamic>>(
        '/public-holidays/$id',
        data: {'date': date, 'name': name, 'description': description},
      );
      return PublicHolidayModel.fromJson(response.data!);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<void> deletePublicHoliday(String id) async {
    try {
      await _dio.delete('/public-holidays/$id');
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}
