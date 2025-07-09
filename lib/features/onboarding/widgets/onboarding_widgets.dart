import 'package:flutter/material.dart';
import 'package:okoa_sem/core/config/app_config.dart';
import 'package:okoa_sem/features/onboarding/models/onboarding_data.dart';
import 'package:okoa_sem/shared/painters/background_painter.dart';

class OnboardingAnimatedIcon extends StatelessWidget {
  final IconData icon;
  final List<Color> gradientColors;
  final Animation<double> animation;
  final double size;

  const OnboardingAnimatedIcon({
    super.key,
    required this.icon,
    required this.gradientColors,
    required this.animation,
    this.size = 120,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final animationValue = animation.value.clamp(0.0, 1.0);
        
        return Transform.scale(
          scale: 0.8 + (animationValue * 0.2),
          child: Container(
            width: context.sizing.size(size),
            height: context.sizing.size(size),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: gradientColors,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(context.sizing.radiusXL),
              boxShadow: [
                BoxShadow(
                  color: gradientColors.first.withValues(alpha: 0.3 * animationValue),
                  blurRadius: context.sizing.size(20),
                  spreadRadius: context.sizing.size(5),
                  offset: Offset(0, context.sizing.size(10)),
                ),
              ],
            ),
            child: Icon(
              icon,
              size: context.sizing.size(60),
              color: AppColors.onPrimary,
            ),
          ),
        );
      },
    );
  }
}


class OnboardingFeatureList extends StatelessWidget {
  final List<OnboardingFeature> features;
  final Animation<double> animation;

  const OnboardingFeatureList({
    super.key,
    required this.features,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: features
          .asMap()
          .entries
          .map((entry) => _buildFeatureItem(context, entry.value, entry.key))
          .toList(),
    );
  }

  Widget _buildFeatureItem(BuildContext context, OnboardingFeature feature, int index) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final itemAnimation = Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: animation,
            curve: Interval(
              0.3 + (index * 0.1),
              0.8 + (index * 0.1),
              curve: Curves.easeOutBack,
            ),
          ),
        );
        final animationValue = itemAnimation.value.clamp(0.0, 1.0);

        return Transform.translate(
          offset: Offset(
            (1 - animationValue) * 50,
            0,
          ),
          child: Opacity(
            opacity: animationValue,
            child: Container(
              margin: EdgeInsets.only(bottom: context.sizing.m),
              padding: EdgeInsets.symmetric(
                horizontal: context.sizing.l,
                vertical: context.sizing.m,
              ),
              decoration: BoxDecoration(
                color: context.colors.surfaceVariant,
                borderRadius: BorderRadius.circular(context.sizing.radiusL),
                border: Border.all(
                  color: feature.color.withValues(alpha: 0.3),
                  width: context.sizing.size(1),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(context.sizing.s),
                    decoration: BoxDecoration(
                      color: feature.color.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(context.sizing.radiusM),
                    ),
                    child: Icon(
                      feature.icon,
                      color: feature.color,
                      size: context.sizing.iconM,
                    ),
                  ),
                  SizedBox(width: context.sizing.m),
                  Expanded(
                    child: Text(
                      feature.text,
                      style: context.typography.bodyM.copyWith(
                        fontWeight: FontWeight.w500,
                        color: context.colors.onSurface,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}


class OnboardingAnimatedTitle extends StatelessWidget {
  final String title;
  final String subtitle;
  final Animation<double> animation;

  const OnboardingAnimatedTitle({
    super.key,
    required this.title,
    required this.subtitle,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final titleAnimation = Tween<Offset>(
          begin: const Offset(0, 0.5),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: animation,
            curve: const Interval(0.0, 0.5, curve: Curves.easeOutCubic),
          ),
        );

        final subtitleAnimation = Tween<Offset>(
          begin: const Offset(0, 0.5),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: animation,
            curve: const Interval(0.2, 0.7, curve: Curves.easeOutCubic),
          ),
        );

        final animationValue = animation.value.clamp(0.0, 1.0);

        return Column(
          children: [
            SlideTransition(
              position: titleAnimation,
              child: FadeTransition(
                opacity: animation,
                child: context.typography.gradientText(
                  title,
                  style: context.typography.headlineL.copyWith(
                    fontWeight: FontWeight.w900,
                    height: 1.1,
                  ),
                  colors: AppColors.primaryGradient,
                ),
              ),
            ),
            SizedBox(height: context.sizing.xs),
            SlideTransition(
              position: subtitleAnimation,
              child: Opacity(
                opacity: animationValue,
                child: Text(
                  subtitle,
                  style: context.typography.titleM.copyWith(
                    color: context.colors.surfaceAlpha(0.8),
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

// Page Indicator Widget
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
          width: currentPage == index ? context.sizing.size(32) : context.sizing.size(8),
          height: context.sizing.size(8),
          decoration: BoxDecoration(
            color: currentPage == index ? activeColor : inactiveColor,
            borderRadius: BorderRadius.circular(context.sizing.radiusS),
            boxShadow: currentPage == index
                ? [
                    BoxShadow(
                      color: activeColor.withValues(alpha: 0.4),
                      blurRadius: context.sizing.size(8),
                      spreadRadius: context.sizing.size(2),
                    ),
                  ]
                : null,
          ),
        ),
      ),
    );
  }
}

class OnboardingNavigationButtons extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final VoidCallback onNext;
  final VoidCallback onSkip;
  final VoidCallback onGetStarted;

  const OnboardingNavigationButtons({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onNext,
    required this.onSkip,
    required this.onGetStarted,
  });

  @override
  Widget build(BuildContext context) {
    final isLastPage = currentPage == totalPages - 1;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.sizing.l),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Skip Button
          if (!isLastPage)
            TextButton(
              onPressed: onSkip,
              style: TextButton.styleFrom(
                foregroundColor: context.colors.surfaceAlpha(0.7),
              ),
              child: Text(
                'Skip',
                style: context.typography.labelL.copyWith(
                  color: context.colors.surfaceAlpha(0.7),
                ),
              ),
            )
          else
            const SizedBox.shrink(),

          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            child: ElevatedButton(
              onPressed: isLastPage ? onGetStarted : onNext,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.onPrimary,
                padding: EdgeInsets.symmetric(
                  horizontal: context.sizing.xl,
                  vertical: context.sizing.m,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(context.sizing.radiusXL),
                ),
                elevation: 8,
                shadowColor: AppColors.primary.withValues(alpha: 0.4),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    isLastPage ? 'Get Started' : 'Next',
                    style: context.typography.labelL.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.onPrimary,
                    ),
                  ),
                  SizedBox(width: context.sizing.s),
                  Icon(
                    isLastPage ? Icons.rocket_launch : Icons.arrow_forward,
                    size: context.sizing.iconS,
                    color: AppColors.onPrimary,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingAnimatedBackground extends StatelessWidget {
  final List<Color> gradientColors;
  final Animation<double> animation;

  const OnboardingAnimatedBackground({
    super.key,
    required this.gradientColors,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.surfaceDark,
                AppColors.surfaceVariant,
                gradientColors.first.withValues(alpha: 0.1 * animation.value),
              ],
              stops: const [0.0, 0.7, 1.0],
            ),
          ),
          child: CustomPaint(
            painter: BackgroundPainter(
              animation.value,
            ),
          ),
        );
      },
    );
  }
}

