import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../widgets/custom_icon_widget.dart';

/// About section widget with app information and support links
class AboutSectionWidget extends StatelessWidget {
  final VoidCallback onPrivacyPolicy;
  final VoidCallback onTermsOfService;
  final VoidCallback onContactSupport;

  const AboutSectionWidget({
    super.key,
    required this.onPrivacyPolicy,
    required this.onTermsOfService,
    required this.onContactSupport,
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
          _buildAboutItem(
            context,
            'App Version',
            '1.0.0',
            Icons.info_outline,
            null,
          ),
          SizedBox(height: 2.h),
          _buildAboutItem(
            context,
            'Privacy Policy',
            'View our privacy policy',
            Icons.privacy_tip_outlined,
            onPrivacyPolicy,
          ),
          SizedBox(height: 2.h),
          _buildAboutItem(
            context,
            'Terms of Service',
            'Read our terms and conditions',
            Icons.description_outlined,
            onTermsOfService,
          ),
          SizedBox(height: 2.h),
          _buildAboutItem(
            context,
            'Contact Support',
            'Get help and support',
            Icons.support_agent_outlined,
            onContactSupport,
          ),
        ],
      ),
    );
  }

  /// Build about section item
  Widget _buildAboutItem(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    VoidCallback? onTap,
  ) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap != null
          ? () {
              HapticFeedback.lightImpact();
              onTap();
            }
          : null,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.h),
        child: Row(
          children: [
            CustomIconWidget(
              iconName: icon.codePoint.toString(),
              color: theme.colorScheme.onSurfaceVariant,
              size: 20,
            ),
            SizedBox(width: 3.w),
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
            onTap != null
                ? CustomIconWidget(
                    iconName: 'chevron_right',
                    color: theme.colorScheme.onSurfaceVariant,
                    size: 20,
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
