class TeamSummary {
  const TeamSummary({required this.id, required this.name});

  final String id;
  final String name;

  factory TeamSummary.fromJson(Map<String, dynamic> json) {
    return TeamSummary(id: json['id'] as String, name: json['name'] as String);
  }
}

/// Mirrors the backend's `UserPublic` response from `/users/me`.
class UserModel {
  const UserModel({
    required this.id,
    required this.email,
    required this.isActive,
    required this.isSuperuser,
    this.fullName,
    this.team,
  });

  final String id;
  final String email;
  final bool isActive;
  final bool isSuperuser;
  final String? fullName;
  final TeamSummary? team;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final teamJson = json['team'] as Map<String, dynamic>?;
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      isActive: json['is_active'] as bool,
      isSuperuser: json['is_superuser'] as bool,
      fullName: json['full_name'] as String?,
      team: teamJson != null ? TeamSummary.fromJson(teamJson) : null,
    );
  }
}
