class LeaveRecommendationItem {
  const LeaveRecommendationItem({
    required this.leaveDate,
    required this.bridgeHoliday,
    required this.teamWorkload,
    required this.preferenceScore,
    required this.predictedScore,
  });

  final DateTime leaveDate;
  final bool bridgeHoliday;
  final int teamWorkload;
  final int preferenceScore;
  final double predictedScore;

  factory LeaveRecommendationItem.fromJson(Map<String, dynamic> json) {
    return LeaveRecommendationItem(
      leaveDate: DateTime.parse(json['leave_date'] as String),
      bridgeHoliday: json['bridge_holiday'] as bool,
      teamWorkload: json['team_workload'] as int,
      preferenceScore: json['preference_score'] as int,
      predictedScore: (json['predicted_score'] as num).toDouble(),
    );
  }
}

/// Shape returned by `GET /recommends/leave-plan?year=` — a single object,
/// not the usual `{data, count}` paginated wrapper.
class LeaveRecommendationsModel {
  const LeaveRecommendationsModel({
    required this.leaveTypeId,
    required this.year,
    required this.data,
  });

  final String leaveTypeId;
  final int year;
  final List<LeaveRecommendationItem> data;

  factory LeaveRecommendationsModel.fromJson(Map<String, dynamic> json) {
    final items = json['data'] as List? ?? [];
    return LeaveRecommendationsModel(
      leaveTypeId: json['leave_type_id'] as String,
      year: json['year'] as int,
      data: items
          .map(
            (e) => LeaveRecommendationItem.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );
  }
}
