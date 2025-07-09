import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:okoa_sem/core/config/app_config.dart';
import 'package:okoa_sem/features/onboarding/models/onboarding_data.dart';
import 'package:okoa_sem/features/onboarding/widgets/onboarding_page_widget.dart';
import 'package:okoa_sem/features/onboarding/widgets/onboarding_widgets.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage>
    with TickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _buttonController;
  late AnimationController _indicatorController;
  
  int _currentPage = 0;
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _setupPageController();
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _triggerHapticFeedback();
    });
  }

  void _initializeControllers() {
    _pageController = PageController();
    
    _buttonController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    _indicatorController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    
    _buttonController.forward();
    _indicatorController.forward();
  }

  void _setupPageController() {
    _pageController.addListener(() {
      final page = _pageController.page;
      if (page != null && !_isAnimating) {
        final newPage = page.round();
        if (newPage != _currentPage) {
          _updateCurrentPage(newPage);
        }
      }
    });
  }

  void _updateCurrentPage(int newPage) {
    setState(() {
      _currentPage = newPage;
    });
    _triggerHapticFeedback();
  }

  void _triggerHapticFeedback() {
    HapticFeedback.lightImpact();
  }

  void _nextPage() {
    if (_currentPage < OnboardingData.pages.length - 1 && !_isAnimating) {
      _isAnimating = true;
      _triggerHapticFeedback();
      
      final nextPageIndex = _currentPage + 1;
      
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic,
      ).then((_) {
        // Fixed: Ensure the page state is updated after animation completes
        if (mounted) {
          _updateCurrentPage(nextPageIndex);
        }
        _isAnimating = false;
      });
    }
  }

  void _skipToEnd() {
    if (!_isAnimating) {
      _isAnimating = true;
      _triggerHapticFeedback();
      
      final lastPageIndex = OnboardingData.pages.length - 1;
      
      _pageController.animateToPage(
        lastPageIndex,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      ).then((_) {
        // Fixed: Ensure the page state is updated after animation completes
        if (mounted) {
          _updateCurrentPage(lastPageIndex);
        }
        _isAnimating = false;
      });
    }
  }

  void _getStarted() {
    _triggerHapticFeedback();
    _buttonController.reverse().then((_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Welcome to Okoa Sem! 🎉',
              style: context.typography.bodyM.copyWith(
                color: AppColors.onPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            backgroundColor: AppColors.primary,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(context.sizing.radiusM),
            ),
            margin: EdgeInsets.all(context.sizing.m),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _buttonController.dispose();
    _indicatorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceDark,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: OnboardingData.pages.length,
            onPageChanged: (index) {
              // Fixed: Only update if not animating programmatically
              if (!_isAnimating) {
                _updateCurrentPage(index);
              }
            },
            itemBuilder: (context, index) {
              return OnboardingPageWidget(
                pageData: OnboardingData.pages[index],
                isActive: index == _currentPage,
              );
            },
          ),
          
          _buildTopSection(),
          
          _buildBottomSection(),
        ],
      ),
    );
  }

  Widget _buildTopSection() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: SafeArea(
        child: AnimatedBuilder(
          animation: _buttonController,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, -50 * (1 - _buttonController.value)),
              child: Opacity(
                opacity: _buttonController.value,
                child: Padding(
                  padding: EdgeInsets.all(context.sizing.l),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(context.sizing.s),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(context.sizing.radiusM),
                            ),
                            child: Icon(
                              Icons.school,
                              color: AppColors.onPrimary,
                              size: context.sizing.iconM,
                            ),
                          ),
                          SizedBox(width: context.sizing.s),
                          Text(
                            'Okoa Sem',
                            style: context.typography.titleM.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                      
                      if (_currentPage < OnboardingData.pages.length - 1)
                        TextButton(
                          onPressed: _skipToEnd,
                          style: TextButton.styleFrom(
                            foregroundColor: context.colors.surfaceAlpha(0.7),
                            padding: EdgeInsets.symmetric(
                              horizontal: context.sizing.m,
                              vertical: context.sizing.s,
                            ),
                          ),
                          child: Text(
                            'Skip',
                            style: context.typography.labelL.copyWith(
                              color: context.colors.surfaceAlpha(0.7),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildBottomSection() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: SafeArea(
        child: AnimatedBuilder(
          animation: _indicatorController,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, 100 * (1 - _indicatorController.value)),
              child: Opacity(
                opacity: _indicatorController.value,
                child: Container(
                  padding: EdgeInsets.all(context.sizing.l),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        AppColors.surfaceDark.withValues(alpha: 0.8),
                        AppColors.surfaceDark,
                      ],
                      stops: const [0.0, 0.5, 1.0],
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Page Indicator
                      OnboardingPageIndicator(
                        currentPage: _currentPage,
                        totalPages: OnboardingData.pages.length,
                        activeColor: OnboardingData.pages[_currentPage].gradientColors.first,
                        inactiveColor: AppColors.disabled,
                      ),
                      
                      SizedBox(height: context.sizing.xl),
                      
                      // Navigation Buttons
                      OnboardingNavigationButtons(
                        currentPage: _currentPage,
                        totalPages: OnboardingData.pages.length,
                        onNext: _nextPage,
                        onSkip: _skipToEnd,
                        onGetStarted: _getStarted,
                      ),
                      
                      SizedBox(height: context.sizing.s),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}