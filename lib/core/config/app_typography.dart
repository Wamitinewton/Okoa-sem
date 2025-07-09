import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';
import 'app_sizing.dart';

class AppTypography {
  AppTypography._();

  static String get fontFamily => GoogleFonts.rubik().fontFamily!;

  
  static double displayLarge(BuildContext context) => AppSizing.size(context, 57);
  static double displayMedium(BuildContext context) => AppSizing.size(context, 45);
  static double displaySmall(BuildContext context) => AppSizing.size(context, 36);

  static double headlineLarge(BuildContext context) => AppSizing.size(context, 32);
  static double headlineMedium(BuildContext context) => AppSizing.size(context, 28);
  static double headlineSmall(BuildContext context) => AppSizing.size(context, 24);

  static double titleLarge(BuildContext context) => AppSizing.size(context, 22);
  static double titleMedium(BuildContext context) => AppSizing.size(context, 16);
  static double titleSmall(BuildContext context) => AppSizing.size(context, 14);

  static double bodyLarge(BuildContext context) => AppSizing.size(context, 16);
  static double bodyMedium(BuildContext context) => AppSizing.size(context, 14);
  static double bodySmall(BuildContext context) => AppSizing.size(context, 12);

  static double labelLarge(BuildContext context) => AppSizing.size(context, 14);
  static double labelMedium(BuildContext context) => AppSizing.size(context, 12);
  static double labelSmall(BuildContext context) => AppSizing.size(context, 11);

  
  static TextStyle displayLargeStyle(BuildContext context) => GoogleFonts.rubik(
        fontSize: displayLarge(context),
        fontWeight: FontWeight.w900,
        color: AppColors.onSurface,
        height: 1.12,
        letterSpacing: -0.25,
      );

  static TextStyle displayMediumStyle(BuildContext context) => GoogleFonts.rubik(
        fontSize: displayMedium(context),
        fontWeight: FontWeight.w900,
        color: AppColors.onSurface,
        height: 1.16,
        letterSpacing: 0,
      );

  static TextStyle displaySmallStyle(BuildContext context) => GoogleFonts.rubik(
        fontSize: displaySmall(context),
        fontWeight: FontWeight.w900,
        color: AppColors.onSurface,
        height: 1.22,
        letterSpacing: 0,
      );

  static TextStyle headlineLargeStyle(BuildContext context) => GoogleFonts.rubik(
        fontSize: headlineLarge(context),
        fontWeight: FontWeight.w900,
        color: AppColors.onSurface,
        height: 1.25,
        letterSpacing: 2.5,
      );

  static TextStyle headlineMediumStyle(BuildContext context) => GoogleFonts.rubik(
        fontSize: headlineMedium(context),
        fontWeight: FontWeight.w900,
        color: AppColors.onSurface,
        height: 1.29,
        letterSpacing: 2.0,
      );

  static TextStyle headlineSmallStyle(BuildContext context) => GoogleFonts.rubik(
        fontSize: headlineSmall(context),
        fontWeight: FontWeight.w900,
        color: AppColors.onSurface,
        height: 1.33,
        letterSpacing: 1.5,
      );

  static TextStyle titleLargeStyle(BuildContext context) => GoogleFonts.rubik(
        fontSize: titleLarge(context),
        fontWeight: FontWeight.bold,
        color: AppColors.onSurface,
        height: 1.27,
        letterSpacing: 0,
      );

  static TextStyle titleMediumStyle(BuildContext context) => GoogleFonts.rubik(
        fontSize: titleMedium(context),
        fontWeight: FontWeight.bold,
        color: AppColors.onSurface,
        height: 1.5,
        letterSpacing: 0.15,
      );

  static TextStyle titleSmallStyle(BuildContext context) => GoogleFonts.rubik(
        fontSize: titleSmall(context),
        fontWeight: FontWeight.w600,
        color: AppColors.onSurface,
        height: 1.43,
        letterSpacing: 0.1,
      );

  static TextStyle bodyLargeStyle(BuildContext context) => GoogleFonts.rubik(
        fontSize: bodyLarge(context),
        fontWeight: FontWeight.normal,
        color: AppColors.onSurface,
        height: 1.5,
        letterSpacing: 0.5,
      );

