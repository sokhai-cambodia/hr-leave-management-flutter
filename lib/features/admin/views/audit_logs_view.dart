import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/theme/app_theme.dart';
import '../../../data/models/audit_log_model.dart';
import '../../../widgets/app_shell_scaffold.dart';
import '../../../widgets/empty_state_view.dart';
import '../../../widgets/error_state_view.dart';
import '../controllers/audit_logs_controller.dart';

/// Read-only trail of who did what and when - no create/edit/delete, this
/// mirrors the shape of [AuditLogsController] which only ever fetches.
class AuditLogsView extends StatefulWidget {
  const AuditLogsView({super.key});

  @override
  State<AuditLogsView> createState() => _AuditLogsViewState();
}

class _AuditLogsViewState extends State<AuditLogsView> {
  final AuditLogsController controller = Get.find<AuditLogsController>();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      controller.fetchLogs(isRefresh: false);
    }
  }

  static Color _actionColor(String action) {
    switch (action) {
      case 'create':
      case 'submit':
        return AppColors.info;
      case 'update':
        return AppColors.warning;
      case 'approve':
        return AppColors.success;
      case 'delete':
      case 'reject':
        return AppColors.danger;
      default:
        return Colors.grey;
    }
  }

  String _formatTimestamp(DateTime dateTime) {
    return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} '
        '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return AppShellScaffold(
      title: 'Audit Log',
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: Obx(
              () => DropdownButtonFormField<String?>(
                initialValue: controller.entityTypeFilter.value,
                decoration: const InputDecoration(labelText: 'Entity type'),
                items: [
                  const DropdownMenuItem<String?>(
                    value: null,
                    child: Text('All'),
                  ),
                  ...AuditLogsController.entityTypes.map(
                    (type) => DropdownMenuItem<String?>(
                      value: type,
                      child: Text(type.replaceAll('_', ' ')),
                    ),
                  ),
                ],
                onChanged: controller.setEntityTypeFilter,
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.errorMessage.value != null) {
                return ErrorStateView(
                  message: controller.errorMessage.value!,
                  onRetry: () => controller.fetchLogs(isRefresh: true),
                );
              }

              final logs = controller.logs;
              if (logs.isEmpty) {
                return const EmptyStateView(
                  icon: Icons.history_outlined,
                  title: 'No audit log entries found.',
                );
              }

              return RefreshIndicator(
                onRefresh: () => controller.fetchLogs(isRefresh: true),
                child: ListView.builder(
                  controller: _scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                  itemCount: logs.length + (controller.hasMore.value ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == logs.length) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Center(
                          child: SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(strokeWidth: 2.5),
                          ),
                        ),
                      );
                    }

                    final AuditLogModel log = logs[index];
                    final color = _actionColor(log.action);

                    return Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        leading: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(
                              AppShapes.pillRadius,
                            ),
                            border: Border.all(
                              color: color.withValues(alpha: 0.5),
                            ),
                          ),
                          child: Text(
                            log.action.toUpperCase(),
                            style: TextStyle(
                              color: color,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        title: Text(log.summary),
                        subtitle: Text(
                          '${log.entityType.replaceAll('_', ' ')} · '
                          '${_formatTimestamp(log.createdAt.toLocal())}'
                          '${log.actor == null ? ' · actor deleted' : ''}',
                        ),
                        isThreeLine: true,
                      ),
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
