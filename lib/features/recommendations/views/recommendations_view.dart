import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/theme/app_theme.dart';
import '../../../data/models/leave_recommendation_model.dart';
import '../../../widgets/app_shell_scaffold.dart';
import '../controllers/recommendations_controller.dart';

class RecommendationsView extends StatelessWidget {
  const RecommendationsView({super.key});

  String _formatDate(DateTime date) {
    const weekdays = [
      'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun',
    ];
    return '${weekdays[date.weekday - 1]}, ${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RecommendationsController>();
    final currentYear = DateTime.now().year;
    final years = List<int>.generate(4, (i) => currentYear - 1 + i);

    return AppShellScaffold(
      title: 'Recommendations',
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Text(
                  'Year',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(width: 12),
                Obx(
                  () => DropdownButton<int>(
                    value: controller.selectedYear.value,
                    items: years
                        .map(
                          (y) => DropdownMenuItem(value: y, child: Text('$y')),
                        )
                        .toList(),
                    onChanged: (year) {
                      if (year != null) controller.changeYear(year);
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
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
                        Icon(
                          Icons.info_outline,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          controller.errorMessage.value!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: controller.fetchRecommendations,
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  ),
                );
              }

              final data = controller.recommendations.value?.data ?? [];
              if (data.isEmpty) {
                return const Center(
                  child: Text('No recommendations for this year.'),
                );
              }

              return RefreshIndicator(
                onRefresh: controller.fetchRecommendations,
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return _buildRecommendationCard(
                      controller,
                      data[index],
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendationCard(
    RecommendationsController controller,
    LeaveRecommendationItem item,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _formatDate(item.leaveDate),
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Score: ${item.predictedScore.toStringAsFixed(1)}',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            if (item.bridgeHoliday || item.teamWorkload > 0) ...[
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  if (item.bridgeHoliday) _buildBadge('Bridge holiday', AppColors.success),
                  if (item.teamWorkload > 0)
                    _buildBadge(
                      'Team workload: ${item.teamWorkload}',
                      AppColors.warning,
                    ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildBadge(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Text(
        label,
        style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.bold),
      ),
    );
  }
}
