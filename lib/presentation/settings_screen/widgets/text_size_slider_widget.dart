import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../widgets/custom_icon_widget.dart';

/// Text size adjustment slider with real-time preview
class TextSizeSliderWidget extends StatelessWidget {
  final double textSize;
  final ValueChanged<double> onTextSizeChanged;

  const TextSizeSliderWidget({
    super.key,
    required this.textSize,
    required this.onTextSizeChanged,
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
                iconName: 'text_fields',
                color: theme.colorScheme.secondary,
                size: 20,
              ),
              SizedBox(width: 2.w),
              Text(
                'Default Text Size',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Row(
            children: [
              Text(
                'A',
                style: theme.textTheme.bodySmall?.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Expanded(
                child: SliderTheme(
                  data: SliderThemeData(
                    activeTrackColor: theme.colorScheme.secondary,
                    thumbColor: theme.colorScheme.secondary,
                    overlayColor: theme.colorScheme.secondary.withValues(
                      alpha: 0.2,
                    ),
                    inactiveTrackColor: theme.colorScheme.outline,
                    trackHeight: 4.0,
                  ),
                  child: Slider(
                    value: textSize,
                    min: 12.0,
                    max: 24.0,
                    divisions: 12,
                    onChanged: onTextSizeChanged,
                  ),
                ),
              ),
              Text(
                'A',
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 1.h),
          Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
              decoration: BoxDecoration(
                color: theme.colorScheme.secondary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Preview Text',
                style: theme.textTheme.bodyMedium?.copyWith(fontSize: textSize),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
