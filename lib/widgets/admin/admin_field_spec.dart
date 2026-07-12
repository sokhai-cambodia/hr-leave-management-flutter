enum AdminFieldType { text, multilineText, number, boolean }

/// Describes one field of a generic admin create/edit form (Task 8.1). The
/// dialog builds its inputs purely from a list of these - adding a resource
/// in 8.2/8.3 means writing a field-spec list, not new form widgets.
class AdminFieldSpec {
  const AdminFieldSpec({
    required this.key,
    required this.label,
    required this.type,
    this.required = false,
    this.validator,
  });

  /// The key this field's value is stored under in the form-values map
  /// passed to [AdminCrudController.create]/[AdminCrudController.update].
  final String key;
  final String label;
  final AdminFieldType type;
  final bool required;

  /// Extra validation beyond [required] (e.g. max length). Only consulted
  /// for [AdminFieldType.text]/[AdminFieldType.multilineText].
  final String? Function(String? value)? validator;
}
