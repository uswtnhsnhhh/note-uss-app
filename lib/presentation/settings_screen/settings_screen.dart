import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_bottom_bar.dart';
import '../../widgets/custom_icon_widget.dart';
import './widgets/about_section_widget.dart';
import './widgets/auto_save_selector_widget.dart';
import './widgets/backup_options_widget.dart';
import './widgets/notification_settings_widget.dart';
import './widgets/storage_info_widget.dart';
import './widgets/text_size_slider_widget.dart';
import './widgets/theme_selector_widget.dart';

/// Settings Screen for Note'uss application
/// Provides comprehensive app customization and preferences management
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Theme settings
  String _selectedTheme = 'System';

  // Text size setting
  double _textSize = 16.0;

  // Auto-save frequency
  String _autoSaveFrequency = 'Every 30 seconds';

  // Notification settings
  bool _notificationsEnabled = true;
  bool _reminderAlerts = false;

  // Storage info
  final String _usedSpace = '45.2 MB';
  final int _totalNotes = 127;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: CustomAppBar.settings(context),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Appearance Section
                _buildSectionHeader(context, 'Appearance'),
                SizedBox(height: 1.h),
                ThemeSelectorWidget(
                  selectedTheme: _selectedTheme,
                  onThemeChanged: (theme) {
                    HapticFeedback.selectionClick();
                    setState(() => _selectedTheme = theme);
                  },
                ),
                SizedBox(height: 2.h),
                TextSizeSliderWidget(
                  textSize: _textSize,
                  onTextSizeChanged: (size) {
                    setState(() => _textSize = size);
                  },
                ),
                SizedBox(height: 3.h),

                // Editor Settings Section
                _buildSectionHeader(context, 'Editor Settings'),
                SizedBox(height: 1.h),
                AutoSaveSelectorWidget(
                  selectedFrequency: _autoSaveFrequency,
                  onFrequencyChanged: (frequency) {
                    HapticFeedback.selectionClick();
                    setState(() => _autoSaveFrequency = frequency);
                  },
                ),
                SizedBox(height: 3.h),

                // Notifications Section
                _buildSectionHeader(context, 'Notifications'),
                SizedBox(height: 1.h),
                NotificationSettingsWidget(
                  notificationsEnabled: _notificationsEnabled,
                  reminderAlerts: _reminderAlerts,
                  onNotificationsToggle: (value) {
                    HapticFeedback.selectionClick();
                    setState(() => _notificationsEnabled = value);
                  },
                  onReminderAlertsToggle: (value) {
                    HapticFeedback.selectionClick();
                    setState(() => _reminderAlerts = value);
                  },
                ),
                SizedBox(height: 3.h),

                // Storage Section
                _buildSectionHeader(context, 'Storage'),
                SizedBox(height: 1.h),
                StorageInfoWidget(
                  usedSpace: _usedSpace,
                  totalNotes: _totalNotes,
                  onClearCache: () {
                    HapticFeedback.mediumImpact();
                    _showClearCacheDialog(context);
                  },
                ),
                SizedBox(height: 3.h),

                // Backup & Export Section
                _buildSectionHeader(context, 'Backup & Export'),
                SizedBox(height: 1.h),
                BackupOptionsWidget(
                  onExportNotes: () {
                    HapticFeedback.lightImpact();
                    _showExportDialog(context);
                  },
                  onImportNotes: () {
                    HapticFeedback.lightImpact();
                    _showImportDialog(context);
                  },
                ),
                SizedBox(height: 3.h),

                // About Section
                _buildSectionHeader(context, 'About'),
                SizedBox(height: 1.h),
                AboutSectionWidget(
                  onPrivacyPolicy: () {
                    HapticFeedback.lightImpact();
                    _showInfoDialog(
                      context,
                      'Privacy Policy',
                      'Your privacy is important to us. We do not collect or share your personal data.',
                    );
                  },
                  onTermsOfService: () {
                    HapticFeedback.lightImpact();
                    _showInfoDialog(
                      context,
                      'Terms of Service',
                      'By using Note\'uss, you agree to our terms and conditions.',
                    );
                  },
                  onContactSupport: () {
                    HapticFeedback.lightImpact();
                    _showInfoDialog(
                      context,
                      'Contact Support',
                      'Email: support@noteuss.com\nPhone: +1 (555) 123-4567',
                    );
                  },
                ),
                SizedBox(height: 4.h),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomBar.withNavigation(
        context,
        currentIndex: 2,
      ),
    );
  }

  /// Build section header
  Widget _buildSectionHeader(BuildContext context, String title) {
    final theme = Theme.of(context);
    return Text(
      title,
      style: theme.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w600,
        letterSpacing: 0.15,
      ),
    );
  }

  /// Show clear cache confirmation dialog
  void _showClearCacheDialog(BuildContext context) {
    final theme = Theme.of(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Clear Cache', style: theme.textTheme.titleLarge),
        content: Text(
          'Are you sure you want to clear the cache? This will free up storage space but may slow down the app temporarily.',
          style: theme.textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () {
              HapticFeedback.lightImpact();
              Navigator.pop(context);
            },
            child: Text(
              'Cancel',
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.secondary,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              HapticFeedback.mediumImpact();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Cache cleared successfully',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            child: Text(
              'Clear',
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.onPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Show export dialog
  void _showExportDialog(BuildContext context) {
    final theme = Theme.of(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Export Notes', style: theme.textTheme.titleLarge),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Choose export format:', style: theme.textTheme.bodyMedium),
            SizedBox(height: 2.h),
            _buildExportOption(context, 'JSON Format', Icons.code),
            SizedBox(height: 1.h),
            _buildExportOption(context, 'PDF Document', Icons.picture_as_pdf),
            SizedBox(height: 1.h),
            _buildExportOption(context, 'Plain Text', Icons.text_fields),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              HapticFeedback.lightImpact();
              Navigator.pop(context);
            },
            child: Text(
              'Cancel',
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.secondary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build export option
  Widget _buildExportOption(BuildContext context, String label, IconData icon) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () {
        HapticFeedback.lightImpact();
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Exporting notes as $label...',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onPrimary,
              ),
            ),
            duration: const Duration(seconds: 2),
          ),
        );
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
        decoration: BoxDecoration(
          border: Border.all(color: theme.colorScheme.outline, width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            CustomIconWidget(
              iconName: icon.codePoint.toString(),
              color: theme.colorScheme.secondary,
              size: 24,
            ),
            SizedBox(width: 3.w),
            Text(label, style: theme.textTheme.bodyLarge),
          ],
        ),
      ),
    );
  }

  /// Show import dialog
  void _showImportDialog(BuildContext context) {
    final theme = Theme.of(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Import Notes', style: theme.textTheme.titleLarge),
        content: Text(
          'Select a backup file to import your notes. Supported formats: JSON, TXT',
          style: theme.textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () {
              HapticFeedback.lightImpact();
              Navigator.pop(context);
            },
            child: Text(
              'Cancel',
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.secondary,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              HapticFeedback.mediumImpact();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Importing notes...',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            child: Text(
              'Select File',
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.onPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Show info dialog
  void _showInfoDialog(BuildContext context, String title, String content) {
    final theme = Theme.of(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title, style: theme.textTheme.titleLarge),
        content: Text(content, style: theme.textTheme.bodyMedium),
        actions: [
          ElevatedButton(
            onPressed: () {
              HapticFeedback.lightImpact();
              Navigator.pop(context);
            },
            child: Text(
              'OK',
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.onPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
