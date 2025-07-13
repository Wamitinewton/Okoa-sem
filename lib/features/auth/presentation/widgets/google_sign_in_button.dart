import 'package:flutter/material.dart';
import 'package:okoa_sem/core/config/app_config.dart';

class GoogleSignInButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final bool isLoading;

  const GoogleSignInButton({
    super.key,
    this.onPressed,
    this.isLoading = false,
  });

  @override
  State<GoogleSignInButton> createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(
      CurvedAnimation(
        parent: _scaleController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    if (widget.onPressed != null) {
      _scaleController.forward();
    }
  }

  void _onTapUp(TapUpDetails details) {
    if (widget.onPressed != null) {
      _scaleController.reverse();
    }
  }

  void _onTapCancel() {
    if (widget.onPressed != null) {
      _scaleController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: GestureDetector(
        onTapDown: widget.onPressed != null ? _onTapDown : null,
        onTapUp: widget.onPressed != null ? _onTapUp : null,
        onTapCancel: widget.onPressed != null ? _onTapCancel : null,
        onTap: widget.onPressed,
        child: Container(
          width: double.infinity,
          height: context.sizing.buttonL,
          decoration: BoxDecoration(
            gradient: widget.onPressed != null
                ? const LinearGradient(
                    colors: AppColors.primaryGradient,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : LinearGradient(
                    colors: [
                      AppColors.disabled,
                      AppColors.disabled.withValues(alpha: 0.8),
                    ],
                  ),
            borderRadius: BorderRadius.circular(context.sizing.radiusL),
            boxShadow: widget.onPressed != null
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.3),
                      blurRadius: context.sizing.size(12),
                      spreadRadius: context.sizing.size(2),
                      offset: Offset(0, context.sizing.size(4)),
                    ),
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      blurRadius: context.sizing.size(20),
                      spreadRadius: context.sizing.size(4),
                      offset: Offset(0, context.sizing.size(8)),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: context.sizing.size(4),
                      offset: Offset(0, context.sizing.size(2)),
                    ),
                  ],
          ),
          child: widget.isLoading
              ? _buildLoadingContent()
              : _buildButtonContent(),
        ),
      ),
    );
  }

  Widget _buildButtonContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildGoogleIcon(),
        SizedBox(width: context.sizing.m),
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [
              Colors.white,
              Colors.white,
            ],
          ).createShader(bounds),
          child: Text(
            'Continue with Google',
            style: context.typography.labelL.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: context.sizing.iconS,
          height: context.sizing.iconS,
          child: CircularProgressIndicator(
            strokeWidth: context.sizing.size(2),
            valueColor: const AlwaysStoppedAnimation<Color>(
              Colors.white,
            ),
          ),
        ),
        SizedBox(width: context.sizing.m),
        Text(
          'Signing in...',
          style: context.typography.labelL.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildGoogleIcon() {
    return Container(
      width: context.sizing.iconM,
      height: context.sizing.iconM,
      padding: EdgeInsets.all(context.sizing.xs),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(context.sizing.radiusS),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: context.sizing.size(4),
            offset: Offset(0, context.sizing.size(1)),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(context.sizing.radiusS),
        child: Image.asset(
          AssetConstants.googleLogo,
          width: context.sizing.iconS,
          height: context.sizing.iconS,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            // Simple fallback icon if image fails to load
            return Icon(
              Icons.login,
              size: context.sizing.iconS,
              color: AppColors.primary,
            );
          },
        ),
      ),
    );
  }
}