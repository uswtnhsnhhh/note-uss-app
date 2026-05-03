import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

/// No results state widget with create note option
/// Displays when search returns no results
class NoResultsStateWidget extends StatelessWidget {
  final String searchQuery;
  final VoidCallback onCreateNote;

  const NoResultsStateWidget({
    super.key,
    required this.searchQuery,
    required this.onCreateNote,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(6.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomIconWidget(
              iconName: 'search_off',
              color: isDark ? AppTheme.disabledDark : AppTheme.disabledLight,
              size: 64,
            ),
            SizedBox(height: 3.h),
            Text(
              'No Results Found',
              style: GoogleFonts.inter(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: isDark ? AppTheme.primaryDark : AppTheme.primaryLight,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 1.h),
            Text(
              'We couldn\'t find any notes matching "$searchQuery"',
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
            Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: isDark
                    ? AppTheme.accentDark.withValues(alpha: 0.1)
                    : AppTheme.accentLight.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isDark ? AppTheme.accentDark : AppTheme.accentLight,
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  CustomIconWidget(
                    iconName: 'lightbulb_outline',
                    color: isDark ? AppTheme.accentDark : AppTheme.accentLight,
                    size: 32,
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'Create a new note with this search term?',
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: isDark
                          ? AppTheme.primaryDark
                          : AppTheme.primaryLight,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 2.h),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        HapticFeedback.mediumImpact();
                        onCreateNote();
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 2.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomIconWidget(
                            iconName: 'add',
                            color: isDark
                                ? AppTheme.backgroundDark
                                : AppTheme.surfaceLight,
                            size: 20,
                          ),
                          SizedBox(width: 2.w),
                          Text(
                            'Create Note',
                            style: GoogleFonts.inter(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'Search Tips:',
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: isDark
                    ? AppTheme.secondaryDark
                    : AppTheme.secondaryLight,
              ),
            ),
            SizedBox(height: 1.h),
            _buildTip('• Try different keywords or phrases', isDark),
            _buildTip('• Check your spelling', isDark),
            _buildTip('• Use filters to narrow your search', isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildTip(String text, bool isDark) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.5.h),
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: 11.sp,
          fontWeight: FontWeight.w400,
          color: isDark ? AppTheme.secondaryDark : AppTheme.secondaryLight,
        ),
      ),
    );
  }
}
