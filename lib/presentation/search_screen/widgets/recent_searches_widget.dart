import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

/// Recent searches widget displaying search history as chips
/// Includes individual delete and clear all functionality
class RecentSearchesWidget extends StatelessWidget {
  final List<String> recentSearches;
  final ValueChanged<String> onSearchTap;
  final ValueChanged<String> onDeleteSearch;
  final VoidCallback onClearAll;

  const RecentSearchesWidget({
    super.key,
    required this.recentSearches,
    required this.onSearchTap,
    required this.onDeleteSearch,
    required this.onClearAll,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    if (recentSearches.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Searches',
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: isDark
                      ? AppTheme.secondaryDark
                      : AppTheme.secondaryLight,
                  letterSpacing: 0.5,
                ),
              ),
              TextButton(
                onPressed: () {
                  HapticFeedback.lightImpact();
                  onClearAll();
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: 2.w,
                    vertical: 0.5.h,
                  ),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  'Clear All',
                  style: GoogleFonts.inter(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                    color: isDark ? AppTheme.accentDark : AppTheme.accentLight,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 1.h),
          Wrap(
            spacing: 2.w,
            runSpacing: 1.h,
            children: recentSearches.map((search) {
              return InkWell(
                onTap: () {
                  HapticFeedback.selectionClick();
                  onSearchTap(search);
                },
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppTheme.secondaryDark.withValues(alpha: 0.1)
                        : AppTheme.borderLight,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomIconWidget(
                        iconName: 'history',
                        color: isDark
                            ? AppTheme.secondaryDark
                            : AppTheme.secondaryLight,
                        size: 16,
                      ),
                      SizedBox(width: 2.w),
                      ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 40.w),
                        child: Text(
                          search,
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: isDark
                                ? AppTheme.primaryDark
                                : AppTheme.primaryLight,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 2.w),
                      InkWell(
                        onTap: () {
                          HapticFeedback.lightImpact();
                          onDeleteSearch(search);
                        },
                        child: CustomIconWidget(
                          iconName: 'close',
                          color: isDark
                              ? AppTheme.secondaryDark
                              : AppTheme.secondaryLight,
                          size: 14,
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
    );
  }
}
