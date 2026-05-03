import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A class that contains all theme configurations for the note-taking application.
/// Implements Contemporary Spatial Minimalism with Adaptive Neutral Foundation color scheme.
class AppTheme {
  AppTheme._();

  // Color Specifications - Adaptive Neutral Foundation
  // Light theme colors
  static const Color primaryLight = Color(
    0xFF2C3E50,
  ); // Deep slate for primary text and navigation
  static const Color secondaryLight = Color(
    0xFF34495E,
  ); // Slightly lighter slate for secondary text
  static const Color accentLight = Color(
    0xFF3498DB,
  ); // Vibrant blue for interactive elements
  static const Color surfaceLight = Color(
    0xFFFFFFFF,
  ); // Pure white for note content backgrounds
  static const Color backgroundLight = Color(
    0xFFF8F9FA,
  ); // Subtle warm gray for app backgrounds
  static const Color borderLight = Color(
    0xFFE9ECEF,
  ); // Minimal gray for dividers
  static const Color successLight = Color(
    0xFF27AE60,
  ); // Fresh green for positive actions
  static const Color warningLight = Color(
    0xFFF39C12,
  ); // Warm orange for caution states
  static const Color errorLight = Color(
    0xFFE74C3C,
  ); // Clear red for destructive actions
  static const Color disabledLight = Color(
    0xFFBDC3C7,
  ); // Muted gray for inactive elements

  // Dark theme colors - Adaptive adjustments
  static const Color primaryDark = Color(
    0xFFE9ECEF,
  ); // Light text on dark background
  static const Color secondaryDark = Color(
    0xFFBDC3C7,
  ); // Secondary text for dark mode
  static const Color accentDark = Color(
    0xFF3498DB,
  ); // Consistent accent across themes
  static const Color surfaceDark = Color(
    0xFF1E1E1E,
  ); // Dark surface for note cards
  static const Color backgroundDark = Color(
    0xFF121212,
  ); // Deep background for dark mode
  static const Color borderDark = Color(
    0xFF2C3E50,
  ); // Subtle borders in dark mode
  static const Color successDark = Color(
    0xFF27AE60,
  ); // Consistent success color
  static const Color warningDark = Color(
    0xFFF39C12,
  ); // Consistent warning color
  static const Color errorDark = Color(0xFFE74C3C); // Consistent error color
  static const Color disabledDark = Color(
    0xFF34495E,
  ); // Disabled state for dark mode

  // Card and dialog colors
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color cardDark = Color(0xFF1E1E1E);
  static const Color dialogLight = Color(0xFFFFFFFF);
  static const Color dialogDark = Color(0xFF2D2D2D);

  // Shadow colors - Elevation-based depth (2dp, 4dp, 8dp)
  static const Color shadowLight = Color(
    0x1A000000,
  ); // Subtle shadows for light mode
  static const Color shadowDark = Color(
    0x33000000,
  ); // More pronounced shadows for dark mode

  // Divider colors - Hairline borders at 40% opacity
  static Color dividerLight = borderLight.withValues(alpha: 0.4);
  static Color dividerDark = borderDark.withValues(alpha: 0.4);

  // Text colors with proper emphasis levels
  static const Color textHighEmphasisLight = Color(
    0xFF2C3E50,
  ); // 100% opacity - primary text
  static const Color textMediumEmphasisLight = Color(
    0xFF34495E,
  ); // Secondary text
  static Color textDisabledLight = disabledLight;

  static const Color textHighEmphasisDark = Color(
    0xFFE9ECEF,
  ); // High contrast for dark mode
  static const Color textMediumEmphasisDark = Color(
    0xFFBDC3C7,
  ); // Medium emphasis dark
  static Color textDisabledDark = disabledDark;

