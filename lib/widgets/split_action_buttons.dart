import 'package:flutter/material.dart';

import '../app/theme/app_theme.dart';

/// Shared coral-Reject / teal-Accept pill button pair, matching the
/// reference design's approve/reject pattern. Replaces the inline
/// Approve/Reject `Row` in the approvals screen.
class SplitActionButtons extends StatelessWidget {
  const SplitActionButtons({
    super.key,
    required this.onReject,
    required this.onAccept,
    this.rejectLabel = 'Reject',
    this.acceptLabel = 'Accept',
    this.isLoading = false,
  });

  final VoidCallback? onReject;
  final VoidCallback? onAccept;
  final String rejectLabel;
  final String acceptLabel;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: onReject,
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.danger,
              side: BorderSide(color: AppColors.danger.withValues(alpha: 0.5)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppShapes.pillRadius),
              ),
            ),
            child: Text(rejectLabel),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed: onAccept,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppShapes.pillRadius),
              ),
            ),
            child: Text(acceptLabel),
          ),
        ),
      ],
    );
  }
}
