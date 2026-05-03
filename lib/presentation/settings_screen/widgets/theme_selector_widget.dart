import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../widgets/custom_icon_widget.dart';

/// Theme selector widget with live preview thumbnails
class ThemeSelectorWidget extends StatelessWidget {
  final String selectedTheme;
  final ValueChanged<String> onThemeChanged;

  const ThemeSelectorWidget({
    super.key,
    required this.selectedTheme,
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final themes = ['Light', 'Dark', 'System'];

    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.4),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomIconWidget(
                iconName: 'palette',
                color: theme.colorScheme.secondary,
                size: 20,
              ),
              SizedBox(width: 2.w),
              Text(
                'Theme',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: themes.map((themeOption) {
              final isSelected = selectedTheme == themeOption;
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    HapticFeedback.selectionClick();
                    onThemeChanged(themeOption);
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 1.w),
                    padding: EdgeInsets.symmetric(vertical: 1.5.h),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? theme.colorScheme.secondary.withValues(alpha: 0.1)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isSelected
                            ? theme.colorScheme.secondary
                            : theme.colorScheme.outline.withValues(alpha: 0.3),
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        _buildThemePreview(context, themeOption),
                        SizedBox(height: 1.h),
                        Text(
                          themeOption,
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.w400,
                            color: isSelected
                                ? theme.colorScheme.secondary
                                : theme.colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  /// Build theme preview thumbnail
  Widget _buildThemePreview(BuildContext context, String themeOption) {
    final theme = Theme.of(context);
    Color previewColor;

    if (themeOption == 'Light') {
      previewColor = const Color(0xFFF8F9FA);
    } else if (themeOption == 'Dark') {
      previewColor = const Color(0xFF121212);
    } else {
      previewColor = theme.brightness == Brightness.dark
          ? const Color(0xFF121212)
          : const Color(0xFFF8F9FA);
    }

    return Container(
      width: 15.w,
      height: 8.h,
      decoration: BoxDecoration(
        color: previewColor,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Center(
        child: CustomIconWidget(
          iconName: themeOption == 'Light'
              ? 'wb_sunny'
              : themeOption == 'Dark'
              ? 'nights_stay'
              : 'brightness_auto',
          color: themeOption == 'Light'
              ? const Color(0xFF2C3E50)
              : const Color(0xFFE9ECEF),
          size: 20,
        ),
      ),
    );
  }
}
