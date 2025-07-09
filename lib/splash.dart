import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:okoa_sem/core/config/app_config.dart';
import 'package:okoa_sem/core/router/route.dart'; 
import 'package:okoa_sem/shared/widgets/universal_background.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _textController;
  late AnimationController _particleController;
    late AnimationController _backgroundController;


  late Animation<double> _logoScale;
  late Animation<double> _logoOpacity;
  late Animation<Offset> _logoSlide;

  late Animation<double> _titleOpacity;
  late Animation<Offset> _titleSlide;
  late Animation<double> _subtitleOpacity;
  late Animation<Offset> _subtitleSlide;


  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAnimationSequence();
  }

  void _initializeAnimations() {
    _backgroundController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _textController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _particleController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    _logoScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeInOut),
      ),
    );

    _logoOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeInOut),
      ),
    );

    _logoSlide = Tween<Offset>(
      begin: const Offset(0, -0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeOutCubic),
    );

    _titleOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _textController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeInOut),
      ),
    );

    _titleSlide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeOutCubic),
    );

    _subtitleOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _textController,
        curve: const Interval(0.3, 0.8, curve: Curves.easeInOut),
      ),
    );

    _subtitleSlide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _textController,
        curve: const Interval(0.3, 0.8, curve: Curves.easeOutCubic),
      ),
    );

  
  }

  void _startAnimationSequence() async {
    HapticFeedback.lightImpact();

    _backgroundController.forward();

    _particleController.repeat();

    await Future.delayed(const Duration(milliseconds: 300));
    _logoController.forward();

    await Future.delayed(const Duration(milliseconds: 800));
    _textController.forward();

    await Future.delayed(const Duration(milliseconds: 2500));
    _navigateToNext();
  }

  void _navigateToNext() {
    AppRoute.onboarding.go(context);
  }

  @override
  void dispose() {
    _backgroundController.dispose();
    _logoController.dispose();
    _textController.dispose();
    _particleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.surface,
      body: Stack(
        children: [
          UniversalBackground(animation: _backgroundController),
          _buildMainContent(),
          _buildLoadingIndicator(),
        ],
      ),
    );
  }


  Widget _buildMainContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildLogoSection(),
          SizedBox(height: context.sizing.xxl),
          _buildTextSection(),
          SizedBox(height: context.sizing.l),
          _buildTaglineSection(),
        ],
      ).paddingH(context, 24),
    );
  }

  Widget _buildLogoSection() {
    return AnimatedBuilder(
      animation: Listenable.merge([_logoController]),
      builder: (context, child) {
        final logoSize = context.sizing.widthPercent(50);

        return SlideTransition(
          position: _logoSlide,
          child: FadeTransition(
            opacity: _logoOpacity,
            child: ScaleTransition(
              scale: _logoScale,
              child: Container(
                width: logoSize,
                height: logoSize,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(context.sizing.radiusXL),
                  boxShadow: [
                    BoxShadow(
                      color: context.colors.primaryAlpha(0.3),
                      blurRadius: context.sizing.size(30),
                      spreadRadius: context.sizing.size(5),
                    ),
                    BoxShadow(
                      color: context.colors.overlay,
                      blurRadius: context.sizing.size(20),
                      offset: Offset(0, context.sizing.size(10)),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(context.sizing.radiusXL),
                  child: Image.asset(
                    AssetConstants.mustLogo,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(context.sizing.radiusXL),
                          gradient: const LinearGradient(
                            colors: AppColors.primaryGradient,
                          ),
                        ),
                        child: Icon(
                          Icons.school,
                          size: context.sizing.size(60),
                          color: context.colors.onPrimary,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextSection() {
    return AnimatedBuilder(
      animation: _textController,
      builder: (context, child) {
        return Column(
          children: [
            SlideTransition(
              position: _titleSlide,
              child: FadeTransition(
                opacity: _titleOpacity,
                child: context.typography.gradientText(
                  'Okoa Sem',
                  style: context.typography.appTitle,
                  colors: AppColors.primaryGradient,
                ),
              ),
            ),
            SizedBox(height: context.sizing.s),
            SlideTransition(
              position: _subtitleSlide,
              child: FadeTransition(
                opacity: _subtitleOpacity,
                child: Text(
                  'Your Academic Success Partner',
                  style: context.typography.subtitle,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTaglineSection() {
    return AnimatedBuilder(
      animation: _textController,
      builder: (context, child) {
        return FadeTransition(
          opacity: _subtitleOpacity,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: context.sizing.l,
              vertical: context.sizing.s,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(context.sizing.radiusL),
              border: Border.all(
                color: context.colors.primaryAlpha(0.3),
                width: context.sizing.size(1),
              ),
              color: context.colors.primaryAlpha(0.1),
            ),
            child: Text(
              '📚 Past Papers • Study Materials • Exam Prep',
              style: context.typography.bodyM.copyWith(
                color: context.colors.primary,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoadingIndicator() {
    return Positioned(
      bottom: context.sizing.size(80) + MediaQuery.of(context).padding.bottom,
      left: 0,
      right: 0,
      child: AnimatedBuilder(
        animation: _textController,
        builder: (context, child) {
          return FadeTransition(
            opacity: _subtitleOpacity,
            child: Column(
              children: [
                SizedBox(
                  width: context.sizing.size(40),
                  height: context.sizing.size(40),
                  child: CircularProgressIndicator(
                    strokeWidth: context.sizing.size(3),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      context.colors.primary,
                    ),
                  ),
                ),
                SizedBox(height: context.sizing.m),
                Text(
                  'Preparing your study materials...',
                  style: context.typography.caption,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}