  /// Light theme - Focused Tranquility aesthetic
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: primaryLight,
      onPrimary: surfaceLight,
      primaryContainer: secondaryLight,
      onPrimaryContainer: surfaceLight,
      secondary: accentLight,
      onSecondary: surfaceLight,
      secondaryContainer: accentLight.withValues(alpha: 0.1),
      onSecondaryContainer: primaryLight,
      tertiary: accentLight,
      onTertiary: surfaceLight,
      tertiaryContainer: accentLight.withValues(alpha: 0.1),
      onTertiaryContainer: primaryLight,
      error: errorLight,
      onError: surfaceLight,
      surface: surfaceLight,
      onSurface: primaryLight,
      onSurfaceVariant: secondaryLight,
      outline: borderLight,
      outlineVariant: dividerLight,
      shadow: shadowLight,
      scrim: shadowLight,
      inverseSurface: surfaceDark,
      onInverseSurface: primaryDark,
      inversePrimary: accentLight,
    ),
    scaffoldBackgroundColor: backgroundLight,
    cardColor: cardLight,
    dividerColor: dividerLight,

    // AppBar theme - Clean minimal header
    appBarTheme: AppBarThemeData(
      backgroundColor: surfaceLight,
      foregroundColor: primaryLight,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: primaryLight,
        letterSpacing: 0.15,
      ),
      iconTheme: IconThemeData(color: primaryLight, size: 24),
    ),

    // Card theme - Minimal elevation with subtle shadows
    cardTheme: CardThemeData(
      color: cardLight,
      elevation: 2.0,
      shadowColor: shadowLight,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),

    // Bottom navigation - Touch-optimized for thumb reach
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: surfaceLight,
      selectedItemColor: accentLight,
      unselectedItemColor: secondaryLight,
      elevation: 8.0,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    ),

    // Floating action button - Bottom-right primary action
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: accentLight,
      foregroundColor: surfaceLight,
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
    ),

    // Button themes - Touch-optimized with proper spacing
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: surfaceLight,
        backgroundColor: accentLight,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: accentLight,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        side: BorderSide(color: borderLight, width: 1.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: accentLight,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        textStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    ),

    // Typography - Inter for headings, body text with proper hierarchy
    textTheme: _buildTextTheme(isLight: true),

    // Input decoration - Clean borders with focused states
    inputDecorationTheme: InputDecorationThemeData(
      fillColor: surfaceLight,
      filled: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: borderLight, width: 0.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: borderLight, width: 0.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: accentLight, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: errorLight, width: 1.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: errorLight, width: 1.5),
      ),
      labelStyle: GoogleFonts.inter(
        color: secondaryLight,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      hintStyle: GoogleFonts.inter(
        color: disabledLight,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      errorStyle: GoogleFonts.inter(
        color: errorLight,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    ),

    // Switch theme
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return accentLight;
        }
        return disabledLight;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return accentLight.withValues(alpha: 0.5);
        }
        return borderLight;
      }),
    ),

    // Checkbox theme
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return accentLight;
        }
        return Colors.transparent;
      }),
      checkColor: WidgetStateProperty.all(surfaceLight),
      side: BorderSide(color: borderLight, width: 1.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
    ),

    // Radio theme
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return accentLight;
        }
        return secondaryLight;
      }),
    ),

    // Progress indicator
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: accentLight,
      linearTrackColor: borderLight,
    ),

    // Slider theme
    sliderTheme: SliderThemeData(
      activeTrackColor: accentLight,
      thumbColor: accentLight,
      overlayColor: accentLight.withValues(alpha: 0.2),
      inactiveTrackColor: borderLight,
      trackHeight: 4.0,
    ),

    // Tab bar theme
    tabBarTheme: TabBarThemeData(
      labelColor: accentLight,
      unselectedLabelColor: secondaryLight,
      indicatorColor: accentLight,
      indicatorSize: TabBarIndicatorSize.label,
      labelStyle: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
      unselectedLabelStyle: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
      ),
    ),

    // Tooltip theme
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: primaryLight.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: GoogleFonts.inter(
        color: surfaceLight,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    ),

    // Snackbar theme
    snackBarTheme: SnackBarThemeData(
      backgroundColor: primaryLight,
      contentTextStyle: GoogleFonts.inter(
        color: surfaceLight,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      actionTextColor: accentLight,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      elevation: 4.0,
    ),

    // List tile theme
    listTileTheme: ListTileThemeData(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      iconColor: secondaryLight,
      textColor: primaryLight,
      tileColor: surfaceLight,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    ),

    // Divider theme - Hairline borders
    dividerTheme: DividerThemeData(
      color: dividerLight,
      thickness: 0.5,
      space: 1,
    ), dialogTheme: DialogThemeData(backgroundColor: dialogLight),
  );

  /// Dark theme - Focused Tranquility with dark adaptation
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: primaryDark,
      onPrimary: backgroundDark,
      primaryContainer: secondaryDark,
      onPrimaryContainer: backgroundDark,
      secondary: accentDark,
      onSecondary: backgroundDark,
      secondaryContainer: accentDark.withValues(alpha: 0.2),
      onSecondaryContainer: primaryDark,
      tertiary: accentDark,
      onTertiary: backgroundDark,
      tertiaryContainer: accentDark.withValues(alpha: 0.2),
      onTertiaryContainer: primaryDark,
      error: errorDark,
      onError: backgroundDark,
      surface: surfaceDark,
      onSurface: primaryDark,
      onSurfaceVariant: secondaryDark,
      outline: borderDark,
      outlineVariant: dividerDark,
      shadow: shadowDark,
      scrim: shadowDark,
      inverseSurface: surfaceLight,
      onInverseSurface: primaryLight,
      inversePrimary: accentDark,
    ),
    scaffoldBackgroundColor: backgroundDark,
    cardColor: cardDark,
    dividerColor: dividerDark,

    // AppBar theme
    appBarTheme: AppBarThemeData(
      backgroundColor: surfaceDark,
      foregroundColor: primaryDark,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: primaryDark,
        letterSpacing: 0.15,
      ),
      iconTheme: IconThemeData(color: primaryDark, size: 24),
    ),

    // Card theme
    cardTheme: CardThemeData(
      color: cardDark,
      elevation: 2.0,
      shadowColor: shadowDark,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),

    // Bottom navigation
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: surfaceDark,
      selectedItemColor: accentDark,
      unselectedItemColor: secondaryDark,
      elevation: 8.0,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    ),

    // Floating action button
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: accentDark,
      foregroundColor: backgroundDark,
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
    ),

    // Button themes
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: backgroundDark,
        backgroundColor: accentDark,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: accentDark,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        side: BorderSide(color: borderDark, width: 1.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: accentDark,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        textStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    ),

    // Typography
    textTheme: _buildTextTheme(isLight: false),

    // Input decoration
    inputDecorationTheme: InputDecorationThemeData(
      fillColor: surfaceDark,
      filled: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: borderDark, width: 0.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: borderDark, width: 0.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: accentDark, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: errorDark, width: 1.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: errorDark, width: 1.5),
      ),
      labelStyle: GoogleFonts.inter(
        color: secondaryDark,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      hintStyle: GoogleFonts.inter(
        color: disabledDark,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      errorStyle: GoogleFonts.inter(
        color: errorDark,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    ),

    // Switch theme
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return accentDark;
        }
        return disabledDark;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return accentDark.withValues(alpha: 0.5);
        }
        return borderDark;
      }),
    ),

    // Checkbox theme
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return accentDark;
        }
        return Colors.transparent;
      }),
      checkColor: WidgetStateProperty.all(backgroundDark),
      side: BorderSide(color: borderDark, width: 1.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
    ),

    // Radio theme
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return accentDark;
        }
        return secondaryDark;
      }),
    ),

    // Progress indicator
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: accentDark,
      linearTrackColor: borderDark,
    ),

    // Slider theme
    sliderTheme: SliderThemeData(
      activeTrackColor: accentDark,
      thumbColor: accentDark,
      overlayColor: accentDark.withValues(alpha: 0.2),
      inactiveTrackColor: borderDark,
      trackHeight: 4.0,
    ),

    // Tab bar theme
    tabBarTheme: TabBarThemeData(
      labelColor: accentDark,
      unselectedLabelColor: secondaryDark,
      indicatorColor: accentDark,
      indicatorSize: TabBarIndicatorSize.label,
      labelStyle: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
      unselectedLabelStyle: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
      ),
    ),

    // Tooltip theme
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: primaryDark.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: GoogleFonts.inter(
        color: backgroundDark,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    ),

    // Snackbar theme
    snackBarTheme: SnackBarThemeData(
      backgroundColor: surfaceDark,
      contentTextStyle: GoogleFonts.inter(
        color: primaryDark,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      actionTextColor: accentDark,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      elevation: 4.0,
    ),

    // List tile theme
    listTileTheme: ListTileThemeData(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      iconColor: secondaryDark,
      textColor: primaryDark,
      tileColor: surfaceDark,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    ),

    // Divider theme
    dividerTheme: DividerThemeData(
      color: dividerDark,
      thickness: 0.5,
      space: 1,
    ), dialogTheme: DialogThemeData(backgroundColor: dialogDark),
  );

  /// Helper method to build text theme based on brightness
  /// Typography: Inter for headings (w400, w600, w700), body text (w300, w400, w600)
  /// Roboto for captions (w400, w500), SF Mono for data (w400, w500)
  static TextTheme _buildTextTheme({required bool isLight}) {
    final Color textHighEmphasis = isLight
        ? textHighEmphasisLight
        : textHighEmphasisDark;
    final Color textMediumEmphasis = isLight
        ? textMediumEmphasisLight
        : textMediumEmphasisDark;
    final Color textDisabled = isLight ? textDisabledLight : textDisabledDark;

    return TextTheme(
      // Display styles - Inter for large headings
      displayLarge: GoogleFonts.inter(
        fontSize: 57,
        fontWeight: FontWeight.w400,
        color: textHighEmphasis,
        letterSpacing: -0.25,
        height: 1.12,
      ),
      displayMedium: GoogleFonts.inter(
        fontSize: 45,
        fontWeight: FontWeight.w400,
        color: textHighEmphasis,
        letterSpacing: 0,
        height: 1.16,
      ),
      displaySmall: GoogleFonts.inter(
        fontSize: 36,
        fontWeight: FontWeight.w400,
        color: textHighEmphasis,
        letterSpacing: 0,
        height: 1.22,
      ),

      // Headline styles - Inter for note titles and section headers
      headlineLarge: GoogleFonts.inter(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        color: textHighEmphasis,
        letterSpacing: 0,
        height: 1.25,
      ),
      headlineMedium: GoogleFonts.inter(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: textHighEmphasis,
        letterSpacing: 0,
        height: 1.29,
      ),
      headlineSmall: GoogleFonts.inter(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: textHighEmphasis,
        letterSpacing: 0,
        height: 1.33,
      ),

      // Title styles - Inter for list items and card titles
      titleLarge: GoogleFonts.inter(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: textHighEmphasis,
        letterSpacing: 0,
        height: 1.27,
      ),
      titleMedium: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: textHighEmphasis,
        letterSpacing: 0.15,
        height: 1.50,
      ),
      titleSmall: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: textHighEmphasis,
        letterSpacing: 0.1,
        height: 1.43,
      ),

      // Body styles - Inter for note content and reading
      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: textHighEmphasis,
        letterSpacing: 0.5,
        height: 1.50,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: textHighEmphasis,
        letterSpacing: 0.25,
        height: 1.43,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w300,
        color: textMediumEmphasis,
        letterSpacing: 0.4,
        height: 1.33,
      ),

      // Label styles - Roboto for timestamps and metadata
      labelLarge: GoogleFonts.roboto(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: textMediumEmphasis,
        letterSpacing: 0.1,
        height: 1.43,
      ),
      labelMedium: GoogleFonts.roboto(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: textMediumEmphasis,
        letterSpacing: 0.5,
        height: 1.33,
      ),
      labelSmall: GoogleFonts.roboto(
        fontSize: 11,
        fontWeight: FontWeight.w400,
        color: textDisabled,
        letterSpacing: 0.5,
        height: 1.45,
      ),
    );
  }

  /// Animation duration constants - 200-300ms with easeInOut
  static const Duration shortAnimationDuration = Duration(milliseconds: 200);
  static const Duration mediumAnimationDuration = Duration(milliseconds: 250);
  static const Duration longAnimationDuration = Duration(milliseconds: 300);
  static const Curve defaultAnimationCurve = Curves.easeInOut;

  /// Elevation values for shadows (2dp, 4dp, 8dp)
  static const double elevation2dp = 2.0;
  static const double elevation4dp = 4.0;
  static const double elevation8dp = 8.0;

  /// Border radius values
  static const double borderRadiusSmall = 8.0;
  static const double borderRadiusMedium = 12.0;
  static const double borderRadiusLarge = 16.0;

  /// Spacing values
  static const double spacingXSmall = 4.0;
  static const double spacingSmall = 8.0;
  static const double spacingMedium = 16.0;
  static const double spacingLarge = 24.0;
  static const double spacingXLarge = 32.0;
}
