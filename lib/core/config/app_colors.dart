import 'package:flutter/material.dart';


class AppColors {
  AppColors._();

  static const Color primary = Color(0xFFC5F432);
  
  /// Secondary brand color - Purple
  static const Color secondary = Color(0xFFC09FF8);
  
  /// Tertiary brand color - Pink
  static const Color tertiary = Color(0xFFFEC4DD);

  /// Pure black background
  static const Color surfaceDark = Color(0xFF010201);
  
  /// Dark background variant
  static const Color surfaceVariant = Color(0xFF171717);
  
  /// Lightest color for text and icons
  static const Color onSurface = Color(0xFFF9FAFB);
  
  /// Pure black for high contrast elements
  static const Color onPrimary = Colors.black;
  
  /// White for primary surface text
  static const Color onPrimarySurface = Colors.white;

  /// Error/danger color
  static const Color error = Colors.red;
  
  /// Success color
  static const Color success = Color(0xFF10B981);
  
  /// Warning color
  static const Color warning = Color(0xFFF59E0B);
  
  /// Info color
  static const Color info = Color(0xFF3B82F6);

  /// Disabled state color
  static const Color disabled = Colors.grey;
  
  /// Divider color
  static const Color divider = Color(0xFF363635);
  
  /// Border color
  static const Color border = Color(0xFF404040);

  /// Semi-transparent overlay
  static Color overlay = Colors.black.withValues(alpha: 0.5);
  
  /// Light overlay for modals
  static Color overlayLight = Colors.white.withValues(alpha: 0.1);
  
  /// Scrim color for bottom sheets
  static Color scrim = Colors.black.withValues(alpha: 0.3);

  /// Primary gradient colors
  static const List<Color> primaryGradient = [primary, secondary];
  
  /// Background gradient colors
  static const List<Color> backgroundGradient = [
    surfaceDark,
    surfaceVariant,
    surfaceDark,
  ];
  
  /// Accent gradient colors
  static const List<Color> accentGradient = [secondary, tertiary];

  /// Primary color with opacity variants
  static Color primaryAlpha(double alpha) => primary.withValues(alpha: alpha);
  
  /// Secondary color with opacity variants
  static Color secondaryAlpha(double alpha) => secondary.withValues(alpha: alpha);
  
  /// Surface color with opacity variants
  static Color surfaceAlpha(double alpha) => onSurface.withValues(alpha: alpha);

  /// Get colors from current theme context
  static ColorScheme of(BuildContext context) => Theme.of(context).colorScheme;
  
  /// Check if current theme is dark
  static bool isDark(BuildContext context) => 
      Theme.of(context).brightness == Brightness.dark;
}