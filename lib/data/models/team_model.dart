/// Minimal shape needed for the Phase 2 team-owner ("approver") heuristic —
/// extend with the rest of TeamPublic's fields when Phase 8's admin CRUD
/// needs them.
class TeamModel {
  const TeamModel({
    required this.id,
    required this.name,
    required this.teamOwnerId,
  });

  final String id;
  final String name;
  final String teamOwnerId;

  factory TeamModel.fromJson(Map<String, dynamic> json) {
    return TeamModel(
      id: json['id'] as String,
      name: json['name'] as String,
      teamOwnerId: json['team_owner_id'] as String,
    );
  }
}
