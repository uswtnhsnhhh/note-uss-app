import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

/// Empty search state widget with helpful suggestions
/// Displays when no search query is entered
class EmptySearchStateWidget extends StatelessWidget {
  final ValueChanged<String> onSuggestionTap;

  const EmptySearchStateWidget({super.key, required this.onSuggestionTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final List<String> suggestions = [
      'meeting notes',
      'project ideas',
      'shopping list',
      'daily journal',
      'work tasks',
    ];

    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(6.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomIconWidget(
              iconName: 'search',
              color: isDark ? AppTheme.disabledDark : AppTheme.disabledLight,
              size: 64,
            ),
            SizedBox(height: 3.h),
            Text(
              'Search Your Notes',
              style: GoogleFonts.inter(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: isDark ? AppTheme.primaryDark : AppTheme.primaryLight,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 1.h),
            Text(
              'Try searching for keywords, titles, or content',
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: isDark
                    ? AppTheme.secondaryDark
                    : AppTheme.secondaryLight,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 4.h),
            Text(
              'Popular Searches',
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: isDark
                    ? AppTheme.secondaryDark
                    : AppTheme.secondaryLight,
                letterSpacing: 0.5,
              ),
            ),
            SizedBox(height: 2.h),
            Wrap(
              spacing: 2.w,
              runSpacing: 1.h,
              alignment: WrapAlignment.center,
              children: suggestions.map((suggestion) {
                return InkWell(
                  onTap: () => onSuggestionTap(suggestion),
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 4.w,
                      vertical: 1.h,
                    ),
                    decoration: BoxDecoration(
                      color: isDark
                          ? AppTheme.secondaryDark.withValues(alpha: 0.1)
                          : AppTheme.borderLight,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isDark
                            ? AppTheme.borderDark
                            : AppTheme.borderLight,
                        width: 0.5,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomIconWidget(
                          iconName: 'trending_up',
                          color: isDark
                              ? AppTheme.accentDark
                              : AppTheme.accentLight,
                          size: 14,
                        ),
                        SizedBox(width: 2.w),
                        Text(
                          suggestion,
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: isDark
                                ? AppTheme.primaryDark
                                : AppTheme.primaryLight,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
