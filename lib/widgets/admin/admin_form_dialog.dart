import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'admin_field_spec.dart';

/// Generic create/edit form dialog for admin CRUD (Task 8.1). Renders one
/// input per [AdminFieldSpec] and hands back a typed values map (String for
/// text, int for number, bool for boolean) keyed by [AdminFieldSpec.key] -
/// resource-specific code maps that map to/from its own repository calls.
class AdminFormDialog extends StatefulWidget {
  const AdminFormDialog({
    super.key,
    required this.title,
    required this.fields,
    required this.initialValues,
    required this.onSubmit,
  });

  final String title;
  final List<AdminFieldSpec> fields;
  final Map<String, dynamic> initialValues;

  /// Returns true on success (closes the dialog); false leaves it open so
  /// the user can retry - the caller is responsible for surfacing the error
  /// (e.g. via a snackbar), matching the pattern used elsewhere in the app.
  final Future<bool> Function(Map<String, dynamic> values) onSubmit;

  @override
  State<AdminFormDialog> createState() => _AdminFormDialogState();
}

class _AdminFormDialogState extends State<AdminFormDialog> {
  final _formKey = GlobalKey<FormState>();
  final _textControllers = <String, TextEditingController>{};
  final _boolValues = <String, bool>{};
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    for (final field in widget.fields) {
      final initial = widget.initialValues[field.key];
      if (field.type == AdminFieldType.boolean) {
        _boolValues[field.key] = initial as bool? ?? false;
      } else {
        _textControllers[field.key] = TextEditingController(
          text: initial == null ? '' : initial.toString(),
        );
      }
    }
  }

  @override
  void dispose() {
    for (final controller in _textControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final values = <String, dynamic>{};
    for (final field in widget.fields) {
      switch (field.type) {
        case AdminFieldType.boolean:
          values[field.key] = _boolValues[field.key] ?? false;
        case AdminFieldType.number:
          values[field.key] = int.parse(_textControllers[field.key]!.text.trim());
        case AdminFieldType.text:
        case AdminFieldType.multilineText:
          final text = _textControllers[field.key]!.text.trim();
          values[field.key] = text.isEmpty ? null : text;
      }
    }

    setState(() => _isSubmitting = true);
    final success = await widget.onSubmit(values);
    if (!mounted) return;
    setState(() => _isSubmitting = false);
    if (success) Get.back();
  }

  Widget _buildField(AdminFieldSpec field) {
    if (field.type == AdminFieldType.boolean) {
      return SwitchListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(field.label),
        value: _boolValues[field.key] ?? false,
        onChanged: (value) => setState(() => _boolValues[field.key] = value),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: _textControllers[field.key],
        keyboardType: field.type == AdminFieldType.number
            ? TextInputType.number
            : TextInputType.text,
        maxLines: field.type == AdminFieldType.multilineText ? 3 : 1,
        decoration: InputDecoration(labelText: field.label),
        validator: (value) {
          final trimmed = value?.trim() ?? '';
          if (field.required && trimmed.isEmpty) {
            return '${field.label} is required';
          }
          if (field.type == AdminFieldType.number && trimmed.isNotEmpty) {
            if (int.tryParse(trimmed) == null) return 'Must be a whole number';
          }
          if (trimmed.isNotEmpty && field.validator != null) {
            return field.validator!(trimmed);
          }
          return null;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: SizedBox(
        width: 400,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.fields.map(_buildField).toList(),
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isSubmitting ? null : () => Get.back(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _isSubmitting ? null : _submit,
          child: _isSubmitting
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Save'),
        ),
      ],
    );
  }
}
