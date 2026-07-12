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

  /// A searchable picker over [AdminFieldSpec.options] (Task 8.3) - e.g.
  /// Teams' team_owner_id (pick a user) or Users' team_id (pick a team).
  /// The stored form value is always the selected option's [id].
  relation,
}

/// One selectable entry for a [AdminFieldType.relation] field.
class AdminPickerOption {
  const AdminPickerOption({required this.id, required this.label});

  final String id;
  final String label;
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
    this.obscureText = false,
    this.options = const [],
  });

  /// The key this field's value is stored under in the form-values map
  /// passed to [AdminCrudController.create]/[AdminCrudController.update].
  final String key;
  final String label;
  final AdminFieldType type;
  final bool required;

  /// Extra validation beyond [required] (e.g. max length, min length). Only
  /// consulted for [AdminFieldType.text]/[AdminFieldType.multilineText] -
  /// runs only when the field has a non-empty value, so it composes with an
  /// optional field left blank.
  final String? Function(String? value)? validator;

  /// Masks input (e.g. a password field). Only meaningful for
  /// [AdminFieldType.text].
  final bool obscureText;

  /// Selectable entries for [AdminFieldType.relation]. Ignored otherwise.
  /// Built fresh per dialog-open by the caller (see [AdminCrudView.fields])
  /// since it usually comes from a live fetch, not a fixed list.
  final List<AdminPickerOption> options;
}
