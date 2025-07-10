// lib/features/otp/presentation/widgets/otp_input_cell.dart

import 'package:flutter/material.dart';
import 'package:okoa_sem/core/config/app_config.dart';

class OtpInputCell extends StatefulWidget {
  final String value;
  final bool isActive;
  final bool hasError;
  final bool isCompleted;
  final VoidCallback? onTap;

  const OtpInputCell({
    super.key,
    required this.value,
    this.isActive = false,
    this.hasError = false,
    this.isCompleted = false,
    this.onTap,
  });

  @override
  State<OtpInputCell> createState() => _OtpInputCellState();
}

class _OtpInputCellState extends State<OtpInputCell>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void didUpdateWidget(OtpInputCell oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    if (widget.isActive && !oldWidget.isActive) {
      _animationController.forward();
    } else if (!widget.isActive && oldWidget.isActive) {
      _animationController.reverse();
    }

    if (widget.value.isNotEmpty && oldWidget.value.isEmpty) {
      _playPulseAnimation();
    }
  }

  void _playPulseAnimation() {
    _animationController.forward().then((_) {
      _animationController.reverse();
    });
  }

  Color _getBorderColor(BuildContext context) {
    if (widget.hasError) {
      return context.colors.error;
    } else if (widget.isActive) {
      return context.colors.primary;
    } else if (widget.isCompleted) {
      return context.colors.success;
    } else {
      return context.colors.border;
    }
  }

  Color _getBackgroundColor(BuildContext context) {
    if (widget.hasError) {
      return context.colors.error.withOpacity(0.1);
    } else if (widget.isActive) {
      return context.colors.primaryAlpha(0.1);
    } else if (widget.isCompleted) {
      return context.colors.success.withOpacity(0.1);
    } else {
      return context.colors.surfaceVariant;
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.scale(
            scale: widget.isActive ? _scaleAnimation.value : _pulseAnimation.value,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: context.sizing.size(50),
              height: context.sizing.size(56),
              decoration: BoxDecoration(
                color: _getBackgroundColor(context),
                borderRadius: BorderRadius.circular(context.sizing.radiusM),
                border: Border.all(
                  color: _getBorderColor(context),
                  width: widget.isActive || widget.hasError ? 2 : 1,
                ),
                boxShadow: widget.isActive
                    ? [
                        BoxShadow(
                          color: context.colors.primaryAlpha(0.2),
                          blurRadius: context.sizing.size(8),
                          spreadRadius: context.sizing.size(1),
                        ),
                      ]
                    : widget.hasError
                        ? [
                            BoxShadow(
                              color: context.colors.error.withOpacity(0.2),
                              blurRadius: context.sizing.size(8),
                              spreadRadius: context.sizing.size(1),
                            ),
                          ]
                        : null,
              ),
              child: Center(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 150),
                  child: widget.value.isEmpty
                      ? _buildPlaceholder(context)
                      : _buildValue(context),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPlaceholder(BuildContext context) {
    if (!widget.isActive) {
      return SizedBox.shrink(
        key: const ValueKey('empty'),
      );
    }

    return Container(
      key: const ValueKey('cursor'),
      width: context.sizing.size(2),
      height: context.sizing.size(20),
      decoration: BoxDecoration(
        color: context.colors.primary,
        borderRadius: BorderRadius.circular(context.sizing.size(1)),
      ),
      child: _buildBlinkingCursor(),
    );
  }

  Widget _buildBlinkingCursor() {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 800),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return AnimatedOpacity(
          opacity: (value * 2) % 2 > 1 ? 1.0 : 0.3,
          duration: const Duration(milliseconds: 100),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(1),
            ),
          ),
        );
      },
      onEnd: () {
        if (mounted && widget.isActive) {
          setState(() {});
        }
      },
    );
  }

  Widget _buildValue(BuildContext context) {
    return Text(
      widget.value,
      key: ValueKey('value_${widget.value}'),
      style: context.typography.headlineM.copyWith(
        color: widget.hasError
            ? context.colors.error
            : widget.isCompleted
                ? context.colors.success
                : context.colors.onSurface,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }
}