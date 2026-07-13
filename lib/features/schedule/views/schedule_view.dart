import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../app/theme/app_theme.dart';
import '../../../data/models/public_holiday_model.dart';
import '../../../data/models/schedule_model.dart';
import '../../../widgets/app_shell_scaffold.dart';
import '../controllers/schedule_controller.dart';

const _monthNames = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December',
];

class ScheduleView extends StatelessWidget {
  const ScheduleView({super.key});

  String _formatMonthHeading(DateTime month) =>
      '${_monthNames[month.month - 1]} ${month.year}';

  String _formatDate(String isoDate) {
    final parsed = DateTime.parse(isoDate);
    return '${_monthNames[parsed.month - 1].substring(0, 3)} ${parsed.day}, ${parsed.year}';
  }

  String _formatDateRange(String startIso, String endIso) {
    if (startIso == endIso) return _formatDate(startIso);
    return '${_formatDate(startIso)} – ${_formatDate(endIso)}';
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ScheduleController>();

    return AppShellScaffold(
      title: 'Schedule',
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.value != null) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64, color: AppColors.danger),
                  const SizedBox(height: 16),
                  Text(
                    controller.errorMessage.value!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: controller.fetchSchedule,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        }

        final schedule = controller.schedule.value;
        final holidays = schedule?.publicHolidays ?? const [];
        final teamLeave = schedule?.teamLeave ?? const [];

        final groupedHolidays = ScheduleController.groupHolidaysByDay(
          holidays,
        );
        final groupedTeamLeave = ScheduleController.groupTeamLeaveByDay(
          teamLeave,
        );

        final sortedHolidays = [...holidays]
          ..sort((a, b) => a.date.compareTo(b.date));
        final sortedTeamLeave = [...teamLeave]
          ..sort((a, b) => a.startDate.compareTo(b.startDate));

        return RefreshIndicator(
          onRefresh: controller.fetchSchedule,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  clipBehavior: Clip.antiAlias,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: TableCalendar<Object>(
                      firstDay: DateTime.utc(2020, 1, 1),
                      lastDay: DateTime.utc(2035, 12, 31),
                      focusedDay: controller.focusedMonth.value,
                      calendarFormat: CalendarFormat.month,
                      headerStyle: const HeaderStyle(
                        formatButtonVisible: false,
                        titleCentered: true,
                        titleTextStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                        leftChevronIcon: Icon(Icons.chevron_left_outlined),
                        rightChevronIcon: Icon(Icons.chevron_right_outlined),
                      ),
                      daysOfWeekStyle: const DaysOfWeekStyle(
                        weekdayStyle: TextStyle(color: Colors.grey),
                        weekendStyle: TextStyle(color: Colors.grey),
                      ),
                      eventLoader: (day) {
                        final key = DateTime(day.year, day.month, day.day);
                        return [
                          ...?groupedHolidays[key],
                          ...?groupedTeamLeave[key],
                        ];
                      },
                      calendarStyle: CalendarStyle(
                        outsideDaysVisible: false,
                        todayDecoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                        ),
                        todayTextStyle: const TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      calendarBuilders: CalendarBuilders<Object>(
                        markerBuilder: (context, day, events) {
                          if (events.isEmpty) return null;
                          final key = DateTime(day.year, day.month, day.day);
                          final hasHoliday = groupedHolidays.containsKey(key);
                          final hasTeamLeave = groupedTeamLeave.containsKey(
                            key,
                          );
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (hasHoliday)
                                const _MarkerDot(color: AppColors.warning),
                              if (hasHoliday && hasTeamLeave)
                                const SizedBox(width: 3),
                              if (hasTeamLeave)
                                const _MarkerDot(color: AppColors.primary),
                            ],
                          );
                        },
                      ),
                      onPageChanged: (focusedDay) {
                        controller.changeMonth(focusedDay);
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const _LegendDot(
                      color: AppColors.warning,
                      label: 'Public Holiday',
                    ),
                    const SizedBox(width: 16),
                    const _LegendDot(
                      color: AppColors.primary,
                      label: 'Team Leave',
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  'Holidays in ${_formatMonthHeading(controller.focusedMonth.value)}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 12),
                if (sortedHolidays.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Center(
                      child: Text(
                        'No public holidays this month.',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ),
                  )
                else
                  ...sortedHolidays.map(_buildHolidayCard),
                const SizedBox(height: 20),
                Text(
                  'Team Leave in ${_formatMonthHeading(controller.focusedMonth.value)}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 12),
                if (sortedTeamLeave.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Center(
                      child: Text(
                        'No teammates on leave this month.',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ),
                  )
                else
                  ...sortedTeamLeave.map(_buildTeamLeaveCard),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildHolidayCard(PublicHolidayModel holiday) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.event_outlined, color: AppColors.primary),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    holiday.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (holiday.description != null &&
                      holiday.description!.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      holiday.description!,
                      style: TextStyle(color: Colors.grey[600], fontSize: 13),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(
              _formatDate(holiday.date),
              style: TextStyle(color: Colors.grey[800], fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamLeaveCard(TeamLeaveEntryModel entry) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.person_outline, color: AppColors.primary),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.owner.fullName ?? entry.owner.email,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    entry.leaveType.name,
                    style: TextStyle(color: Colors.grey[600], fontSize: 13),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(
              _formatDateRange(entry.startDate, entry.endDate),
              style: TextStyle(color: Colors.grey[800], fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}

class _MarkerDot extends StatelessWidget {
  const _MarkerDot({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 6,
      height: 6,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

class _LegendDot extends StatelessWidget {
  const _LegendDot({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[700])),
      ],
    );
  }
}
