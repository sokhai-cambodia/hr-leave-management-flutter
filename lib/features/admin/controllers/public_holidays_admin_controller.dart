import '../../../data/models/paginated_result.dart';
import '../../../data/models/public_holiday_model.dart';
import '../../../data/repositories/public_holidays_repository.dart';
import 'admin_crud_controller.dart';

class PublicHolidaysAdminController extends AdminCrudController<PublicHolidayModel> {
  PublicHolidaysAdminController({required this.repository});

  final PublicHolidaysRepository repository;

  @override
  String idOf(PublicHolidayModel item) => item.id;

  @override
  bool matchesSearch(PublicHolidayModel item, String query) =>
      item.name.toLowerCase().contains(query) || item.date.contains(query);

  @override
  Future<PaginatedResult<PublicHolidayModel>> fetchPage({
    required int skip,
    required int limit,
  }) {
    return repository.fetchPublicHolidays(skip: skip, limit: limit);
  }

  @override
  Future<PublicHolidayModel> createItem(Map<String, dynamic> values) {
    return repository.createPublicHoliday(
      date: values['date'] as String,
      name: values['name'] as String,
      description: values['description'] as String?,
    );
  }

  @override
  Future<PublicHolidayModel> updateItem(String id, Map<String, dynamic> values) {
    return repository.updatePublicHoliday(
      id,
      date: values['date'] as String,
      name: values['name'] as String,
      description: values['description'] as String?,
    );
  }

  @override
  Future<void> deleteItem(String id) => repository.deletePublicHoliday(id);
}
