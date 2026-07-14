import '../../../data/models/paginated_result.dart';
import '../../../data/models/policy_model.dart';
import '../../../data/repositories/policies_repository.dart';
import 'admin_crud_controller.dart';

class PoliciesAdminController extends AdminCrudController<PolicyModel> {
  PoliciesAdminController({required this.repository});

  final PoliciesRepository repository;

  @override
  String idOf(PolicyModel item) => item.id;

  @override
  bool matchesSearch(PolicyModel item, String query) =>
      item.name.toLowerCase().contains(query) ||
      item.code.toLowerCase().contains(query);

  @override
  Future<PaginatedResult<PolicyModel>> fetchPage({
    required int skip,
    required int limit,
  }) {
    return repository.fetchPolicies(skip: skip, limit: limit);
  }

  @override
  Future<PolicyModel> createItem(Map<String, dynamic> values) {
    return repository.createPolicy(
      code: values['code'] as String,
      name: values['name'] as String,
      operation: values['operation'] as String?,
      value: values['value'] as String,
      score: values['score'] as double?,
      description: values['description'] as String?,
      isActive: values['is_active'] as bool,
    );
  }

  @override
  Future<PolicyModel> updateItem(String id, Map<String, dynamic> values) {
    return repository.updatePolicy(
      id,
      code: values['code'] as String,
      name: values['name'] as String,
      operation: values['operation'] as String?,
      value: values['value'] as String,
      score: values['score'] as double?,
      description: values['description'] as String?,
      isActive: values['is_active'] as bool,
    );
  }

  @override
  Future<void> deleteItem(String id) => repository.deletePolicy(id);
}
