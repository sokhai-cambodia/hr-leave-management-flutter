/// `date` is a plain "YYYY-MM-DD" string on the wire, not a DateTime-typed
/// field - keep it as String so it round-trips exactly (no parsing/timezone
/// drift), per CLAUDE.md's note on this resource's wire format.
class PublicHolidayModel {
  const PublicHolidayModel({
    required this.id,
    required this.date,
    required this.name,
    this.description,
  });

  final String id;
  final String date;
  final String name;
  final String? description;

  factory PublicHolidayModel.fromJson(Map<String, dynamic> json) {
    return PublicHolidayModel(
      id: json['id'] as String,
      date: json['date'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'name': name,
      'description': description,
    };
  }
}
