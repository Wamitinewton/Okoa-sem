import 'package:flutter/material.dart';
import 'package:okoa_sem/core/config/app_config.dart';
import 'package:okoa_sem/shared/widgets/universal_background.dart';

class LoadingScreen extends StatefulWidget {
  final String? message;
  final bool showLogo;

  const LoadingScreen({
    super.key,
    this.message,
    this.showLogo = true,
  });

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.surface,
      body: Stack(
        children: [
          UniversalBackground(animation: _controller),
          
          SafeArea(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.showLogo) ...[
                      _buildLogo(),
                      SizedBox(height: context.sizing.xxl),
                    ],
                    
                    _buildLoadingIndicator(),
                    
                    if (widget.message != null) ...[
                      SizedBox(height: context.sizing.l),
                      _buildMessage(),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      width: context.sizing.size(80),
      height: context.sizing.size(80),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: AppColors.primaryGradient,
        ),
        borderRadius: BorderRadius.circular(context.sizing.radiusXL),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: context.sizing.size(20),
            spreadRadius: context.sizing.size(2),
          ),
        ],
      ),
      child: Icon(
        Icons.school,
        size: context.sizing.size(40),
        color: AppColors.onPrimary,
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return SizedBox(
      width: context.sizing.size(40),
      height: context.sizing.size(40),
      child: CircularProgressIndicator(
        strokeWidth: context.sizing.size(3),
        valueColor: AlwaysStoppedAnimation<Color>(
          AppColors.primary,
        ),
      ),
    );
  }

  Widget _buildMessage() {
    return Text(
      widget.message!,
      style: context.typography.bodyM.copyWith(
        color: context.colors.surfaceAlpha(0.8),
      ),
      textAlign: TextAlign.center,
    );
  }
}