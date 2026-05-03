import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

/// Advanced search filters widget
/// Includes date range, categories, and note length filters
class SearchFiltersWidget extends StatelessWidget {
  final String? selectedDateRange;
  final String? selectedCategory;
  final String? selectedLength;
  final ValueChanged<String?> onDateRangeChanged;
  final ValueChanged<String?> onCategoryChanged;
  final ValueChanged<String?> onLengthChanged;
  final VoidCallback onClearFilters;

  const SearchFiltersWidget({
    super.key,
    required this.selectedDateRange,
    required this.selectedCategory,
    required this.selectedLength,
    required this.onDateRangeChanged,
    required this.onCategoryChanged,
    required this.onLengthChanged,
    required this.onClearFilters,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final bool hasActiveFilters =
        selectedDateRange != null ||
        selectedCategory != null ||
        selectedLength != null;

    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.surfaceDark : AppTheme.surfaceLight,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Filters',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: isDark ? AppTheme.primaryDark : AppTheme.primaryLight,
                ),
              ),
              Row(
                children: [
                  if (hasActiveFilters)
                    TextButton(
                      onPressed: () {
                        HapticFeedback.lightImpact();
                        onClearFilters();
                      },
                      child: Text(
                        'Clear',
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: isDark
                              ? AppTheme.accentDark
                              : AppTheme.accentLight,
                        ),
                      ),
                    ),
                  IconButton(
                    icon: CustomIconWidget(
                      iconName: 'close',
                      color: isDark
                          ? AppTheme.secondaryDark
                          : AppTheme.secondaryLight,
                      size: 20,
                    ),
                    onPressed: () {
                      HapticFeedback.lightImpact();
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 2.h),
          _buildFilterSection(
            context,
            'Date Range',
            ['Today', 'Last 7 days', 'Last 30 days', 'Last 90 days'],
            selectedDateRange,
            onDateRangeChanged,
            isDark,
          ),
          SizedBox(height: 2.h),
          _buildFilterSection(
            context,
            'Category',
            ['Personal', 'Work', 'Ideas', 'To-Do', 'Important'],
            selectedCategory,
            onCategoryChanged,
            isDark,
          ),
          SizedBox(height: 2.h),
          _buildFilterSection(
            context,
            'Note Length',
            ['Short', 'Medium', 'Long'],
            selectedLength,
            onLengthChanged,
            isDark,
          ),
          SizedBox(height: 2.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                HapticFeedback.mediumImpact();
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 2.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Apply Filters',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection(
    BuildContext context,
    String title,
    List<String> options,
    String? selectedValue,
    ValueChanged<String?> onChanged,
    bool isDark,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: isDark ? AppTheme.secondaryDark : AppTheme.secondaryLight,
            letterSpacing: 0.5,
          ),
        ),
        SizedBox(height: 1.h),
        Wrap(
          spacing: 2.w,
          runSpacing: 1.h,
          children: options.map((option) {
            final isSelected = selectedValue == option;
            return InkWell(
              onTap: () {
                HapticFeedback.selectionClick();
                onChanged(isSelected ? null : option);
              },
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                decoration: BoxDecoration(
                  color: isSelected
                      ? (isDark ? AppTheme.accentDark : AppTheme.accentLight)
                      : (isDark
                            ? AppTheme.secondaryDark.withValues(alpha: 0.1)
                            : AppTheme.borderLight),
                  borderRadius: BorderRadius.circular(20),
                  border: isSelected
                      ? null
                      : Border.all(
                          color: isDark
                              ? AppTheme.borderDark
                              : AppTheme.borderLight,
                          width: 0.5,
                        ),
                ),
                child: Text(
                  option,
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: isSelected
                        ? (isDark
                              ? AppTheme.backgroundDark
                              : AppTheme.surfaceLight)
                        : (isDark
                              ? AppTheme.primaryDark
                              : AppTheme.primaryLight),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
