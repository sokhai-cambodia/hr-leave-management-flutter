import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/theme/app_theme.dart';
import '../../features/admin/controllers/admin_crud_controller.dart';
import '../app_shell_scaffold.dart';
import 'admin_field_spec.dart';
import 'admin_form_dialog.dart';

/// Generic paginated/searchable admin list + CRUD screen (Task 8.1),
/// parameterized entirely by a field-spec list and a few small mapper
/// callbacks - applying the pattern to a new resource (8.2/8.3) means
/// wiring a controller + this widget, not building new list/form UI.
class AdminCrudView<T> extends StatefulWidget {
  const AdminCrudView({
    super.key,
    required this.title,
    required this.controller,
    required this.fields,
    required this.toFormValues,
    required this.emptyFormValues,
    required this.itemTitle,
    required this.itemSubtitle,
    this.searchHint = 'Search...',
  });

  final String title;
  final AdminCrudController<T> controller;
  final List<AdminFieldSpec> fields;

  /// Pre-populates the edit dialog from an existing item.
  final Map<String, dynamic> Function(T item) toFormValues;

  /// Pre-populates the create dialog (defaults for a new item).
  final Map<String, dynamic> emptyFormValues;

  final String Function(T item) itemTitle;
  final String Function(T item) itemSubtitle;
  final String searchHint;

  @override
  State<AdminCrudView<T>> createState() => _AdminCrudViewState<T>();
}

class _AdminCrudViewState<T> extends State<AdminCrudView<T>> {
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
      widget.controller.fetchItems(isRefresh: false);
    }
  }

  void _openCreateDialog() {
    Get.dialog(
      AdminFormDialog(
        title: 'New ${widget.title}',
        fields: widget.fields,
        initialValues: widget.emptyFormValues,
        onSubmit: widget.controller.create,
      ),
    );
  }

  void _openEditDialog(T item) {
    Get.dialog(
      AdminFormDialog(
        title: 'Edit ${widget.title}',
        fields: widget.fields,
        initialValues: widget.toFormValues(item),
        onSubmit: (values) => widget.controller.edit(widget.controller.idOf(item), values),
      ),
    );
  }

  void _confirmDelete(T item) {
    Get.dialog(
      AlertDialog(
        title: Text('Delete ${widget.title}'),
        content: Text(
          'Are you sure you want to delete "${widget.itemTitle(item)}"? This action cannot be undone.',
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              Get.back();
              widget.controller.delete(widget.controller.idOf(item));
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.danger),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = widget.controller;

    return AppShellScaffold(
      title: widget.title,
      floatingActionButton: FloatingActionButton(
        onPressed: _openCreateDialog,
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: TextField(
              decoration: InputDecoration(
                hintText: widget.searchHint,
                prefixIcon: const Icon(Icons.search),
              ),
              onChanged: (value) => controller.searchQuery.value = value,
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.errorMessage.value != null) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error_outline, size: 64, color: AppColors.danger),
                        const SizedBox(height: 16),
                        Text(
                          controller.errorMessage.value!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () => controller.fetchItems(isRefresh: true),
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  ),
                );
              }

              final items = controller.filteredItems;
              if (items.isEmpty) {
                return Center(child: Text('No ${widget.title.toLowerCase()} found.'));
              }

              return RefreshIndicator(
                onRefresh: () => controller.fetchItems(isRefresh: true),
                child: ListView.builder(
                  controller: _scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 88),
                  itemCount: items.length + (controller.hasMore.value ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == items.length) {
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

                    final item = items[index];
                    final isProcessing = controller.processingIds.contains(controller.idOf(item));

                    return Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        title: Text(widget.itemTitle(item)),
                        subtitle: Text(widget.itemSubtitle(item)),
                        trailing: isProcessing
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit_outlined),
                                    onPressed: () => _openEditDialog(item),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete_outline, color: AppColors.danger),
                                    onPressed: () => _confirmDelete(item),
                                  ),
                                ],
                              ),
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
