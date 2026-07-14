/// Minimal shape for a team_owner/team_members entry - enough for display,
/// not the full UserModel.
class TeamMemberSummary {
  const TeamMemberSummary({
    required this.id,
    this.fullName,
    required this.email,
  });

  final String id;
  final String? fullName;
  final String email;

  factory TeamMemberSummary.fromJson(Map<String, dynamic> json) {
    return TeamMemberSummary(
      id: json['id'] as String,
      fullName: json['full_name'] as String?,
      email: json['email'] as String,
    );
  }
}

/// Extended for Task 8.3's admin CRUD - the base id/name/teamOwnerId trio
/// (Phase 2's team-owner heuristic) stays required so existing callers are
/// unaffected.
class TeamModel {
  const TeamModel({
    required this.id,
    required this.name,
    required this.teamOwnerId,
    this.description,
    this.isActive = true,
    this.teamOwner,
    this.teamMembers = const [],
  });

  final String id;
  final String name;
  final String teamOwnerId;
  final String? description;
  final bool isActive;
  final TeamMemberSummary? teamOwner;
  final List<TeamMemberSummary> teamMembers;

  factory TeamModel.fromJson(Map<String, dynamic> json) {
    final ownerJson = json['team_owner'] as Map<String, dynamic>?;
    final membersJson = json['team_members'] as List? ?? [];
    return TeamModel(
      id: json['id'] as String,
      name: json['name'] as String,
      teamOwnerId: json['team_owner_id'] as String,
      description: json['description'] as String?,
      isActive: json['is_active'] as bool? ?? true,
      teamOwner: ownerJson != null
          ? TeamMemberSummary.fromJson(ownerJson)
          : null,
      teamMembers: membersJson
          .map((e) => TeamMemberSummary.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
