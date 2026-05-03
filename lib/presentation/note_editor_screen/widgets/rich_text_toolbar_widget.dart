import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

/// Rich text toolbar widget for note formatting
/// Provides essential formatting options above keyboard
class RichTextToolbarWidget extends StatefulWidget {
  final quill.QuillController controller;
  final VoidCallback onOptionsPressed;

  const RichTextToolbarWidget({
    super.key,
    required this.controller,
    required this.onOptionsPressed,
  });

  @override
  State<RichTextToolbarWidget> createState() => _RichTextToolbarWidgetState();
}

class _RichTextToolbarWidgetState extends State<RichTextToolbarWidget> {
  bool _isExpanded = true;

  /// Toggle toolbar visibility
  void _toggleToolbar() {
    HapticFeedback.lightImpact();
    setState(() => _isExpanded = !_isExpanded);
  }

  /// Apply bold formatting
  void _applyBold() {
    HapticFeedback.lightImpact();
    widget.controller.formatSelection(quill.Attribute.bold);
  }

  /// Apply italic formatting
  void _applyItalic() {
    HapticFeedback.lightImpact();
    widget.controller.formatSelection(quill.Attribute.italic);
  }

  /// Apply underline formatting
  void _applyUnderline() {
    HapticFeedback.lightImpact();
    widget.controller.formatSelection(quill.Attribute.underline);
  }

  /// Apply bullet list
  void _applyBulletList() {
    HapticFeedback.lightImpact();
    widget.controller.formatSelection(quill.Attribute.ul);
  }

  /// Apply numbered list
  void _applyNumberedList() {
    HapticFeedback.lightImpact();
    widget.controller.formatSelection(quill.Attribute.ol);
  }

  /// Check if attribute is active
  bool _isAttributeActive(quill.Attribute attribute) {
    final selection = widget.controller.selection;
    if (selection.isCollapsed) return false;

    final styles = widget.controller.getAllSelectionStyles();
    return styles.any((style) => style.attributes.containsKey(attribute.key));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      height: _isExpanded ? 12.h : 6.h,
      decoration: BoxDecoration(
        color: isDark ? AppTheme.surfaceDark : AppTheme.surfaceLight,
        border: Border(top: BorderSide(color: theme.dividerColor, width: 0.5)),
        boxShadow: [
          BoxShadow(
            color: (isDark ? AppTheme.shadowDark : AppTheme.shadowLight)
                .withValues(alpha: 0.1),
            offset: const Offset(0, -2),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        children: [
          // Collapse/Expand button
          InkWell(
            onTap: _toggleToolbar,
            child: Container(
              height: 6.h,
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomIconWidget(
                    iconName: _isExpanded
                        ? 'keyboard_arrow_down'
                        : 'keyboard_arrow_up',
                    color: theme.colorScheme.onSurfaceVariant,
                    size: 20,
                  ),
                  SizedBox(width: 2.w),
                  Text(
                    _isExpanded ? 'Hide Toolbar' : 'Show Toolbar',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Formatting buttons
          if (_isExpanded)
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildToolbarButton(
                      icon: 'format_bold',
                      onPressed: _applyBold,
                      isActive: _isAttributeActive(quill.Attribute.bold),
                      theme: theme,
                    ),
                    _buildToolbarButton(
                      icon: 'format_italic',
                      onPressed: _applyItalic,
                      isActive: _isAttributeActive(quill.Attribute.italic),
                      theme: theme,
                    ),
                    _buildToolbarButton(
                      icon: 'format_underlined',
                      onPressed: _applyUnderline,
                      isActive: _isAttributeActive(quill.Attribute.underline),
                      theme: theme,
                    ),
                    Container(width: 1, height: 4.h, color: theme.dividerColor),
                    _buildToolbarButton(
                      icon: 'format_list_bulleted',
                      onPressed: _applyBulletList,
                      isActive: _isAttributeActive(quill.Attribute.ul),
                      theme: theme,
                    ),
                    _buildToolbarButton(
                      icon: 'format_list_numbered',
                      onPressed: _applyNumberedList,
                      isActive: _isAttributeActive(quill.Attribute.ol),
                      theme: theme,
                    ),
                    Container(width: 1, height: 4.h, color: theme.dividerColor),
                    _buildToolbarButton(
                      icon: 'more_horiz',
                      onPressed: widget.onOptionsPressed,
                      isActive: false,
                      theme: theme,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  /// Build toolbar button
  Widget _buildToolbarButton({
    required String icon,
    required VoidCallback onPressed,
    required bool isActive,
    required ThemeData theme,
  }) {
    final isDark = theme.brightness == Brightness.dark;
    final activeColor = isDark ? AppTheme.accentDark : AppTheme.accentLight;
    final inactiveColor = theme.colorScheme.onSurfaceVariant;

    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 10.w,
        height: 10.w,
        decoration: BoxDecoration(
          color: isActive
              ? activeColor.withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: CustomIconWidget(
            iconName: icon,
            color: isActive ? activeColor : inactiveColor,
            size: 20,
          ),
        ),
      ),
    );
  }
}
