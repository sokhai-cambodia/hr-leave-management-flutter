import 'package:dio/dio.dart';

import '../../core/errors/api_exception.dart';
import '../models/leave_type_model.dart';

class LeaveTypesRepository {
  LeaveTypesRepository({required this._dio});

  final Dio _dio;

  /// Fetches all leave types.
  Future<List<LeaveTypeModel>> fetchLeaveTypes() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>('/leave-types/');
      final data = response.data!['data'] as List;
      return data
          .map((e) => LeaveTypeModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}
