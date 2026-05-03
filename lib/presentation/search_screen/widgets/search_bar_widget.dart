import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

/// Search bar widget with real-time search functionality
/// Implements auto-focus, cancel button, and search term highlighting
class SearchBarWidget extends StatelessWidget {
  final TextEditingController searchController;
  final ValueChanged<String> onSearchChanged;
  final VoidCallback onCancel;
  final FocusNode focusNode;

  const SearchBarWidget({
    super.key,
    required this.searchController,
    required this.onSearchChanged,
    required this.onCancel,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.surfaceDark : AppTheme.surfaceLight,
        boxShadow: [
          BoxShadow(
            color: isDark ? AppTheme.shadowDark : AppTheme.shadowLight,
            offset: const Offset(0, 2),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 6.h,
              decoration: BoxDecoration(
                color: isDark
                    ? AppTheme.backgroundDark
                    : AppTheme.backgroundLight,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isDark ? AppTheme.borderDark : AppTheme.borderLight,
                  width: 0.5,
                ),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.w),
                    child: CustomIconWidget(
                      iconName: 'search',
                      color: isDark
                          ? AppTheme.secondaryDark
                          : AppTheme.secondaryLight,
                      size: 20,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      focusNode: focusNode,
                      onChanged: onSearchChanged,
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: isDark
                            ? AppTheme.primaryDark
                            : AppTheme.primaryLight,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Search notes...',
                        hintStyle: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: isDark
                              ? AppTheme.disabledDark
                              : AppTheme.disabledLight,
                        ),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                  searchController.text.isNotEmpty
                      ? IconButton(
                          icon: CustomIconWidget(
                            iconName: 'close',
                            color: isDark
                                ? AppTheme.secondaryDark
                                : AppTheme.secondaryLight,
                            size: 18,
                          ),
                          onPressed: () {
                            HapticFeedback.lightImpact();
                            searchController.clear();
                            onSearchChanged('');
                          },
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        )
                      : const SizedBox.shrink(),
                  SizedBox(width: 2.w),
                ],
              ),
            ),
          ),
          SizedBox(width: 3.w),
          TextButton(
            onPressed: () {
              HapticFeedback.lightImpact();
              onCancel();
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              'Cancel',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: isDark ? AppTheme.accentDark : AppTheme.accentLight,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
