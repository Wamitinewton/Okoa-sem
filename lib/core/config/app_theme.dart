import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_sizing.dart';
import 'app_typography.dart';

class AppTheme {
  AppTheme._();

  static ThemeData theme(BuildContext context) {
    final colorScheme = _colorScheme;
    
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      textTheme: AppTypography.textTheme(context),
      scaffoldBackgroundColor: AppColors.surfaceDark,
      disabledColor: AppColors.disabled,
      
      dividerTheme: DividerThemeData(
        color: AppColors.divider,
        space: AppSizing.size(context, 1),
        thickness: AppSizing.size(context, 1),
      ),
      
      chipTheme: ChipThemeData(
        labelStyle: AppTypography.labelSmallStyle(context),
        side: BorderSide.none,
        padding: AppSizing.paddingH(context, 12),
      ),
      
      cardTheme: CardThemeData(
        clipBehavior: Clip.antiAlias,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizing.radiusM(context)),
          side: BorderSide(
            width: AppSizing.size(context, 1),
            color: AppColors.divider,
          ),
        ),
        color: AppColors.surfaceVariant,
        surfaceTintColor: Colors.transparent,
        margin: EdgeInsets.zero,
      ),
      
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColors.onSurface,
        selectionColor: AppColors.surfaceAlpha(0.2),
        selectionHandleColor: AppColors.onSurface,
      ),
      
      popupMenuTheme: PopupMenuThemeData(
        color: AppColors.surfaceVariant,
        surfaceTintColor: AppColors.surfaceDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizing.radiusM(context)),
        ),
      ),
      
      bottomSheetTheme: BottomSheetThemeData(
        showDragHandle: false,
        backgroundColor: AppColors.surfaceVariant,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppSizing.radiusL(context)),
          ),
        ),
      ),
      
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
      ),
      
      navigationRailTheme: const NavigationRailThemeData(
        labelType: NavigationRailLabelType.all,
        groupAlignment: 0,
      ),
      
      appBarTheme: AppBarTheme(
        titleTextStyle: AppTypography.titleLargeStyle(context),
        backgroundColor: AppColors.surfaceVariant,
        elevation: 0,
        centerTitle: true,
        toolbarHeight: AppSizing.appBarHeight(context),
      ),
      
      // Dialog theme
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.surfaceDark,
        surfaceTintColor: AppColors.surfaceDark,
        titleTextStyle: AppTypography.titleLargeStyle(context),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizing.radiusL(context)),
        ),
      ),
      
      // Snack bar theme
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.onSurface,
        contentTextStyle: AppTypography.bodyMediumStyle(context)
            .copyWith(color: AppColors.onPrimary),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizing.radiusM(context)),
        ),
      ),
      
      // List tile theme
      listTileTheme: ListTileThemeData(
        iconColor: AppColors.primary,
        minVerticalPadding: AppSizing.spacingS(context),
        contentPadding: AppSizing.paddingH(context, 16),
      ),
      
      // Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceVariant,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppSizing.spacingL(context),
          vertical: AppSizing.spacingM(context),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizing.radiusM(context)),
          borderSide: BorderSide.none,
        ),
        hintStyle: AppTypography.bodyLargeStyle(context)
            .copyWith(color: AppColors.surfaceAlpha(0.6)),
        labelStyle: AppTypography.bodyLargeStyle(context)
            .copyWith(color: AppColors.surfaceAlpha(0.7)),
      ),
      
      // Floating action button theme
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.secondary,
        foregroundColor: AppColors.onPrimary,
        iconSize: AppSizing.iconL(context),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizing.radiusRound(context)),
        ),
      ),
      
      // Elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizing.radiusL(context)),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: AppSizing.spacingL(context),
            vertical: AppSizing.spacingM(context),
          ),
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
          textStyle: AppTypography.buttonStyle(context),
          elevation: 2,
          minimumSize: Size(
            AppSizing.width(context, 88),
            AppSizing.buttonHeightM(context),
          ),
        ),
      ),
      
      // Outlined button theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizing.radiusL(context)),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: AppSizing.spacingL(context),
            vertical: AppSizing.spacingM(context),
          ),
          side: BorderSide(
            color: AppColors.primary,
            width: AppSizing.size(context, 1),
          ),
          foregroundColor: AppColors.primary,
          textStyle: AppTypography.buttonStyle(context),
          elevation: 0,
          minimumSize: Size(
            AppSizing.width(context, 88),
            AppSizing.buttonHeightM(context),
          ),
        ),
      ),
      
      // Text button theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizing.radiusL(context)),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: AppSizing.spacingL(context),
            vertical: AppSizing.spacingM(context),
          ),
          foregroundColor: AppColors.onSurface,
          textStyle: AppTypography.buttonStyle(context),
          minimumSize: Size(
            AppSizing.width(context, 88),
            AppSizing.buttonHeightM(context),
          ),
        ),
      ),
      
      // Icon button theme
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          iconSize: AppSizing.iconM(context),
          padding: EdgeInsets.all(AppSizing.spacingS(context)),
          minimumSize: Size(
            AppSizing.iconL(context) + AppSizing.spacingM(context),
            AppSizing.iconL(context) + AppSizing.spacingM(context),
          ),
        ),
      ),
      
      // Progress indicator theme
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: AppColors.primary,
        linearTrackColor: AppColors.primaryAlpha(0.2),
        circularTrackColor: AppColors.primaryAlpha(0.2),
      ),
      
      // Switch theme
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary;
          }
          return AppColors.disabled;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryAlpha(0.5);
          }
          return AppColors.surfaceAlpha(0.3);
        }),
      ),
      
      // Checkbox theme
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary;
          }
          return AppColors.surfaceAlpha(0.3);
        }),
        checkColor: WidgetStateProperty.all(AppColors.onPrimary),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizing.radiusS(context)),
        ),
      ),
      
      // Radio theme
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary;
          }
          return AppColors.disabled;
        }),
      ),
    );
  }

  static ColorScheme get _colorScheme => const ColorScheme(
        brightness: Brightness.dark,
        primary: AppColors.primary,
        onPrimary: AppColors.onPrimary,
        primaryContainer: AppColors.primary,
        onPrimaryContainer: AppColors.onPrimary,
        
        // Secondary colors
        secondary: AppColors.secondary,
        onSecondary: AppColors.onPrimarySurface,
        secondaryContainer: AppColors.secondary,
        onSecondaryContainer: AppColors.onPrimarySurface,
        
        // Tertiary colors
        tertiary: AppColors.tertiary,
        onTertiary: AppColors.onPrimarySurface,
        tertiaryContainer: AppColors.tertiary,
        onTertiaryContainer: AppColors.onPrimarySurface,
        
        // Error colors
        error: AppColors.error,
        onError: AppColors.onPrimarySurface,
        errorContainer: AppColors.error,
        onErrorContainer: AppColors.onPrimarySurface,
        
        // Surface colors
        surface: AppColors.surfaceDark,
        onSurface: AppColors.onSurface,
        surfaceContainerHighest: AppColors.surfaceVariant,
        
        // Outline colors
        outline: AppColors.divider,
        outlineVariant: AppColors.border,
        
        // Other colors
        shadow: Colors.black,
        scrim: Colors.black,
        inverseSurface: AppColors.onSurface,
        onInverseSurface: AppColors.surfaceDark,
        inversePrimary: AppColors.primary,
      );


  static ThemeData responsiveTheme(BuildContext context) {
    final baseTheme = theme(context);
    
    if (AppSizing.isMobile(context)) {
      return baseTheme;
    } else if (AppSizing.isTablet(context)) {
      return _tabletTheme(context, baseTheme);
    } else {
      return _desktopTheme(context, baseTheme);
    }
  }
  
  static ThemeData _tabletTheme(BuildContext context, ThemeData baseTheme) {
    return baseTheme.copyWith(
      appBarTheme: baseTheme.appBarTheme.copyWith(
        toolbarHeight: AppSizing.size(context, 64),
      ),
      
      cardTheme: baseTheme.cardTheme.copyWith(
        margin: EdgeInsets.all(AppSizing.spacingM(context)),
      ),
    );
  }
  
  static ThemeData _desktopTheme(BuildContext context, ThemeData baseTheme) {
    return baseTheme.copyWith(
      appBarTheme: baseTheme.appBarTheme.copyWith(
        toolbarHeight: AppSizing.size(context, 72),
      ),
      
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: baseTheme.elevatedButtonTheme.style?.copyWith(
          minimumSize: WidgetStateProperty.all(
            Size(
              AppSizing.width(context, 120),
              AppSizing.buttonHeightL(context),
            ),
          ),
        ),
      ),
    );
  }
}