import 'package:get/get.dart';

import '../../../core/errors/api_exception.dart';
import '../../../data/models/paginated_result.dart';
import '../../../data/models/team_model.dart';
import '../../../data/repositories/teams_repository.dart';
import '../../../data/repositories/users_repository.dart';
import '../../../widgets/admin/admin_field_spec.dart';
import 'admin_crud_controller.dart';

class TeamsAdminController extends AdminCrudController<TeamModel> {
  TeamsAdminController({
    required this.repository,
    required this.usersRepository,
  });

  final TeamsRepository repository;
  final UsersRepository usersRepository;

  /// Options for the team_owner_id picker - fetched once on init since
  /// picking a team owner doesn't need live/paginated search over the full
  /// user base for a small admin dataset.
  final userOptions = <AdminPickerOption>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadUserOptions();
  }

  Future<void> _loadUserOptions() async {
    try {
      final page = await usersRepository.fetchUsersPage(limit: 200);
      userOptions.value = page.data
          .map((u) => AdminPickerOption(id: u.id, label: u.fullName ?? u.email))
          .toList();
    } on ApiException {
      // Non-critical: the team-owner picker just shows no options; the list
      // screen itself still works.
    }
  }

  @override
  String idOf(TeamModel item) => item.id;

  @override
  bool matchesSearch(TeamModel item, String query) =>
      item.name.toLowerCase().contains(query);

  @override
  Future<PaginatedResult<TeamModel>> fetchPage({
    required int skip,
    required int limit,
  }) {
    return repository.fetchTeamsPage(skip: skip, limit: limit);
  }

  @override
  Future<TeamModel> createItem(Map<String, dynamic> values) {
    return repository.createTeam(
      name: values['name'] as String,
      description: values['description'] as String?,
      teamOwnerId: values['team_owner_id'] as String,
      isActive: values['is_active'] as bool,
    );
  }

  @override
  Future<TeamModel> updateItem(String id, Map<String, dynamic> values) {
    return repository.updateTeam(
      id,
      name: values['name'] as String,
      description: values['description'] as String?,
      teamOwnerId: values['team_owner_id'] as String,
      isActive: values['is_active'] as bool,
    );
  }

  @override
  Future<void> deleteItem(String id) => repository.deleteTeam(id);
}
