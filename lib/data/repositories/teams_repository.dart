import 'package:dio/dio.dart';

import '../../core/errors/api_exception.dart';
import '../models/paginated_result.dart';
import '../models/team_model.dart';

/// `GET /teams` is open to any authenticated user (no superuser gate) —
/// it powers both the Phase 2 team-owner detection heuristic and the
/// Phase 8 Teams admin screen. create/update/delete are superuser-only
/// server-side.
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

  Future<PaginatedResult<TeamModel>> fetchTeamsPage({
    int skip = 0,
    int limit = 20,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/teams/',
        queryParameters: {'skip': skip, 'limit': limit},
      );
      final data = response.data!['data'] as List;
      final count = response.data!['count'] as int;
      final list = data
          .map((e) => TeamModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return PaginatedResult(data: list, count: count);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<TeamModel> createTeam({
    required String name,
    String? description,
    required String teamOwnerId,
    required bool isActive,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '/teams/',
        data: {
          'name': name,
          'description': description,
          'team_owner_id': teamOwnerId,
          'is_active': isActive,
        },
      );
      return TeamModel.fromJson(response.data!);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<TeamModel> updateTeam(
    String id, {
    required String name,
    String? description,
    required String teamOwnerId,
    required bool isActive,
  }) async {
    try {
      final response = await _dio.put<Map<String, dynamic>>(
        '/teams/$id',
        data: {
          'name': name,
          'description': description,
          'team_owner_id': teamOwnerId,
          'is_active': isActive,
        },
      );
      return TeamModel.fromJson(response.data!);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<void> deleteTeam(String id) async {
    try {
      await _dio.delete('/teams/$id');
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}
