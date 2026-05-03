import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

/// Custom app bar widget for the note-taking application.
/// Implements Contemporary Spatial Minimalism with clean, focused design.
///
/// Features:
/// - Adaptive styling for light and dark themes
/// - Optional search functionality
/// - Contextual actions based on screen
/// - Smooth transitions and haptic feedback
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// The title to display in the app bar
  final String title;

  /// Optional leading widget (back button, menu, etc.)
  final Widget? leading;

  /// Optional actions to display on the right side
  final List<Widget>? actions;

  /// Whether to show the search icon
  final bool showSearch;

  /// Callback when search is tapped
  final VoidCallback? onSearchTap;

  /// Whether to center the title
  final bool centerTitle;

  /// Background color override
  final Color? backgroundColor;

  /// Elevation override
  final double? elevation;

  /// Variant of the app bar
  final CustomAppBarVariant variant;

  const CustomAppBar({
    super.key,
    required this.title,
    this.leading,
    this.actions,
    this.showSearch = false,
    this.onSearchTap,
    this.centerTitle = false,
    this.backgroundColor,
    this.elevation,
    this.variant = CustomAppBarVariant.standard,
  });

  /// Factory constructor for notes list screen
  factory CustomAppBar.notesList(BuildContext context) {
    return CustomAppBar(
      title: 'Notes',
      showSearch: true,
      onSearchTap: () {
        HapticFeedback.lightImpact();
        Navigator.pushNamed(context, '/search-screen');
      },
      actions: [
        IconButton(
          icon: const Icon(Icons.settings_outlined),
          onPressed: () {
            HapticFeedback.lightImpact();
            Navigator.pushNamed(context, '/settings-screen');
          },
          tooltip: 'Settings',
        ),
      ],
      variant: CustomAppBarVariant.primary,
    );
  }

  /// Factory constructor for note editor screen
  factory CustomAppBar.noteEditor(
    BuildContext context, {
    required VoidCallback onSave,
    required VoidCallback onShare,
  }) {
    return CustomAppBar(
      title: 'Edit Note',
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          HapticFeedback.lightImpact();
          Navigator.pop(context);
        },
        tooltip: 'Back',
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.share_outlined),
          onPressed: () {
            HapticFeedback.lightImpact();
            onShare();
          },
          tooltip: 'Share',
        ),
        IconButton(
          icon: const Icon(Icons.check),
          onPressed: () {
            HapticFeedback.mediumImpact();
            onSave();
          },
          tooltip: 'Save',
        ),
      ],
      variant: CustomAppBarVariant.editor,
    );
  }

  /// Factory constructor for note detail screen
  factory CustomAppBar.noteDetail(
    BuildContext context, {
    required VoidCallback onEdit,
    required VoidCallback onDelete,
  }) {
    return CustomAppBar(
      title: 'Note Details',
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          HapticFeedback.lightImpact();
          Navigator.pop(context);
        },
        tooltip: 'Back',
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.edit_outlined),
          onPressed: () {
            HapticFeedback.lightImpact();
            onEdit();
          },
          tooltip: 'Edit',
        ),
        IconButton(
          icon: const Icon(Icons.delete_outline),
          onPressed: () {
            HapticFeedback.lightImpact();
            onDelete();
          },
          tooltip: 'Delete',
        ),
      ],
      variant: CustomAppBarVariant.detail,
    );
  }

  /// Factory constructor for search screen
  factory CustomAppBar.search(
    BuildContext context, {
    required TextEditingController searchController,
    required ValueChanged<String> onSearchChanged,
  }) {
    return CustomAppBar(
      title: 'Search Notes',
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          HapticFeedback.lightImpact();
          Navigator.pop(context);
        },
        tooltip: 'Back',
      ),
      variant: CustomAppBarVariant.search,
    );
  }

  /// Factory constructor for settings screen
  factory CustomAppBar.settings(BuildContext context) {
    return CustomAppBar(
      title: 'Settings',
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          HapticFeedback.lightImpact();
          Navigator.pop(context);
        },
        tooltip: 'Back',
      ),
      variant: CustomAppBarVariant.standard,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Determine colors based on variant and theme
    final Color effectiveBackgroundColor =
        backgroundColor ??
        (isDark ? AppTheme.surfaceDark : AppTheme.surfaceLight);

    final Color effectiveForegroundColor = isDark
        ? AppTheme.primaryDark
        : AppTheme.primaryLight;

    // Build actions list with search if needed
    List<Widget> effectiveActions = [];

    if (showSearch) {
      effectiveActions.add(
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: onSearchTap,
          tooltip: 'Search',
        ),
      );
    }

    if (actions != null) {
      effectiveActions.addAll(actions!);
    }

    return AppBar(
      title: Text(
        title,
        style: GoogleFonts.inter(
          fontSize: _getTitleFontSize(),
          fontWeight: _getTitleFontWeight(),
          color: effectiveForegroundColor,
          letterSpacing: 0.15,
        ),
      ),
      leading: leading,
      actions: effectiveActions.isNotEmpty ? effectiveActions : null,
      centerTitle: centerTitle,
      backgroundColor: effectiveBackgroundColor,
      foregroundColor: effectiveForegroundColor,
      elevation: elevation ?? 0,
      scrolledUnderElevation: AppTheme.elevation2dp,
      systemOverlayStyle: isDark
          ? SystemUiOverlayStyle.light
          : SystemUiOverlayStyle.dark,
      toolbarHeight: 64,
      leadingWidth: 56,
      titleSpacing: centerTitle ? 0 : 16,
      shape: const Border(
        bottom: BorderSide(color: Colors.transparent, width: 0),
      ),
    );
  }

  /// Get title font size based on variant
  double _getTitleFontSize() {
    switch (variant) {
      case CustomAppBarVariant.primary:
        return 24;
      case CustomAppBarVariant.editor:
      case CustomAppBarVariant.detail:
        return 20;
      case CustomAppBarVariant.search:
        return 20;
      case CustomAppBarVariant.standard:
        return 20;
    }
  }

  /// Get title font weight based on variant
  FontWeight _getTitleFontWeight() {
    switch (variant) {
      case CustomAppBarVariant.primary:
        return FontWeight.w700;
      case CustomAppBarVariant.editor:
      case CustomAppBarVariant.detail:
      case CustomAppBarVariant.search:
      case CustomAppBarVariant.standard:
        return FontWeight.w600;
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(64);
}

/// Enum defining different app bar variants
enum CustomAppBarVariant {
  /// Primary app bar for main screens (Notes List)
  primary,

  /// Editor app bar for note editing
  editor,

  /// Detail app bar for note viewing
  detail,

  /// Search app bar for search screen
  search,

  /// Standard app bar for other screens
  standard,
}
