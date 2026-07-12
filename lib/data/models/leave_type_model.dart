class LeaveTypeModel {
  const LeaveTypeModel({
    required this.id,
    required this.code,
    required this.name,
    required this.entitlement,
    this.description,
    required this.isAllowPlan,
    required this.isActive,
  });

  final String id;
  final String code;
  final String name;
  final int entitlement;
  final String? description;
  final bool isAllowPlan;
  final bool isActive;

  factory LeaveTypeModel.fromJson(Map<String, dynamic> json) {
    return LeaveTypeModel(
      id: json['id'] as String,
      code: json['code'] as String,
      name: json['name'] as String,
      entitlement: json['entitlement'] as int,
      description: json['description'] as String?,
      isAllowPlan: json['is_allow_plan'] as bool,
      isActive: json['is_active'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'name': name,
      'entitlement': entitlement,
      'description': description,
      'is_allow_plan': isAllowPlan,
      'is_active': isActive,
    };
  }
}
