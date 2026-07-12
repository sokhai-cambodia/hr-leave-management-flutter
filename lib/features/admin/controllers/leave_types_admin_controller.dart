import '../../../data/models/leave_type_model.dart';
import '../../../data/models/paginated_result.dart';
import '../../../data/repositories/leave_types_repository.dart';
import 'admin_crud_controller.dart';

class LeaveTypesAdminController extends AdminCrudController<LeaveTypeModel> {
  LeaveTypesAdminController({required this.repository});

  final LeaveTypesRepository repository;

  @override
  String idOf(LeaveTypeModel item) => item.id;

  @override
  bool matchesSearch(LeaveTypeModel item, String query) =>
      item.name.toLowerCase().contains(query) ||
      item.code.toLowerCase().contains(query);

  @override
  Future<PaginatedResult<LeaveTypeModel>> fetchPage({
    required int skip,
    required int limit,
  }) {
    return repository.fetchLeaveTypesPage(skip: skip, limit: limit);
  }

  @override
  Future<LeaveTypeModel> createItem(Map<String, dynamic> values) {
    return repository.createLeaveType(
      code: values['code'] as String,
      name: values['name'] as String,
      entitlement: values['entitlement'] as int,
      description: values['description'] as String?,
      isAllowPlan: values['is_allow_plan'] as bool,
      isActive: values['is_active'] as bool,
    );
  }

  @override
  Future<LeaveTypeModel> updateItem(String id, Map<String, dynamic> values) {
    return repository.updateLeaveType(
      id,
      code: values['code'] as String,
      name: values['name'] as String,
      entitlement: values['entitlement'] as int,
      description: values['description'] as String?,
      isAllowPlan: values['is_allow_plan'] as bool,
      isActive: values['is_active'] as bool,
    );
  }

  @override
  Future<void> deleteItem(String id) => repository.deleteLeaveType(id);
}
