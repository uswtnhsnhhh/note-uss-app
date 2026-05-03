import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/app_export.dart';

/// Splash Screen - Branded app launch experience
///
/// Features:
/// - Full-screen branded display with logo animation
/// - Clean gradient background
/// - Platform-specific loading indicator
/// - Background initialization tasks
/// - Smooth transition to Notes List
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _initializeApp();
  }

  /// Setup logo scale and fade animations
  void _setupAnimations() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
      ),
    );

    _animationController.forward();
  }

  /// Initialize app services and navigate to main screen
  Future<void> _initializeApp() async {
    try {
      // Simulate initialization tasks
      await Future.wait([
        _loadCachedNotes(),
        _initializeDatabase(),
        _checkStoragePermissions(),
        _prepareWidgets(),
      ]);

      setState(() => _isInitialized = true);

      // Wait for animation to complete
      await Future.delayed(const Duration(milliseconds: 2500));

      // Navigate to Notes List screen
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/notes-list-screen');
      }
    } catch (e) {
      // Handle initialization errors gracefully
      if (mounted) {
        _showErrorDialog();
      }
    }
  }

  /// Load cached notes from local storage
  Future<void> _loadCachedNotes() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  /// Initialize local database
  Future<void> _initializeDatabase() async {
    await Future.delayed(const Duration(milliseconds: 600));
  }

  /// Check storage permissions
  Future<void> _checkStoragePermissions() async {
    await Future.delayed(const Duration(milliseconds: 400));
  }

  /// Prepare Flutter widgets
  Future<void> _prepareWidgets() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  /// Show error dialog for initialization failures
  void _showErrorDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(
          'Initialization Error',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        content: Text(
          'Failed to initialize the app. Please try again.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _initializeApp();
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Set system UI overlay style
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        systemNavigationBarColor: isDark
            ? AppTheme.backgroundDark
            : AppTheme.backgroundLight,
        systemNavigationBarIconBrightness: isDark
            ? Brightness.light
            : Brightness.dark,
      ),
    );

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [
                    AppTheme.backgroundDark,
                    AppTheme.surfaceDark,
                    AppTheme.primaryDark.withValues(alpha: 0.1),
                  ]
                : [
                    AppTheme.backgroundLight,
                    AppTheme.surfaceLight,
                    AppTheme.accentLight.withValues(alpha: 0.05),
                  ],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),

              // Animated logo section
              AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Opacity(opacity: _fadeAnimation.value, child: child),
                  );
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // App logo
                    Container(
                      width: 120.0,
                      height: 120.0,
                      decoration: BoxDecoration(
                        color: isDark
                            ? AppTheme.accentDark
                            : AppTheme.accentLight,
                        borderRadius: BorderRadius.circular(28.0),
                        boxShadow: [
                          BoxShadow(
                            color:
                                (isDark
                                        ? AppTheme.accentDark
                                        : AppTheme.accentLight)
                                    .withValues(alpha: 0.3),
                            blurRadius: 24.0,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Center(
                        child: CustomIconWidget(
                          iconName: 'note_alt',
                          color: isDark
                              ? AppTheme.backgroundDark
                              : AppTheme.surfaceLight,
                          size: 64.0,
                        ),
                      ),
                    ),

                    SizedBox(height: 24.0),

                    // App name
                    Text(
                      'Note\'uss',
                      style: theme.textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.5,
                      ),
                    ),

                    SizedBox(height: 8.0),

                    // App tagline
                    Text(
                      'Your thoughts, organized',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: isDark
                            ? AppTheme.secondaryDark
                            : AppTheme.secondaryLight,
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(flex: 2),

              // Loading indicator
              AnimatedOpacity(
                opacity: _isInitialized ? 0.0 : 1.0,
                duration: const Duration(milliseconds: 300),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 32.0,
                      height: 32.0,
                      child: CircularProgressIndicator(
                        strokeWidth: 3.0,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          isDark ? AppTheme.accentDark : AppTheme.accentLight,
                        ),
                      ),
                    ),

                    SizedBox(height: 16.0),

                    Text(
                      'Initializing...',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: isDark
                            ? AppTheme.secondaryDark
                            : AppTheme.secondaryLight,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 48.0),
            ],
          ),
        ),
      ),
    );
  }
}
