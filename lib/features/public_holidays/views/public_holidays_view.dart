import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../app/theme/app_theme.dart';
import '../../../data/models/public_holiday_model.dart';
import '../../../widgets/app_shell_scaffold.dart';
import '../controllers/public_holidays_controller.dart';

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

class PublicHolidaysView extends StatelessWidget {
  const PublicHolidaysView({super.key});

  String _formatMonthHeading(DateTime month) =>
      '${_monthNames[month.month - 1]} ${month.year}';

  String _formatDate(String isoDate) {
    final parsed = DateTime.parse(isoDate);
    return '${_monthNames[parsed.month - 1].substring(0, 3)} ${parsed.day}, ${parsed.year}';
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PublicHolidaysController>();

    return AppShellScaffold(
      title: 'Public Holidays',
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
                    onPressed: controller.fetchHolidays,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        }

        final grouped = PublicHolidaysController.groupByDay(
          controller.holidays,
        );
        final monthHolidays = PublicHolidaysController.holidaysInMonth(
          controller.holidays,
          controller.focusedMonth.value,
        )..sort((a, b) => a.date.compareTo(b.date));

        return RefreshIndicator(
          onRefresh: controller.fetchHolidays,
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
                    child: TableCalendar<PublicHolidayModel>(
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
                      eventLoader: (day) =>
                          grouped[DateTime(day.year, day.month, day.day)] ??
                          const [],
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
                        markerDecoration: const BoxDecoration(
                          color: AppColors.warning,
                          shape: BoxShape.circle,
                        ),
                        markersMaxCount: 1,
                      ),
                      onPageChanged: (focusedDay) {
                        controller.focusedMonth.value = focusedDay;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Holidays in ${_formatMonthHeading(controller.focusedMonth.value)}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 12),
                if (monthHolidays.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: Center(
                      child: Text(
                        'No public holidays this month.',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ),
                  )
                else
                  ...monthHolidays.map(_buildHolidayCard),
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
}
