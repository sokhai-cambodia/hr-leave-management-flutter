/// `operation` and `value` are opaque free-form strings on the backend (no
/// enum/shape validation) - the client shouldn't invent structure for them.
class PolicyModel {
  const PolicyModel({
    required this.id,
    required this.code,
    required this.name,
    this.operation,
    required this.value,
    this.score,
    this.description,
    required this.isActive,
  });

  final String id;
  final String code;
  final String name;
  final String? operation;
  final String value;
  final double? score;
  final String? description;
  final bool isActive;

  factory PolicyModel.fromJson(Map<String, dynamic> json) {
    return PolicyModel(
      id: json['id'] as String,
      code: json['code'] as String,
      name: json['name'] as String,
      operation: json['operation'] as String?,
      value: json['value'] as String,
      score: json['score'] == null ? null : (json['score'] as num).toDouble(),
      description: json['description'] as String?,
      isActive: json['is_active'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'name': name,
      'operation': operation,
      'value': value,
      'score': score,
      'description': description,
      'is_active': isActive,
    };
  }
}
