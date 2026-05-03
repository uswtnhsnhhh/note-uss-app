import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

/// Auto-save indicator widget
/// Shows save status and last save time
class AutoSaveIndicatorWidget extends StatelessWidget {
  final bool isAutoSaving;
  final DateTime lastSaveTime;
  final bool hasUnsavedChanges;

  const AutoSaveIndicatorWidget({
    super.key,
    required this.isAutoSaving,
    required this.lastSaveTime,
    required this.hasUnsavedChanges,
  });

  /// Format last save time
  String _formatLastSaveTime() {
    final now = DateTime.now();
    final difference = now.difference(lastSaveTime);

    if (difference.inSeconds < 60) {
      return 'Saved just now';
    } else if (difference.inMinutes < 60) {
      return 'Saved ${difference.inMinutes}m ago';
    } else {
      return 'Saved ${difference.inHours}h ago';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return AnimatedOpacity(
      opacity: isAutoSaving || hasUnsavedChanges ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 300),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
        decoration: BoxDecoration(
          color: isAutoSaving
              ? (isDark ? AppTheme.accentDark : AppTheme.accentLight)
                    .withValues(alpha: 0.1)
              : Colors.transparent,
          border: Border(
            bottom: BorderSide(color: theme.dividerColor, width: 0.5),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isAutoSaving)
              SizedBox(
                width: 12,
                height: 12,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    isDark ? AppTheme.accentDark : AppTheme.accentLight,
                  ),
                ),
              )
            else
              CustomIconWidget(
                iconName: hasUnsavedChanges ? 'edit' : 'check_circle',
                color: hasUnsavedChanges
                    ? theme.colorScheme.onSurfaceVariant
                    : (isDark ? AppTheme.successDark : AppTheme.successLight),
                size: 14,
              ),
            SizedBox(width: 2.w),
            Text(
              isAutoSaving
                  ? 'Saving...'
                  : hasUnsavedChanges
                  ? 'Unsaved changes'
                  : _formatLastSaveTime(),
              style: theme.textTheme.bodySmall?.copyWith(
                color: isAutoSaving
                    ? (isDark ? AppTheme.accentDark : AppTheme.accentLight)
                    : theme.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
