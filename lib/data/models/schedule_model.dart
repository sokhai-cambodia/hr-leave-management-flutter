import 'leave_balance_model.dart';
import 'public_holiday_model.dart';
import 'user_summary.dart';

/// Mirrors the backend's `GET /schedule/` response (Task 11.3) - public
/// holidays plus the caller's team's approved leave for the given month,
/// combined into one payload for a single calendar screen.
class ScheduleModel {
  const ScheduleModel({
    required this.year,
    required this.month,
    required this.publicHolidays,
    required this.teamLeave,
  });

  final int year;
  final int month;
  final List<PublicHolidayModel> publicHolidays;
  final List<TeamLeaveEntryModel> teamLeave;

  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    final holidaysJson = json['public_holidays'] as List;
    final teamLeaveJson = json['team_leave'] as List;
    return ScheduleModel(
      year: json['year'] as int,
      month: json['month'] as int,
      publicHolidays: holidaysJson
          .map((e) => PublicHolidayModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      teamLeave: teamLeaveJson
          .map((e) => TeamLeaveEntryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

/// One `team_leave` entry - unifies a LeaveRequest (a real date range) and a
/// single LeavePlanRequest day (`startDate == endDate`) into one flat shape,
/// per the backend's schedule endpoint design.
class TeamLeaveEntryModel {
  const TeamLeaveEntryModel({
    required this.id,
    required this.source,
    required this.owner,
    required this.leaveType,
    required this.startDate,
    required this.endDate,
  });

  final String id;
  final String source; // 'leave_request' | 'leave_plan_request'
  final UserSummary owner;
  final LeaveTypeSummary leaveType;
  final String startDate;
  final String endDate;

  factory TeamLeaveEntryModel.fromJson(Map<String, dynamic> json) {
    return TeamLeaveEntryModel(
      id: json['id'] as String,
      source: json['source'] as String,
      owner: UserSummary.fromJson(json['owner'] as Map<String, dynamic>),
      leaveType: LeaveTypeSummary.fromJson(
        json['leave_type'] as Map<String, dynamic>,
      ),
      startDate: json['start_date'] as String,
      endDate: json['end_date'] as String,
    );
  }
}
