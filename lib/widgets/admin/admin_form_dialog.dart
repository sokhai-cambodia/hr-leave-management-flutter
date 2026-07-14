import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'admin_field_spec.dart';

/// Sentinel id for "no selection" on an optional [AdminFieldType.relation]
/// field (e.g. a user with no team) - a real option id is never empty.
const String _noneOptionId = '';

/// Generic create/edit form dialog for admin CRUD (Task 8.1). Renders one
/// input per [AdminFieldSpec] and hands back a typed values map (String for
/// text, int for number, bool for boolean, String? id for relation) keyed by
/// [AdminFieldSpec.key] - resource-specific code maps that map to/from its
/// own repository calls.
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
  final _relationValues = <String, String?>{};
  String? _relationError;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    for (final field in widget.fields) {
      final initial = widget.initialValues[field.key];
      switch (field.type) {
        case AdminFieldType.boolean:
          _boolValues[field.key] = initial as bool? ?? false;
        case AdminFieldType.relation:
          _relationValues[field.key] = initial as String?;
        case AdminFieldType.text:
        case AdminFieldType.multilineText:
        case AdminFieldType.number:
        case AdminFieldType.decimal:
        case AdminFieldType.date:
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

  AdminPickerOption? _findOption(AdminFieldSpec field, String? id) {
    if (id == null) return null;
    for (final option in field.options) {
      if (option.id == id) return option;
    }
    return null;
  }

  Future<void> _submit() async {
    // Relation fields aren't backed by a Form-integrated widget, so their
    // required-ness is checked here rather than via Form.validate().
    _relationError = null;
    for (final field in widget.fields) {
      if (field.type == AdminFieldType.relation &&
          field.required &&
          (_relationValues[field.key] == null ||
              _relationValues[field.key]!.isEmpty)) {
        setState(() => _relationError = '${field.label} is required');
        return;
      }
    }
    if (!_formKey.currentState!.validate()) return;

    final values = <String, dynamic>{};
    for (final field in widget.fields) {
      switch (field.type) {
        case AdminFieldType.boolean:
          values[field.key] = _boolValues[field.key] ?? false;
        case AdminFieldType.relation:
          final id = _relationValues[field.key];
          values[field.key] = (id == null || id.isEmpty) ? null : id;
        case AdminFieldType.number:
          final text = _textControllers[field.key]!.text.trim();
          values[field.key] = text.isEmpty ? null : int.parse(text);
        case AdminFieldType.decimal:
          final text = _textControllers[field.key]!.text.trim();
          values[field.key] = text.isEmpty ? null : double.parse(text);
        case AdminFieldType.text:
        case AdminFieldType.multilineText:
        case AdminFieldType.date:
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

  Future<void> _pickDate(AdminFieldSpec field) async {
    final current = _textControllers[field.key]!.text.trim();
    final initial = DateTime.tryParse(current) ?? DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked == null) return;
    // Manual y/m/d formatting, not toIso8601String() - the backend stores
    // this as a plain string and must get back exactly "YYYY-MM-DD" with no
    // time/timezone component riding along.
    setState(() {
      _textControllers[field.key]!.text =
          '${picked.year.toString().padLeft(4, '0')}-'
          '${picked.month.toString().padLeft(2, '0')}-'
          '${picked.day.toString().padLeft(2, '0')}';
    });
  }

  Widget _buildRelationField(AdminFieldSpec field) {
    final options = field.required
        ? field.options
        : [
            const AdminPickerOption(id: _noneOptionId, label: '— None —'),
            ...field.options,
          ];
    final currentOption = _findOption(field, _relationValues[field.key]);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Autocomplete<AdminPickerOption>(
        initialValue: TextEditingValue(text: currentOption?.label ?? ''),
        displayStringForOption: (option) => option.label,
        optionsBuilder: (textEditingValue) {
          if (textEditingValue.text.isEmpty) return options;
          final query = textEditingValue.text.toLowerCase();
          return options.where((o) => o.label.toLowerCase().contains(query));
        },
        onSelected: (option) => setState(() {
          _relationValues[field.key] = option.id;
          _relationError = null;
        }),
        fieldViewBuilder:
            (context, textController, focusNode, onFieldSubmitted) {
              return TextFormField(
                controller: textController,
                focusNode: focusNode,
                decoration: InputDecoration(
                  labelText: field.label,
                  suffixIcon: const Icon(Icons.search),
                  errorText:
                      _relationError != null &&
                          _relationValues[field.key] == null
                      ? _relationError
                      : null,
                ),
              );
            },
      ),
    );
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

    if (field.type == AdminFieldType.relation) {
      return _buildRelationField(field);
    }

    final isDate = field.type == AdminFieldType.date;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: _textControllers[field.key],
        readOnly: isDate,
        obscureText: field.obscureText,
        onTap: isDate ? () => _pickDate(field) : null,
        keyboardType: switch (field.type) {
          AdminFieldType.number => TextInputType.number,
          AdminFieldType.decimal => const TextInputType.numberWithOptions(
            decimal: true,
          ),
          _ => TextInputType.text,
        },
        maxLines: field.type == AdminFieldType.multilineText ? 3 : 1,
        decoration: InputDecoration(
          labelText: field.label,
          suffixIcon: isDate ? const Icon(Icons.calendar_today_outlined) : null,
        ),
        validator: (value) {
          final trimmed = value?.trim() ?? '';
          if (field.required && trimmed.isEmpty) {
            return '${field.label} is required';
          }
          if (field.type == AdminFieldType.number && trimmed.isNotEmpty) {
            if (int.tryParse(trimmed) == null) return 'Must be a whole number';
          }
          if (field.type == AdminFieldType.decimal && trimmed.isNotEmpty) {
            if (double.tryParse(trimmed) == null) return 'Must be a number';
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
