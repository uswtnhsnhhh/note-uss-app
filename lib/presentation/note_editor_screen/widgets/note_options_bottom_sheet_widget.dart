import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

/// Note options bottom sheet widget
/// Provides additional note configuration options
class NoteOptionsBottomSheetWidget extends StatefulWidget {
  final String selectedCategory;
  final DateTime? reminderTime;
  final double textSize;
  final ValueChanged<String> onCategoryChanged;
  final ValueChanged<DateTime?> onReminderChanged;
  final ValueChanged<double> onTextSizeChanged;

  const NoteOptionsBottomSheetWidget({
    super.key,
    required this.selectedCategory,
    required this.reminderTime,
    required this.textSize,
    required this.onCategoryChanged,
    required this.onReminderChanged,
    required this.onTextSizeChanged,
  });

  @override
  State<NoteOptionsBottomSheetWidget> createState() =>
      _NoteOptionsBottomSheetWidgetState();
}

class _NoteOptionsBottomSheetWidgetState
    extends State<NoteOptionsBottomSheetWidget> {
  late String _selectedCategory;
  late DateTime? _reminderTime;
  late double _textSize;

  final List<String> _categories = [
    'Personal',
    'Work',
    'Study',
    'Ideas',
    'Shopping',
    'Travel',
  ];

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.selectedCategory;
    _reminderTime = widget.reminderTime;
    _textSize = widget.textSize;
  }

  /// Show date time picker for reminder
  Future<void> _selectReminderTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _reminderTime ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (date != null && mounted) {
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_reminderTime ?? DateTime.now()),
      );

      if (time != null && mounted) {
        final reminderDateTime = DateTime(
          date.year,
          date.month,
          date.day,
          time.hour,
          time.minute,
        );

        setState(() => _reminderTime = reminderDateTime);
        widget.onReminderChanged(reminderDateTime);
        HapticFeedback.lightImpact();
      }
    }
  }

  /// Clear reminder
  void _clearReminder() {
    setState(() => _reminderTime = null);
    widget.onReminderChanged(null);
    HapticFeedback.lightImpact();
  }

  /// Format reminder time
  String _formatReminderTime() {
    if (_reminderTime == null) return 'No reminder set';

    final now = DateTime.now();
    final difference = _reminderTime!.difference(now);

    if (difference.inDays > 0) {
      return '${difference.inDays} days from now';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours from now';
    } else {
      return '${difference.inMinutes} minutes from now';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              margin: EdgeInsets.only(top: 2.h),
              width: 12.w,
              height: 4,
              decoration: BoxDecoration(
                color: theme.colorScheme.onSurfaceVariant.withValues(
                  alpha: 0.3,
                ),
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // Title
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Note Options', style: theme.textTheme.titleLarge),
                  IconButton(
                    icon: CustomIconWidget(
                      iconName: 'close',
                      color: theme.colorScheme.onSurfaceVariant,
                      size: 24,
                    ),
                    onPressed: () {
                      HapticFeedback.lightImpact();
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),

            Divider(height: 1, color: theme.dividerColor),

            // Category selection
            Padding(
              padding: EdgeInsets.all(4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Category', style: theme.textTheme.titleMedium),
                  SizedBox(height: 2.h),
                  Wrap(
                    spacing: 2.w,
                    runSpacing: 1.h,
                    children: _categories.map((category) {
                      final isSelected = category == _selectedCategory;
                      return InkWell(
                        onTap: () {
                          setState(() => _selectedCategory = category);
                          widget.onCategoryChanged(category);
                          HapticFeedback.lightImpact();
                        },
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 4.w,
                            vertical: 1.h,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? (isDark
                                      ? AppTheme.accentDark
                                      : AppTheme.accentLight)
                                : theme.colorScheme.surface,
                            border: Border.all(
                              color: isSelected
                                  ? (isDark
                                        ? AppTheme.accentDark
                                        : AppTheme.accentLight)
                                  : theme.colorScheme.outline,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            category,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: isSelected
                                  ? (isDark
                                        ? AppTheme.backgroundDark
                                        : AppTheme.surfaceLight)
                                  : theme.colorScheme.onSurface,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            Divider(height: 1, color: theme.dividerColor),

            // Reminder
            Padding(
              padding: EdgeInsets.all(4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Reminder', style: theme.textTheme.titleMedium),
                  SizedBox(height: 2.h),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          _formatReminderTime(),
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                      if (_reminderTime != null)
                        IconButton(
                          icon: CustomIconWidget(
                            iconName: 'clear',
                            color: theme.colorScheme.error,
                            size: 20,
                          ),
                          onPressed: _clearReminder,
                        ),
                      ElevatedButton.icon(
                        onPressed: _selectReminderTime,
                        icon: CustomIconWidget(
                          iconName: 'alarm_add',
                          color: isDark
                              ? AppTheme.backgroundDark
                              : AppTheme.surfaceLight,
                          size: 20,
                        ),
                        label: Text(_reminderTime == null ? 'Set' : 'Change'),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Divider(height: 1, color: theme.dividerColor),

            // Text size
            Padding(
              padding: EdgeInsets.all(4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Text Size', style: theme.textTheme.titleMedium),
                      Text(
                        '${_textSize.toInt()}',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  Slider(
                    value: _textSize,
                    min: 12,
                    max: 24,
                    divisions: 12,
                    onChanged: (value) {
                      setState(() => _textSize = value);
                      widget.onTextSizeChanged(value);
                      HapticFeedback.selectionClick();
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }
}
