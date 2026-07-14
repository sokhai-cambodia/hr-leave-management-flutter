import 'package:get/get.dart';

import '../../../core/errors/api_exception.dart';
import '../../../data/models/leave_balance_model.dart';
import '../../../data/models/paginated_result.dart';
import '../../../data/repositories/leave_balances_repository.dart';
import '../../../data/repositories/leave_types_repository.dart';
import '../../../data/repositories/users_repository.dart';
import '../../../widgets/admin/admin_field_spec.dart';
import 'admin_crud_controller.dart';

class LeaveBalancesAdminController
    extends AdminCrudController<LeaveBalanceModel> {
  LeaveBalancesAdminController({
    required this.repository,
    required this.usersRepository,
    required this.leaveTypesRepository,
  });

  final LeaveBalancesRepository repository;
  final UsersRepository usersRepository;
  final LeaveTypesRepository leaveTypesRepository;

  /// Options for the owner_id / leave_type_id pickers - fetched once on
  /// init since picking from a small admin dataset doesn't need live/
  /// paginated search.
  final userOptions = <AdminPickerOption>[].obs;
  final leaveTypeOptions = <AdminPickerOption>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadUserOptions();
    _loadLeaveTypeOptions();
  }

  Future<void> _loadUserOptions() async {
    try {
      final page = await usersRepository.fetchUsersPage(limit: 200);
      userOptions.value = page.data
          .map((u) => AdminPickerOption(id: u.id, label: u.fullName ?? u.email))
          .toList();
    } on ApiException {
      // Non-critical: the owner picker just shows no options; the list
      // screen itself still works.
    }
  }

  Future<void> _loadLeaveTypeOptions() async {
    try {
      final types = await leaveTypesRepository.fetchLeaveTypes();
      leaveTypeOptions.value = types
          .map(
            (t) => AdminPickerOption(id: t.id, label: '${t.code} — ${t.name}'),
          )
          .toList();
    } on ApiException {
      // Non-critical: the leave-type picker just shows no options.
    }
  }

  @override
  String idOf(LeaveBalanceModel item) => item.id;

  @override
  bool matchesSearch(LeaveBalanceModel item, String query) {
    final owner = item.owner?.fullName ?? item.owner?.email ?? '';
    return owner.toLowerCase().contains(query) ||
        item.leaveType.name.toLowerCase().contains(query) ||
        item.leaveType.code.toLowerCase().contains(query) ||
        item.year.contains(query);
  }

  @override
  Future<PaginatedResult<LeaveBalanceModel>> fetchPage({
    required int skip,
    required int limit,
  }) {
    return repository.fetchBalancesPage(skip: skip, limit: limit);
  }

  @override
  Future<LeaveBalanceModel> createItem(Map<String, dynamic> values) {
    return repository.createBalance(
      year: values['year'] as String,
      balance: (values['balance'] as num).toDouble(),
      leaveTypeId: values['leave_type_id'] as String,
      ownerId: values['owner_id'] as String,
    );
  }

  @override
  Future<LeaveBalanceModel> updateItem(String id, Map<String, dynamic> values) {
    return repository.updateBalance(
      id,
      year: values['year'] as String,
      balance: (values['balance'] as num).toDouble(),
      leaveTypeId: values['leave_type_id'] as String,
      ownerId: values['owner_id'] as String,
    );
  }

  @override
  Future<void> deleteItem(String id) => repository.deleteBalance(id);
}
