import 'package:flutter/material.dart';
import 'package:okoa_sem/core/config/app_colors.dart';

class BackgroundPainter extends CustomPainter {
  final double animationValue;
  final Color? color;
  final double? strokeWidth;
  final int? lineCount;
  final int? segmentCount;

  BackgroundPainter(
    this.animationValue, {
    this.color,
    this.strokeWidth,
    this.lineCount,
    this.segmentCount,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = (color ?? AppColors.primary).withOpacity(0.05 * animationValue)
      ..strokeWidth = strokeWidth ?? _calculateStrokeWidth(size)
      ..style = PaintingStyle.stroke;

    final path = Path();
    final lines = lineCount ?? 5;
    final segments = segmentCount ?? 8;

    for (int i = 0; i < lines; i++) {
      final y = size.height * (0.2 + i * 0.15);
      path.moveTo(0, y);

      for (int j = 0; j < segments; j++) {
        final x = size.width * (j / (segments - 1));
        final offsetY = _calculateOffset(size, animationValue, j);
        path.lineTo(x, y + offsetY);
      }
    }

    canvas.drawPath(path, paint);
  }

  double _calculateStrokeWidth(Size size) {
    final baseStrokeWidth = 1.0;
    final scale = size.width / 375.0; 
    return baseStrokeWidth * scale;
  }

  double _calculateOffset(Size size, double animation, int segmentIndex) {
    final baseOffset = size.height * 0.025; 
    final multiplier = segmentIndex.isEven ? 1 : -1;
    return baseOffset * animation * multiplier;
  }

  @override
  bool shouldRepaint(BackgroundPainter oldDelegate) =>
      oldDelegate.animationValue != animationValue ||
      oldDelegate.color != color ||
      oldDelegate.strokeWidth != strokeWidth ||
      oldDelegate.lineCount != lineCount ||
      oldDelegate.segmentCount != segmentCount;
}