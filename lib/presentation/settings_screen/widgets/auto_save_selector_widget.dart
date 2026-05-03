import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../widgets/custom_icon_widget.dart';

/// Auto-save frequency selector widget
class AutoSaveSelectorWidget extends StatelessWidget {
  final String selectedFrequency;
  final ValueChanged<String> onFrequencyChanged;

  const AutoSaveSelectorWidget({
    super.key,
    required this.selectedFrequency,
    required this.onFrequencyChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final frequencies = [
      'Every 10 seconds',
      'Every 30 seconds',
      'Every minute',
      'Manual only',
    ];

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
                iconName: 'save',
                color: theme.colorScheme.secondary,
                size: 20,
              ),
              SizedBox(width: 2.w),
              Text(
                'Auto-Save Frequency',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          ...frequencies.map((frequency) {
            final isSelected = selectedFrequency == frequency;
            return InkWell(
              onTap: () {
                HapticFeedback.selectionClick();
                onFrequencyChanged(frequency);
              },
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.h),
                margin: EdgeInsets.only(bottom: 1.h),
                decoration: BoxDecoration(
                  color: isSelected
                      ? theme.colorScheme.secondary.withValues(alpha: 0.1)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isSelected
                        ? theme.colorScheme.secondary
                        : Colors.transparent,
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    CustomIconWidget(
                      iconName: isSelected
                          ? 'radio_button_checked'
                          : 'radio_button_unchecked',
                      color: isSelected
                          ? theme.colorScheme.secondary
                          : theme.colorScheme.onSurfaceVariant,
                      size: 20,
                    ),
                    SizedBox(width: 3.w),
                    Text(
                      frequency,
                      style: theme.textTheme.bodyMedium?.copyWith(
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
            );
          }),
        ],
      ),
    );
  }
}
