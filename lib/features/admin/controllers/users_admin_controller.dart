import 'package:get/get.dart';

import '../../../core/errors/api_exception.dart';
import '../../../data/models/paginated_result.dart';
import '../../../data/models/user_model.dart';
import '../../../data/repositories/teams_repository.dart';
import '../../../data/repositories/users_repository.dart';
import '../../../widgets/admin/admin_field_spec.dart';
import 'admin_crud_controller.dart';

class UsersAdminController extends AdminCrudController<UserModel> {
  UsersAdminController({
    required this.repository,
    required this.teamsRepository,
  });

  final UsersRepository repository;
  final TeamsRepository teamsRepository;

  /// Options for the team_id picker.
  final teamOptions = <AdminPickerOption>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadTeamOptions();
  }

  Future<void> _loadTeamOptions() async {
    try {
      final teams = await teamsRepository.fetchTeams();
      teamOptions.value = teams
          .map((t) => AdminPickerOption(id: t.id, label: t.name))
          .toList();
    } on ApiException {
      // Non-critical: the team picker just shows no options.
    }
  }

  @override
  String idOf(UserModel item) => item.id;

  @override
  bool matchesSearch(UserModel item, String query) =>
      item.email.toLowerCase().contains(query) ||
      (item.fullName?.toLowerCase().contains(query) ?? false);

  @override
  Future<PaginatedResult<UserModel>> fetchPage({
    required int skip,
    required int limit,
  }) {
    return repository.fetchUsersPage(skip: skip, limit: limit);
  }

  @override
  Future<UserModel> createItem(Map<String, dynamic> values) {
    return repository.createUser(
      email: values['email'] as String,
      password: values['password'] as String,
      fullName: values['full_name'] as String?,
      isActive: values['is_active'] as bool,
      isSuperuser: values['is_superuser'] as bool,
      teamId: values['team_id'] as String?,
    );
  }

  @override
  Future<UserModel> updateItem(String id, Map<String, dynamic> values) {
    return repository.updateUser(
      id,
      email: values['email'] as String,
      password: values['password'] as String?,
      fullName: values['full_name'] as String?,
      isActive: values['is_active'] as bool,
      isSuperuser: values['is_superuser'] as bool,
      teamId: values['team_id'] as String?,
    );
  }

  @override
  Future<void> deleteItem(String id) => repository.deleteUser(id);
}
