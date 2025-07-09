import 'package:flutter/material.dart';
import 'dart:math' as math;


class AppSizing {
  AppSizing._();


  static const double designWidth = 375.0;
  
  static const double designHeight = 812.0;


  static double width(BuildContext context, double designPixels) {
    final screenWidth = MediaQuery.of(context).size.width;
    return (designPixels / designWidth) * screenWidth;
  }
  
  static double height(BuildContext context, double designPixels) {
    final screenHeight = MediaQuery.of(context).size.height;
    return (designPixels / designHeight) * screenHeight;
  }
  
  static double size(BuildContext context, double designPixels) {
    final screenSize = MediaQuery.of(context).size;
    final scale = math.min(
      screenSize.width / designWidth,
      screenSize.height / designHeight,
    );
    return designPixels * scale;
  }


  static double spacingXS(BuildContext context) => size(context, 4);
  
  static double spacingS(BuildContext context) => size(context, 8);
  
  static double spacingM(BuildContext context) => size(context, 16);
  
  static double spacingL(BuildContext context) => size(context, 24);
  
  static double spacingXL(BuildContext context) => size(context, 32);
  
  static double spacingXXL(BuildContext context) => size(context, 48);
  
  static double spacingMassive(BuildContext context) => size(context, 64);

  static double radiusS(BuildContext context) => size(context, 4);
  
  static double radiusM(BuildContext context) => size(context, 8);
  
  static double radiusL(BuildContext context) => size(context, 16);
  
  static double radiusXL(BuildContext context) => size(context, 24);
  
  static double radiusRound(BuildContext context) => size(context, 1000);


  static double iconS(BuildContext context) => size(context, 16);
  
  static double iconM(BuildContext context) => size(context, 24);
  
  static double iconL(BuildContext context) => size(context, 32);
  
  static double iconXL(BuildContext context) => size(context, 48);

  static double buttonHeightS(BuildContext context) => size(context, 32);
  
  static double buttonHeightM(BuildContext context) => size(context, 48);
  
  static double buttonHeightL(BuildContext context) => size(context, 56);

  static double appBarHeight(BuildContext context) => size(context, 56);
  
  static double bottomNavHeight(BuildContext context) => size(context, 80);
  
  static double cardMinHeight(BuildContext context) => size(context, 120);
  
  static double listTileHeight(BuildContext context) => size(context, 72);

  static const double mobileBreakpoint = 576;
  
  static const double tabletBreakpoint = 768;
  
  static const double desktopBreakpoint = 992;
  
  static const double largeDesktopBreakpoint = 1200;

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < tabletBreakpoint;
  
  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= tabletBreakpoint && width < desktopBreakpoint;
  }
  
  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= desktopBreakpoint;

  static EdgeInsets safeAreaPadding(BuildContext context) =>
      MediaQuery.of(context).padding;
  
  static double bottomSafeArea(BuildContext context) =>
      MediaQuery.of(context).padding.bottom;
  
  static double topSafeArea(BuildContext context) =>
      MediaQuery.of(context).padding.top;

  static double screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;
  
  static double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;
  
  static double screenWidthPercent(BuildContext context, double percent) =>
      MediaQuery.of(context).size.width * (percent / 100);
  
  static double screenHeightPercent(BuildContext context, double percent) =>
      MediaQuery.of(context).size.height * (percent / 100);


  static EdgeInsets paddingH(BuildContext context, double designPixels) =>
      EdgeInsets.symmetric(horizontal: width(context, designPixels));
  
  static EdgeInsets paddingV(BuildContext context, double designPixels) =>
      EdgeInsets.symmetric(vertical: height(context, designPixels));
  
  static EdgeInsets paddingAll(BuildContext context, double designPixels) =>
      EdgeInsets.all(size(context, designPixels));
  
  static EdgeInsets paddingLTRB(
    BuildContext context, {
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) =>
      EdgeInsets.fromLTRB(
        width(context, left),
        height(context, top),
        width(context, right),
        height(context, bottom),
      );


  static double splashLogoSize(BuildContext context) =>
      screenWidthPercent(context, 50);
  
  static double avatarSize(BuildContext context) => size(context, 80);
  
  static double avatarSizeS(BuildContext context) => size(context, 40);
  
  static double avatarSizeL(BuildContext context) => size(context, 120);

 
  static Offset animationOffset(BuildContext context, {
    double x = 0,
    double y = 0,
  }) =>
      Offset(width(context, x), height(context, y));
}