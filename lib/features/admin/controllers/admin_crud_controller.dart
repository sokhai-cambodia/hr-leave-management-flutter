import 'package:get/get.dart';

import '../../../core/errors/api_exception.dart';
import '../../../data/models/paginated_result.dart';

/// Generic paginated-list + CRUD controller (Task 8.1). A resource
/// controller extends this and implements the abstract hooks; the fetch/
/// create/update/delete orchestration (loading flags, pagination,
/// optimistic list updates, error snackbars) lives here once so 8.2/8.3
/// only add hooks, not new controller logic.
abstract class AdminCrudController<T> extends GetxController {
  final items = <T>[].obs;
  final isLoading = false.obs;
  final isMoreLoading = false.obs;
  final hasMore = true.obs;
  final errorMessage = RxnString();
  final searchQuery = ''.obs;

  /// IDs currently being created/updated/deleted, so their row/dialog can
  /// show a spinner and ignore repeat taps.
  final processingIds = <String>{}.obs;

  int _skip = 0;
  static const int pageSize = 20;

  @override
  void onInit() {
    super.onInit();
    fetchItems(isRefresh: true);
  }

  /// The resource's stable identifier, used to locate/replace/remove an item
  /// in [items] after create/update/delete.
  String idOf(T item);

  /// Whether [item] matches the (already-lowercased, trimmed) search [query].
  bool matchesSearch(T item, String query);

  Future<PaginatedResult<T>> fetchPage({required int skip, required int limit});
  Future<T> createItem(Map<String, dynamic> values);
  Future<T> updateItem(String id, Map<String, dynamic> values);
  Future<void> deleteItem(String id);

  List<T> get filteredItems {
    final query = searchQuery.value.trim().toLowerCase();
    if (query.isEmpty) return items;
    return items.where((item) => matchesSearch(item, query)).toList();
  }

  Future<void> fetchItems({bool isRefresh = false}) async {
    if (isRefresh) {
      _skip = 0;
      hasMore.value = true;
      items.clear();
      isLoading.value = true;
      errorMessage.value = null;
    } else {
      if (isMoreLoading.value || !hasMore.value) return;
      isMoreLoading.value = true;
    }

    try {
      final page = await fetchPage(skip: _skip, limit: pageSize);
      items.addAll(page.data);
      _skip += page.data.length;
      if (page.data.length < pageSize || items.length >= page.count) {
        hasMore.value = false;
      }
    } on ApiException catch (e) {
      if (isRefresh) {
        errorMessage.value = e.message;
      } else {
        Get.snackbar(
          'Error',
          'Failed to load more: ${e.message}',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } finally {
      isLoading.value = false;
      isMoreLoading.value = false;
    }
  }

  Future<bool> create(Map<String, dynamic> values) async {
    try {
      final created = await createItem(values);
      items.insert(0, created);
      return true;
    } on ApiException catch (e) {
      Get.snackbar('Error', e.message, snackPosition: SnackPosition.BOTTOM);
      return false;
    }
  }

  /// Named `edit`, not `update` - `update()` is already GetxController's
  /// reactive-rebuild trigger and would collide with an incompatible signature.
  Future<bool> edit(String id, Map<String, dynamic> values) async {
    try {
      final updated = await updateItem(id, values);
      final index = items.indexWhere((item) => idOf(item) == id);
      if (index != -1) items[index] = updated;
      return true;
    } on ApiException catch (e) {
      Get.snackbar('Error', e.message, snackPosition: SnackPosition.BOTTOM);
      return false;
    }
  }

  Future<void> delete(String id) async {
    if (!processingIds.add(id)) return;
    try {
      await deleteItem(id);
      items.removeWhere((item) => idOf(item) == id);
    } on ApiException catch (e) {
      Get.snackbar('Error', e.message, snackPosition: SnackPosition.BOTTOM);
    } finally {
      processingIds.remove(id);
    }
  }
}
