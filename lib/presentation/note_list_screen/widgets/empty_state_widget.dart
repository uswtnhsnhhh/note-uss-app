import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

/// Empty state widget shown when no notes exist
/// Displays friendly illustration and create prompt
class EmptyStateWidget extends StatelessWidget {
  final VoidCallback onCreateNote;

  const EmptyStateWidget({super.key, required this.onCreateNote});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomImageWidget(
                imageUrl:
                    'https://images.unsplash.com/photo-1484480974693-6ca0a78fb36b?w=400',
                width: 60.w,
                height: 30.h,
                fit: BoxFit.contain,
                semanticLabel:
                    'Illustration of an open notebook with a pen on a wooden desk, representing the concept of note-taking',
              ),
              SizedBox(height: 4.h),
              Text(
                'No Notes Yet',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 2.h),
              Text(
                'Start capturing your thoughts and ideas.\nTap the button below to create your first note.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 4.h),
              ElevatedButton.icon(
                onPressed: onCreateNote,
                icon: CustomIconWidget(
                  iconName: 'add',
                  size: 20,
                  color: theme.colorScheme.onSecondary,
                ),
                label: Text('Create Your First Note'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
