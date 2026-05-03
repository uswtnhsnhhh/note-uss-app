import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

/// Notification settings widget with toggle switches
class NotificationSettingsWidget extends StatelessWidget {
  final bool notificationsEnabled;
  final bool reminderAlerts;
  final ValueChanged<bool> onNotificationsToggle;
  final ValueChanged<bool> onReminderAlertsToggle;

  const NotificationSettingsWidget({
    super.key,
    required this.notificationsEnabled,
    required this.reminderAlerts,
    required this.onNotificationsToggle,
    required this.onReminderAlertsToggle,
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
          _buildNotificationToggle(
            context,
            'Enable Notifications',
            'Receive app notifications',
            notificationsEnabled,
            onNotificationsToggle,
          ),
          SizedBox(height: 2.h),
          _buildNotificationToggle(
            context,
            'Reminder Alerts',
            'Get reminders for scheduled notes',
            reminderAlerts,
            onReminderAlertsToggle,
          ),
        ],
      ),
    );
  }

  /// Build notification toggle item
  Widget _buildNotificationToggle(
    BuildContext context,
    String title,
    String subtitle,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 0.5.h),
              Text(
                subtitle,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        Switch(
          value: value,
          onChanged: (newValue) {
            HapticFeedback.selectionClick();
            onChanged(newValue);
          },
          activeThumbColor: theme.colorScheme.secondary,
          activeTrackColor: theme.colorScheme.secondary.withValues(alpha: 0.5),
        ),
      ],
    );
  }
}
