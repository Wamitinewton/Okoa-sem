import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:okoa_sem/core/config/app_config.dart';
import 'package:okoa_sem/core/router/route.dart';
import 'package:okoa_sem/features/onboarding/models/onboarding_data.dart';
import 'package:okoa_sem/features/onboarding/widgets/onboarding_page_widget.dart';
import 'package:okoa_sem/features/onboarding/widgets/onboarding_widgets.dart';
import 'package:okoa_sem/shared/widgets/universal_background.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage>
    with TickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _fadeController;
  late AnimationController _backgroundController;
  
  int _currentPage = 0;
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fadeController.forward();
      _backgroundController.forward();
      _triggerHapticFeedback();
    });
  }

  void _initializeControllers() {
    _pageController = PageController();
    
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    
    _backgroundController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
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
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      ).then((_) {
        setState(() {
          _currentPage = nextPageIndex;
          _isAnimating = false;
        });
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
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      ).then((_) {
        setState(() {
          _currentPage = lastPageIndex;
          _isAnimating = false;
        });
      });
    }
  }

  void _getStarted() {
    _triggerHapticFeedback();
    AppRoute.login.go(context);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _fadeController.dispose();
    _backgroundController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          UniversalBackground(animation: _backgroundController),
          
          SafeArea(
            child: FadeTransition(
              opacity: _fadeController,
              child: Column(
                children: [
                  _buildTopSection(),
                  
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: OnboardingData.pages.length,
                      onPageChanged: (index) {
                        if (!_isAnimating) {
                          setState(() {
                            _currentPage = index;
                          });
                          _triggerHapticFeedback();
                        }
                      },
                      itemBuilder: (context, index) {
                        return OnboardingPageWidget(
                          pageData: OnboardingData.pages[index],
                          isActive: index == _currentPage,
                        );
                      },
                    ),
                  ),
                  
                  _buildBottomNavigation(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopSection() {
    return Container(
      padding: EdgeInsets.all(context.sizing.l),
      child: Column(
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
                style: context.typography.titleL.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              const Spacer(),
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
          
          SizedBox(height: context.sizing.l),
          
          OnboardingPageIndicator(
            currentPage: _currentPage,
            totalPages: OnboardingData.pages.length,
            activeColor: AppColors.primary,
            inactiveColor: AppColors.disabled,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation() {
    final isLastPage = _currentPage == OnboardingData.pages.length - 1;
    
    return Container(
      padding: EdgeInsets.all(context.sizing.l),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: isLastPage ? _getStarted : _nextPage,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.onPrimary,
            padding: EdgeInsets.symmetric(
              vertical: context.sizing.m,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(context.sizing.radiusL),
            ),
            elevation: 4,
            shadowColor: AppColors.primary.withValues(alpha: 0.3),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
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
    );
  }
}