  static TextStyle bodyMediumStyle(BuildContext context) => GoogleFonts.rubik(
        fontSize: bodyMedium(context),
        fontWeight: FontWeight.normal,
        color: AppColors.onSurface,
        height: 1.43,
        letterSpacing: 0.25,
      );

  static TextStyle bodySmallStyle(BuildContext context) => GoogleFonts.rubik(
        fontSize: bodySmall(context),
        fontWeight: FontWeight.normal,
        color: AppColors.onSurface,
        height: 1.33,
        letterSpacing: 0.4,
      );

  static TextStyle labelLargeStyle(BuildContext context) => GoogleFonts.rubik(
        fontSize: labelLarge(context),
        fontWeight: FontWeight.w600,
        color: AppColors.onSurface,
        height: 1.43,
        letterSpacing: 0.1,
      );

  static TextStyle labelMediumStyle(BuildContext context) => GoogleFonts.rubik(
        fontSize: labelMedium(context),
        fontWeight: FontWeight.w600,
        color: AppColors.onSurface,
        height: 1.33,
        letterSpacing: 0.5,
      );

  static TextStyle labelSmallStyle(BuildContext context) => GoogleFonts.rubik(
        fontSize: labelSmall(context),
        fontWeight: FontWeight.w600,
        color: AppColors.onSurface,
        height: 1.45,
        letterSpacing: 0.5,
      );

  
  static TextStyle appTitleStyle(BuildContext context) => GoogleFonts.rubik(
        fontSize: AppSizing.size(context, 42),
        fontWeight: FontWeight.w900,
        color: AppColors.onSurface,
        height: 1.2,
        letterSpacing: 1.5,
      );

  static TextStyle subtitleStyle(BuildContext context) => GoogleFonts.rubik(
        fontSize: titleMedium(context),
        fontWeight: FontWeight.w500,
        color: AppColors.surfaceAlpha(0.7),
        height: 1.4,
        letterSpacing: 0.15,
      );

  static TextStyle buttonStyle(BuildContext context) => GoogleFonts.rubik(
        fontSize: labelLarge(context),
        fontWeight: FontWeight.w600,
        color: AppColors.onPrimary,
        height: 1.43,
        letterSpacing: 0.1,
      );

  static TextStyle captionStyle(BuildContext context) => GoogleFonts.rubik(
        fontSize: bodySmall(context),
        fontWeight: FontWeight.normal,
        color: AppColors.surfaceAlpha(0.6),
        height: 1.33,
        letterSpacing: 0.4,
      );

  static TextStyle errorStyle(BuildContext context) => GoogleFonts.rubik(
        fontSize: bodySmall(context),
        fontWeight: FontWeight.w500,
        color: AppColors.error,
        height: 1.33,
        letterSpacing: 0.4,
      );


  static Widget gradientText(
    String text,
    BuildContext context, {
    required TextStyle style,
    List<Color> colors = AppColors.primaryGradient,
    AlignmentGeometry begin = Alignment.topLeft,
    AlignmentGeometry end = Alignment.bottomRight,
  }) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        colors: colors,
        begin: begin,
        end: end,
      ).createShader(bounds),
      child: Text(
        text,
        style: style.copyWith(color: Colors.white),
      ),
    );
  }


  static TextTheme textTheme(BuildContext context) => TextTheme(
        displayLarge: displayLargeStyle(context),
        displayMedium: displayMediumStyle(context),
        displaySmall: displaySmallStyle(context),
        headlineLarge: headlineLargeStyle(context),
        headlineMedium: headlineMediumStyle(context),
        headlineSmall: headlineSmallStyle(context),
        titleLarge: titleLargeStyle(context),
        titleMedium: titleMediumStyle(context),
        titleSmall: titleSmallStyle(context),
        bodyLarge: bodyLargeStyle(context),
        bodyMedium: bodyMediumStyle(context),
        bodySmall: bodySmallStyle(context),
        labelLarge: labelLargeStyle(context),
        labelMedium: labelMediumStyle(context),
        labelSmall: labelSmallStyle(context),
      );

  static TextStyle withOpacity(TextStyle style, double alpha) =>
      style.copyWith(color: style.color?.withValues(alpha: alpha));

  static TextStyle withColor(TextStyle style, Color color) =>
      style.copyWith(color: color);

  static TextStyle withWeight(TextStyle style, FontWeight weight) =>
      style.copyWith(fontWeight: weight);
}