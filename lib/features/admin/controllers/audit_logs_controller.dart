import 'package:get/get.dart';

import '../../../core/errors/api_exception.dart';
import '../../../data/models/audit_log_model.dart';
import '../../../data/repositories/audit_logs_repository.dart';

class AuditLogsController extends GetxController {
  AuditLogsController({required this.repository});

  final AuditLogsRepository repository;

  final logs = <AuditLogModel>[].obs;
  final isLoading = false.obs;
  final isMoreLoading = false.obs;
  final hasMore = true.obs;
  final errorMessage = RxnString();

  /// Null means "all entity types" - matches the backend's optional
  /// `entity_type` query param (no filter applied when omitted).
  final entityTypeFilter = RxnString();

  int _skip = 0;
  static const int _limit = 20;

  static const entityTypes = [
    'user',
    'team',
    'leave_type',
    'public_holiday',
    'policy',
    'leave_balance',
    'leave_request',
    'leave_plan_request',
  ];

  @override
  void onInit() {
    super.onInit();
    fetchLogs(isRefresh: true);
  }

  void setEntityTypeFilter(String? entityType) {
    entityTypeFilter.value = entityType;
    fetchLogs(isRefresh: true);
  }

  Future<void> fetchLogs({bool isRefresh = false}) async {
    if (isRefresh) {
      _skip = 0;
      hasMore.value = true;
      logs.clear();
      isLoading.value = true;
      errorMessage.value = null;
    } else {
      if (isMoreLoading.value || !hasMore.value) return;
      isMoreLoading.value = true;
    }

    try {
      final result = await repository.fetchAuditLogs(
        skip: _skip,
        limit: _limit,
        entityType: entityTypeFilter.value,
      );

      logs.addAll(result.data);
      _skip += result.data.length;

      if (result.data.length < _limit || logs.length >= result.count) {
        hasMore.value = false;
      }
    } on ApiException catch (e) {
      if (isRefresh) {
        errorMessage.value = e.message;
      } else {
        Get.snackbar(
          'Error',
          'Failed to load more audit log entries: ${e.message}',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } finally {
      isLoading.value = false;
      isMoreLoading.value = false;
    }
  }
}
