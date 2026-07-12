enum AdminFieldType {
  text,
  multilineText,
  number,
  decimal,
  boolean,

  /// A date-picker-driven field whose value is always a plain "YYYY-MM-DD"
  /// string, never a DateTime - matches backend resources (e.g. public
  /// holidays) that store the date as an opaque string on the wire, so it
  /// must round-trip exactly with no timezone/format drift.
  date,
}

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
