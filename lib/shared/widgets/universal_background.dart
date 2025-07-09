import 'package:flutter/material.dart';
import 'package:okoa_sem/shared/painters/background_painter.dart';
import 'package:okoa_sem/core/config/app_config.dart';

class UniversalBackground extends StatelessWidget {
  final Animation<double> animation;

  const UniversalBackground({
    super.key,
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
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: AppColors.backgroundGradient,
              stops: [0.0, 0.5, 1.0],
            ),
          ),
          child: CustomPaint(
            painter: BackgroundPainter(animation.value),
          ),
        );
      },
    );
  }
}
