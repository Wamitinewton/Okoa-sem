import 'package:flutter/material.dart';
import 'package:okoa_sem/core/config/app_config.dart';

class OnboardingPageIndicator extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final Color activeColor;
  final Color inactiveColor;

  const OnboardingPageIndicator({
    super.key,
    required this.currentPage,
    required this.totalPages,
    this.activeColor = AppColors.primary,
    this.inactiveColor = AppColors.disabled,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        totalPages,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          margin: EdgeInsets.symmetric(horizontal: context.sizing.xs),
          width: currentPage == index ? context.sizing.size(24) : context.sizing.size(8),
          height: context.sizing.size(8),
          decoration: BoxDecoration(
            color: currentPage == index ? activeColor : inactiveColor,
            borderRadius: BorderRadius.circular(context.sizing.radiusS),
            boxShadow: currentPage == index
                ? [
                    BoxShadow(
                      color: activeColor.withValues(alpha: 0.3),
                      blurRadius: context.sizing.size(6),
                      spreadRadius: context.sizing.size(1),
                    ),
                  ]
                : null,
          ),
        ),
      ),
    );
  }
}