import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

/// Custom bottom navigation bar for the note-taking application.
/// Implements touch-optimized navigation with proper thumb reach zones.
///
/// Features:
/// - Adaptive styling for light and dark themes
/// - Haptic feedback on navigation
/// - Smooth transitions between screens
/// - Clear visual indicators for active state
class CustomBottomBar extends StatelessWidget {
  /// Current selected index
  final int currentIndex;

  /// Callback when navigation item is tapped
  final ValueChanged<int> onTap;

  /// Variant of the bottom bar
  final CustomBottomBarVariant variant;

  const CustomBottomBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.variant = CustomBottomBarVariant.standard,
  });

  /// Factory constructor with default navigation setup
  factory CustomBottomBar.withNavigation(
    BuildContext context, {
    required int currentIndex,
  }) {
    return CustomBottomBar(
      currentIndex: currentIndex,
      onTap: (index) {
        HapticFeedback.selectionClick();
        _navigateToScreen(context, index);
      },
      variant: CustomBottomBarVariant.standard,
    );
  }

  /// Navigate to screen based on index
  static void _navigateToScreen(BuildContext context, int index) {
    final routes = ['/notes-list-screen', '/search-screen', '/settings-screen'];

    if (index >= 0 && index < routes.length) {
      Navigator.pushReplacementNamed(context, routes[index]);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final Color backgroundColor = isDark
        ? AppTheme.surfaceDark
        : AppTheme.surfaceLight;

    final Color selectedColor = isDark
        ? AppTheme.accentDark
        : AppTheme.accentLight;

    final Color unselectedColor = isDark
        ? AppTheme.secondaryDark
        : AppTheme.secondaryLight;

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
            color: isDark ? AppTheme.shadowDark : AppTheme.shadowLight,
            offset: const Offset(0, -2),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          height: _getBottomBarHeight(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _buildNavigationItems(
              context,
              selectedColor,
              unselectedColor,
            ),
          ),
        ),
      ),
    );
  }

  /// Build navigation items based on variant
  List<Widget> _buildNavigationItems(
    BuildContext context,
    Color selectedColor,
    Color unselectedColor,
  ) {
    final items = _getNavigationItems();

    return List.generate(items.length, (index) {
      final item = items[index];
      final isSelected = currentIndex == index;

      return Expanded(
        child: InkWell(
          onTap: () {
            HapticFeedback.selectionClick();
            onTap(index);
          },
          splashColor: selectedColor.withValues(alpha: 0.1),
          highlightColor: selectedColor.withValues(alpha: 0.05),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedContainer(
                  duration: AppTheme.shortAnimationDuration,
                  curve: AppTheme.defaultAnimationCurve,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? selectedColor.withValues(alpha: 0.1)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    isSelected ? item.selectedIcon : item.icon,
                    color: isSelected ? selectedColor : unselectedColor,
                    size: 24,
                  ),
                ),
                const SizedBox(height: 4),
                AnimatedDefaultTextStyle(
                  duration: AppTheme.shortAnimationDuration,
                  curve: AppTheme.defaultAnimationCurve,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    color: isSelected ? selectedColor : unselectedColor,
                    letterSpacing: 0.5,
                  ),
                  child: Text(
                    item.label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  /// Get navigation items based on variant
  List<_NavigationItem> _getNavigationItems() {
    switch (variant) {
      case CustomBottomBarVariant.standard:
        return [
          _NavigationItem(
            icon: Icons.note_outlined,
            selectedIcon: Icons.note,
            label: 'Notes',
          ),
          _NavigationItem(
            icon: Icons.search_outlined,
            selectedIcon: Icons.search,
            label: 'Search',
          ),
          _NavigationItem(
            icon: Icons.settings_outlined,
            selectedIcon: Icons.settings,
            label: 'Settings',
          ),
        ];
      case CustomBottomBarVariant.minimal:
        return [
          _NavigationItem(
            icon: Icons.note_outlined,
            selectedIcon: Icons.note,
            label: 'Notes',
          ),
          _NavigationItem(
            icon: Icons.search_outlined,
            selectedIcon: Icons.search,
            label: 'Search',
          ),
        ];
    }
  }

  /// Get bottom bar height based on variant
  double _getBottomBarHeight() {
    switch (variant) {
      case CustomBottomBarVariant.standard:
        return 72;
      case CustomBottomBarVariant.minimal:
        return 64;
    }
  }
}

/// Navigation item data class
class _NavigationItem {
  final IconData icon;
  final IconData selectedIcon;
  final String label;

  _NavigationItem({
    required this.icon,
    required this.selectedIcon,
    required this.label,
  });
}

/// Enum defining different bottom bar variants
enum CustomBottomBarVariant {
  /// Standard bottom bar with all navigation items
  standard,

  /// Minimal bottom bar with essential items only
  minimal,
}
