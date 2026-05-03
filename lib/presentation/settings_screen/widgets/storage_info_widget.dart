import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../widgets/custom_icon_widget.dart';

/// Storage information and cache management widget
class StorageInfoWidget extends StatelessWidget {
  final String usedSpace;
  final int totalNotes;
  final VoidCallback onClearCache;

  const StorageInfoWidget({
    super.key,
    required this.usedSpace,
    required this.totalNotes,
    required this.onClearCache,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
                iconName: 'storage',
                color: theme.colorScheme.secondary,
                size: 20,
              ),
              SizedBox(width: 2.w),
              Text(
                'Storage Information',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          _buildStorageItem(
            context,
            'Used Space',
            usedSpace,
            Icons.folder_outlined,
          ),
          SizedBox(height: 1.5.h),
          _buildStorageItem(
            context,
            'Total Notes',
            totalNotes.toString(),
            Icons.note_outlined,
          ),
          SizedBox(height: 2.h),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                HapticFeedback.mediumImpact();
                onClearCache();
              },
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 1.5.h),
                side: BorderSide(color: theme.colorScheme.error, width: 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomIconWidget(
                    iconName: 'delete_outline',
                    color: theme.colorScheme.error,
                    size: 20,
                  ),
                  SizedBox(width: 2.w),
                  Text(
                    'Clear Cache',
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: theme.colorScheme.error,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build storage info item
  Widget _buildStorageItem(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    final theme = Theme.of(context);

    return Row(
      children: [
        CustomIconWidget(
          iconName: icon.codePoint.toString(),
          color: theme.colorScheme.onSurfaceVariant,
          size: 20,
        ),
        SizedBox(width: 3.w),
        Expanded(child: Text(label, style: theme.textTheme.bodyMedium)),
        Text(
          value,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.secondary,
          ),
        ),
      ],
    );
  }
}
