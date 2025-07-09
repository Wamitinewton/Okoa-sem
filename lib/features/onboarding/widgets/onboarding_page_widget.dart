import 'package:flutter/material.dart';
import 'package:okoa_sem/core/config/app_config.dart';
import 'package:okoa_sem/features/onboarding/models/onboarding_data.dart';

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
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    
    if (widget.isActive) {
      _startAnimation();
    }
  }

  void _initializeAnimations() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.8, curve: Curves.easeOut),
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 1.0, curve: Curves.easeOut),
      ),
    );
  }

  @override
  void didUpdateWidget(OnboardingPageWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive && !oldWidget.isActive) {
      _startAnimation();
    }
  }

  void _startAnimation() {
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(
        context.sizing.l,
        context.sizing.m,
        context.sizing.l,
        context.sizing.l + 60,
      ),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: context.sizing.m),
                  
                  _buildIcon(),
                  
                  SizedBox(height: context.sizing.xl),
                  
                  _buildTitleSection(),
                  
                  SizedBox(height: context.sizing.l),
                  
                  _buildDescription(),
                  
                  SizedBox(height: context.sizing.l),
                  
                  _buildFeatures(),
                  
                  SizedBox(height: context.sizing.l),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildIcon() {
    return Container(
      width: context.sizing.size(100),
      height: context.sizing.size(100),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: AppColors.accentGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(context.sizing.radiusXL),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.2), 
            blurRadius: context.sizing.size(15),
            spreadRadius: context.sizing.size(2),
            offset: Offset(0, context.sizing.size(5)),
          ),
        ],
      ),
      child: Icon(
        widget.pageData.icon,
        size: context.sizing.size(50),
        color: AppColors.onPrimary,
      ),
    );
  }

  Widget _buildTitleSection() {
    return Column(
      children: [
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: AppColors.primaryGradient, 
          ).createShader(bounds),
          child: Text(
            widget.pageData.title,
            style: context.typography.headlineL.copyWith(
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        
        SizedBox(height: context.sizing.xs),
        
        Text(
          widget.pageData.subtitle,
          style: context.typography.titleM.copyWith(
            color: context.colors.surfaceAlpha(0.8),
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return Container(
      padding: EdgeInsets.all(context.sizing.l),
      decoration: BoxDecoration(
        color: context.colors.surfaceVariant.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(context.sizing.radiusL),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.2), 
          width: 1,
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
    );
  }

  Widget _buildFeatures() {
    return Column(
      children: widget.pageData.features
          .asMap()
          .entries
          .map((entry) => _buildFeatureItem(entry.value, entry.key))
          .toList(),
    );
  }

  Widget _buildFeatureItem(OnboardingFeature feature, int index) {
    return Container(
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
          width: 1,
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
    );
  }
}