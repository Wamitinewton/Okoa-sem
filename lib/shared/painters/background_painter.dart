import 'package:flutter/material.dart';

class BackgroundPainter extends CustomPainter{
  final double animationValue;

  BackgroundPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
    ..color = const Color(0xFFC5F432).withOpacity(0.05 * animationValue)
    ..strokeWidth = 1
    ..style = PaintingStyle.stroke;

    final path = Path();

  for (int i = 0; i< 5; i++) {
    final y = size.height * (0.2 + 1 * 0.15);
    path.moveTo(0, y);

    for (int j = 0; j < 8; j++) {
      final x = size.width * (j / 7);
      final offsetY = 20 * (animationValue * (j.isEven ? 1 : -1));
      path.lineTo(x, y + offsetY);
    }
  }

  canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(BackgroundPainter oldDelegate) =>
    oldDelegate.animationValue != animationValue;
  }

