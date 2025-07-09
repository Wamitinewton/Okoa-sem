import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_sizing.dart';
import 'app_typography.dart';

extension ColorExtensions on Color {
  Color alpha(double alpha) => withValues(alpha: alpha);
  
  Color get semi => withValues(alpha: 0.5);
  
  Color get light => withValues(alpha: 0.2);
  
  Color get lighter => withValues(alpha: 0.1);
}

extension BuildContextExtensions on BuildContext {
  AppSizingHelper get sizing => AppSizingHelper(this);
  
  AppTypographyHelper get typography => AppTypographyHelper(this);
  
  AppColorsHelper get colors => AppColorsHelper(this);
  
  bool get isMobile => AppSizing.isMobile(this);
  
  bool get isTablet => AppSizing.isTablet(this);
  
  bool get isDesktop => AppSizing.isDesktop(this);
  
  double get screenWidth => AppSizing.screenWidth(this);
  
  double get screenHeight => AppSizing.screenHeight(this);
}

class AppSizingHelper {
  final BuildContext context;
  AppSizingHelper(this.context);
  
  double get xs => AppSizing.spacingXS(context);
  double get s => AppSizing.spacingS(context);
  double get m => AppSizing.spacingM(context);
  double get l => AppSizing.spacingL(context);
  double get xl => AppSizing.spacingXL(context);
  double get xxl => AppSizing.spacingXXL(context);
  double get massive => AppSizing.spacingMassive(context);
  
  double get iconS => AppSizing.iconS(context);
  double get iconM => AppSizing.iconM(context);
  double get iconL => AppSizing.iconL(context);
  double get iconXL => AppSizing.iconXL(context);
  
  double get buttonS => AppSizing.buttonHeightS(context);
  double get buttonM => AppSizing.buttonHeightM(context);
  double get buttonL => AppSizing.buttonHeightL(context);
  
  double get radiusS => AppSizing.radiusS(context);
  double get radiusM => AppSizing.radiusM(context);
  double get radiusL => AppSizing.radiusL(context);
  double get radiusXL => AppSizing.radiusXL(context);
  double get radiusRound => AppSizing.radiusRound(context);
  
  EdgeInsets paddingH(double pixels) => AppSizing.paddingH(context, pixels);
  EdgeInsets paddingV(double pixels) => AppSizing.paddingV(context, pixels);
  EdgeInsets paddingAll(double pixels) => AppSizing.paddingAll(context, pixels);
  
  double width(double pixels) => AppSizing.width(context, pixels);
  double height(double pixels) => AppSizing.height(context, pixels);
  double size(double pixels) => AppSizing.size(context, pixels);
  
  double widthPercent(double percent) => AppSizing.screenWidthPercent(context, percent);
  double heightPercent(double percent) => AppSizing.screenHeightPercent(context, percent);
}

class AppTypographyHelper {
  final BuildContext context;
  AppTypographyHelper(this.context);
  
  TextStyle get displayL => AppTypography.displayLargeStyle(context);
  TextStyle get displayM => AppTypography.displayMediumStyle(context);
  TextStyle get displayS => AppTypography.displaySmallStyle(context);
  
  // Headline styles
  TextStyle get headlineL => AppTypography.headlineLargeStyle(context);
  TextStyle get headlineM => AppTypography.headlineMediumStyle(context);
  TextStyle get headlineS => AppTypography.headlineSmallStyle(context);
  
  // Title styles
  TextStyle get titleL => AppTypography.titleLargeStyle(context);
  TextStyle get titleM => AppTypography.titleMediumStyle(context);
  TextStyle get titleS => AppTypography.titleSmallStyle(context);
  
  // Body styles
  TextStyle get bodyL => AppTypography.bodyLargeStyle(context);
  TextStyle get bodyM => AppTypography.bodyMediumStyle(context);
  TextStyle get bodyS => AppTypography.bodySmallStyle(context);
  
  // Label styles
  TextStyle get labelL => AppTypography.labelLargeStyle(context);
  TextStyle get labelM => AppTypography.labelMediumStyle(context);
  TextStyle get labelS => AppTypography.labelSmallStyle(context);
  
  // Semantic styles
  TextStyle get appTitle => AppTypography.appTitleStyle(context);
  TextStyle get subtitle => AppTypography.subtitleStyle(context);
  TextStyle get button => AppTypography.buttonStyle(context);
  TextStyle get caption => AppTypography.captionStyle(context);
  TextStyle get error => AppTypography.errorStyle(context);
  
  Widget gradientText(
    String text, {
    required TextStyle style,
    List<Color> colors = AppColors.primaryGradient,
  }) => AppTypography.gradientText(text, context, style: style, colors: colors);
}

class AppColorsHelper {
  final BuildContext context;
  AppColorsHelper(this.context);
  
  Color get primary => AppColors.primary;
  Color get secondary => AppColors.secondary;
  Color get tertiary => AppColors.tertiary;
  
  Color get surface => AppColors.surfaceDark;
  Color get surfaceVariant => AppColors.surfaceVariant;
  Color get onSurface => AppColors.onSurface;
  Color get onPrimary => AppColors.onPrimary;
  
  // Semantic colors
  Color get error => AppColors.error;
  Color get success => AppColors.success;
  Color get warning => AppColors.warning;
  Color get info => AppColors.info;
  
  // Interaction colors
  Color get disabled => AppColors.disabled;
  Color get divider => AppColors.divider;
  Color get border => AppColors.border;
  
  // Overlay colors
  Color get overlay => AppColors.overlay;
  Color get overlayLight => AppColors.overlayLight;
  Color get scrim => AppColors.scrim;
  
  Color primaryAlpha(double alpha) => AppColors.primaryAlpha(alpha);
  Color secondaryAlpha(double alpha) => AppColors.secondaryAlpha(alpha);
  Color surfaceAlpha(double alpha) => AppColors.surfaceAlpha(alpha);
  
  ColorScheme get scheme => AppColors.of(context);
  bool get isDark => AppColors.isDark(context);
}

extension WidgetExtensions on Widget {
  Widget paddingAll(BuildContext context, double pixels) => Padding(
        padding: AppSizing.paddingAll(context, pixels),
        child: this,
      );
  
  Widget paddingH(BuildContext context, double pixels) => Padding(
        padding: AppSizing.paddingH(context, pixels),
        child: this,
      );
  
  Widget paddingV(BuildContext context, double pixels) => Padding(
        padding: AppSizing.paddingV(context, pixels),
        child: this,
      );
  
  Widget paddingLTRB(
    BuildContext context, {
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) => Padding(
        padding: AppSizing.paddingLTRB(
          context,
          left: left,
          top: top,
          right: right,
          bottom: bottom,
        ),
        child: this,
      );
  
  Widget spacingH(BuildContext context, double pixels) => Row(
        children: [
          this,
          SizedBox(width: AppSizing.width(context, pixels)),
        ],
      );
  
  Widget spacingV(BuildContext context, double pixels) => Column(
        children: [
          this,
          SizedBox(height: AppSizing.height(context, pixels)),
        ],
      );
}

extension SizedBoxExtensions on SizedBox {
  static SizedBox widthR(BuildContext context, double pixels) => SizedBox(
        width: AppSizing.width(context, pixels),
      );
  
  static SizedBox heightR(BuildContext context, double pixels) => SizedBox(
        height: AppSizing.height(context, pixels),
      );
  
  static SizedBox squareR(BuildContext context, double pixels) => SizedBox(
        width: AppSizing.size(context, pixels),
        height: AppSizing.size(context, pixels),
      );
}