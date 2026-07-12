import 'package:dio/dio.dart';

import '../../core/errors/api_exception.dart';
import '../models/team_model.dart';

/// `GET /teams` is open to any authenticated user (no superuser gate) —
/// it powers both the Phase 2 team-owner detection heuristic and, later,
/// the Phase 8 Teams admin screen.
class TeamsRepository {
  TeamsRepository({required this._dio});

  final Dio _dio;

  Future<List<TeamModel>> fetchTeams() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>('/teams/');
      final data = response.data!['data'] as List;
      return data
          .map((e) => TeamModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}
