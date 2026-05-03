import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

/// Individual search result item widget
/// Displays note with highlighted search terms and swipe actions
class SearchResultItemWidget extends StatelessWidget {
  final Map<String, dynamic> note;
  final String searchQuery;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final VoidCallback onShare;

  const SearchResultItemWidget({
    super.key,
    required this.note,
    required this.searchQuery,
    required this.onTap,
    required this.onDelete,
    required this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Dismissible(
      key: Key(note['id'].toString()),
      background: _buildSwipeBackground(isDark, true),
      secondaryBackground: _buildSwipeBackground(isDark, false),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.endToStart) {
          HapticFeedback.mediumImpact();
          onDelete();
          return false;
        } else {
          HapticFeedback.lightImpact();
          onShare();
          return false;
        }
      },
      child: InkWell(
        onTap: () {
          HapticFeedback.selectionClick();
          onTap();
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
          padding: EdgeInsets.all(4.w),
          decoration: BoxDecoration(
            color: isDark ? AppTheme.surfaceDark : AppTheme.surfaceLight,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isDark ? AppTheme.borderDark : AppTheme.borderLight,
              width: 0.5,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: _buildHighlightedText(
                      note['title'] as String,
                      searchQuery,
                      GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: isDark
                            ? AppTheme.primaryDark
                            : AppTheme.primaryLight,
                      ),
                      isDark,
                    ),
                  ),
                  if (note['category'] != null) ...[
                    SizedBox(width: 2.w),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 2.w,
                        vertical: 0.5.h,
                      ),
                      decoration: BoxDecoration(
                        color: _getCategoryColor(
                          note['category'] as String,
                        ).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        note['category'] as String,
                        style: GoogleFonts.inter(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w500,
                          color: _getCategoryColor(note['category'] as String),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              SizedBox(height: 1.h),
              _buildHighlightedText(
                note['content'] as String,
                searchQuery,
                GoogleFonts.inter(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: isDark
                      ? AppTheme.secondaryDark
                      : AppTheme.secondaryLight,
                  height: 1.4,
                ),
                isDark,
                maxLines: 3,
              ),
              SizedBox(height: 1.h),
              Row(
                children: [
                  CustomIconWidget(
                    iconName: 'access_time',
                    color: isDark
                        ? AppTheme.disabledDark
                        : AppTheme.disabledLight,
                    size: 12,
                  ),
                  SizedBox(width: 1.w),
                  Text(
                    _formatDate(note['timestamp'] as DateTime),
                    style: GoogleFonts.roboto(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w400,
                      color: isDark
                          ? AppTheme.disabledDark
                          : AppTheme.disabledLight,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSwipeBackground(bool isDark, bool isLeft) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: isLeft ? AppTheme.accentLight : AppTheme.errorLight,
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: isLeft ? Alignment.centerLeft : Alignment.centerRight,
      padding: EdgeInsets.symmetric(horizontal: 6.w),
      child: CustomIconWidget(
        iconName: isLeft ? 'share' : 'delete',
        color: AppTheme.surfaceLight,
        size: 24,
      ),
    );
  }

  Widget _buildHighlightedText(
    String text,
    String query,
    TextStyle baseStyle,
    bool isDark, {
    int? maxLines,
  }) {
    if (query.isEmpty || query.length < 2) {
      return Text(
        text,
        style: baseStyle,
        maxLines: maxLines,
        overflow: maxLines != null ? TextOverflow.ellipsis : TextOverflow.visible,
      );
    }

    final List<TextSpan> spans = [];
    final lowerText = text.toLowerCase();
    final lowerQuery = query.toLowerCase();
    int start = 0;

    while (true) {
      final index = lowerText.indexOf(lowerQuery, start);
      if (index == -1) {
        if (start < text.length) {
          spans.add(TextSpan(text: text.substring(start)));
        }
        break;
      }

      if (index > start) {
        spans.add(TextSpan(text: text.substring(start, index)));
      }

      spans.add(
        TextSpan(
          text: text.substring(index, index + query.length),
          style: baseStyle.copyWith(
            backgroundColor: isDark
                ? AppTheme.accentDark.withValues(alpha: 0.3)
                : AppTheme.accentLight.withValues(alpha: 0.2),
            fontWeight: FontWeight.w600,
          ),
        ),
      );

      start = index + query.length;
    }

    return RichText(
      text: TextSpan(style: baseStyle, children: spans),
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : TextOverflow.visible,
    );
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'personal':
        return const Color(0xFF3498DB);
      case 'work':
        return const Color(0xFFE74C3C);
      case 'ideas':
        return const Color(0xFFF39C12);
      case 'to-do':
        return const Color(0xFF27AE60);
      case 'important':
        return const Color(0xFF9B59B6);
      default:
        return AppTheme.accentLight;
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Today ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${date.month}/${date.day}/${date.year}';
    }
  }
}