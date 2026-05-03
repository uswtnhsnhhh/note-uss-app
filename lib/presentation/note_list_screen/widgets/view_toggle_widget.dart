import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

/// Toggle widget for switching between list and grid view
class ViewToggleWidget extends StatelessWidget {
  final bool isGridView;
  final ValueChanged<bool> onToggle;

  const ViewToggleWidget({
    super.key,
    required this.isGridView,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      padding: EdgeInsets.all(0.5.w),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.surfaceDark : AppTheme.surfaceLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? AppTheme.borderDark : AppTheme.borderLight,
          width: 0.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildToggleButton(
            context: context,
            icon: 'view_list',
            label: 'List',
            isSelected: !isGridView,
            onTap: () {
              if (isGridView) {
                HapticFeedback.selectionClick();
                onToggle(false);
              }
            },
          ),
          SizedBox(width: 1.w),
          _buildToggleButton(
            context: context,
            icon: 'grid_view',
            label: 'Grid',
            isSelected: isGridView,
            onTap: () {
              if (!isGridView) {
                HapticFeedback.selectionClick();
                onToggle(true);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildToggleButton({
    required BuildContext context,
    required String icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: AnimatedContainer(
        duration: AppTheme.shortAnimationDuration,
        curve: AppTheme.defaultAnimationCurve,
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDark ? AppTheme.accentDark : AppTheme.accentLight)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomIconWidget(
              iconName: icon,
              size: 18,
              color: isSelected
                  ? (isDark ? AppTheme.backgroundDark : AppTheme.surfaceLight)
                  : theme.colorScheme.onSurfaceVariant,
            ),
            SizedBox(width: 1.w),
            Text(
              label,
              style: theme.textTheme.labelLarge?.copyWith(
                color: isSelected
                    ? (isDark ? AppTheme.backgroundDark : AppTheme.surfaceLight)
                    : theme.colorScheme.onSurfaceVariant,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
