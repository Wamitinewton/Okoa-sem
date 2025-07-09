import 'package:flutter/material.dart';
import 'package:okoa_sem/core/config/app_config.dart';
import 'package:okoa_sem/features/onboarding/models/onboarding_data.dart';
import 'package:okoa_sem/features/onboarding/widgets/onboarding_widgets.dart';

class OnboardingPageWidget extends StatefulWidget {
  final OnboardingPageData pageData;
  final bool isActive;

  const OnboardingPageWidget({
    super.key,
    required this.pageData,
    required this.isActive,
  });

  @override
  State<OnboardingPageWidget> createState() => _OnboardingPageWidgetState();
}

class _OnboardingPageWidgetState extends State<OnboardingPageWidget>
    with TickerProviderStateMixin {
  late AnimationController _mainController;
  late AnimationController _iconController;
  late AnimationController _backgroundController;

  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _mainController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _iconController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _backgroundController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.0, 0.8, curve: Curves.easeOut),
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.2, 1.0, curve: Curves.easeOutCubic),
      ),
    );

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.0, 0.6, curve: Curves.elasticOut),
      ),
    );
  }

  @override
  void didUpdateWidget(OnboardingPageWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive && !oldWidget.isActive) {
      _startAnimations();
    } else if (!widget.isActive && oldWidget.isActive) {
      _resetAnimations();
    }
  }

  void _startAnimations() {
    _backgroundController.forward();
    _mainController.forward();
    _iconController.forward();
  }

  void _resetAnimations() {
    _mainController.reset();
    _iconController.reset();
    _backgroundController.reset();
  }

  @override
  void dispose() {
    _mainController.dispose();
    _iconController.dispose();
    _backgroundController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {   
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          OnboardingAnimatedBackground(
            gradientColors: widget.pageData.gradientColors,
            animation: _backgroundController,
          ),
          
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: context.sizing.l),
              child: Column(
                children: [
                  SizedBox(height: context.sizing.xl),
                  
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: ScaleTransition(
                        scale: _scaleAnimation,
                        child: OnboardingAnimatedIcon(
                          icon: widget.pageData.icon,
                          gradientColors: widget.pageData.gradientColors,
                          animation: _iconController,
                          size: 120, // Reduced size
                        ),
                      ),
                    ),
                  ),
                  
                  Expanded(
                    flex: 2,
                    child: SingleChildScrollView(
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: FadeTransition(
                          opacity: _fadeAnimation,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              OnboardingAnimatedTitle(
                                title: widget.pageData.title,
                                subtitle: widget.pageData.subtitle,
                                animation: _mainController,
                              ),
                              
                              SizedBox(height: context.sizing.m),
                              
                              FadeTransition(
                                opacity: _fadeAnimation,
                                child: Container(
                                  padding: EdgeInsets.all(context.sizing.m),
                                  decoration: BoxDecoration(
                                    color: context.colors.surfaceVariant.withValues(alpha: 0.8),
                                    borderRadius: BorderRadius.circular(context.sizing.radiusL),
                                    border: Border.all(
                                      color: widget.pageData.gradientColors.first.withValues(alpha: 0.3),
                                      width: context.sizing.size(1),
                                    ),
                                  ),
                                  child: Text(
                                    widget.pageData.description,
                                    style: context.typography.bodyL.copyWith(
                                      height: 1.4,
                                      color: context.colors.surfaceAlpha(0.9),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              
                              SizedBox(height: context.sizing.l),
                              
                              OnboardingFeatureList(
                                features: widget.pageData.features,
                                animation: _mainController,
                              ),
                              
                              SizedBox(height: context.sizing.l),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  
                  SizedBox(height: context.sizing.s),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}