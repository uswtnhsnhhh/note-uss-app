import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

/// Widget displaying note title and category tags
class NoteHeaderWidget extends StatelessWidget {
  final String title;
  final List<String> categories;
  final VoidCallback onCategoryTap;

  const NoteHeaderWidget({
    super.key,
    required this.title,
    required this.categories,
    required this.onCategoryTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Note title
        Text(
          title,
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w700,
            color: theme.colorScheme.onSurface,
          ),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 2.h),
        // Category tags
        categories.isNotEmpty
            ? Wrap(
                spacing: 2.w,
                runSpacing: 1.h,
                children: categories.map((category) {
                  return InkWell(
                    onTap: onCategoryTap,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 4.w,
                        vertical: 0.8.h,
                      ),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.secondary.withValues(
                          alpha: 0.1,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: theme.colorScheme.secondary.withValues(
                            alpha: 0.3,
                          ),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        category,
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: theme.colorScheme.secondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
