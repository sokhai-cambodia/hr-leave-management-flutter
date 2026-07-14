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
    this.username,
    this.phoneNumber,
    this.team,
    this.teamId,
  });

  final String id;
  final String email;
  final bool isActive;
  final bool isSuperuser;
  final String? fullName;

  /// Admin-set only - not self-editable (see Profile). Lets the user log in
  /// with either this or their email.
  final String? username;

  /// Self-editable via Profile - used for the QR business-card feature.
  final String? phoneNumber;
  final TeamSummary? team;

  /// The raw FK, alongside the resolved [team] object - kept distinct so
  /// Task 8.3's team-picker prefill can read the id directly rather than
  /// assuming [team] is always populated wherever [teamId] is.
  final String? teamId;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final teamJson = json['team'] as Map<String, dynamic>?;
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      isActive: json['is_active'] as bool,
      isSuperuser: json['is_superuser'] as bool,
      fullName: json['full_name'] as String?,
      username: json['username'] as String?,
      phoneNumber: json['phone_number'] as String?,
      team: teamJson != null ? TeamSummary.fromJson(teamJson) : null,
      teamId: json['team_id'] as String?,
    );
  }
}
