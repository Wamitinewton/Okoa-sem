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
    _scaleController.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _scaleController.reverse();
  }

  void _onTapCancel() {
    _scaleController.reverse();
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
                ? LinearGradient(
                    colors: [
                      Colors.white,
                      Colors.grey.shade50,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : LinearGradient(
                    colors: [
                      Colors.grey.shade300,
                      Colors.grey.shade400,
                    ],
                  ),
            borderRadius: BorderRadius.circular(context.sizing.radiusL),
            boxShadow: widget.onPressed != null
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: context.sizing.size(8),
                      spreadRadius: context.sizing.size(1),
                      offset: Offset(0, context.sizing.size(2)),
                    ),
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: context.sizing.size(15),
                      spreadRadius: context.sizing.size(2),
                      offset: Offset(0, context.sizing.size(4)),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: context.sizing.size(4),
                      offset: Offset(0, context.sizing.size(1)),
                    ),
                  ],
            border: Border.all(
              color: Colors.grey.shade300,
              width: 1,
            ),
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
        Text(
          'Continue with Google',
          style: context.typography.labelL.copyWith(
            color: Colors.grey.shade700,
            fontWeight: FontWeight.w600,
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
            valueColor: AlwaysStoppedAnimation<Color>(
              AppColors.primary,
            ),
          ),
        ),
        SizedBox(width: context.sizing.m),
        Text(
          'Signing in...',
          style: context.typography.labelL.copyWith(
            color: Colors.grey.shade600,
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
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: CustomPaint(
        painter: GoogleIconPainter(),
      ),
    );
  }
}

class GoogleIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    
    // Draw Google "G" logo
    // Background circle
    paint.color = Colors.white;
    canvas.drawCircle(center, radius, paint);
    
    // Red section
    paint.color = const Color(0xFFEA4335);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius * 0.8),
      -0.5236, // -30 degrees
      2.0944, // 120 degrees
      true,
      paint,
    );
    
    // Yellow section
    paint.color = const Color(0xFFFBBC05);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius * 0.8),
      1.5708, // 90 degrees
      1.0472, // 60 degrees
      true,
      paint,
    );
    
    // Green section
    paint.color = const Color(0xFF34A853);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius * 0.8),
      2.618, // 150 degrees
      1.0472, // 60 degrees
      true,
      paint,
    );
    
    // Blue section
    paint.color = const Color(0xFF4285F4);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius * 0.8),
      3.665, // 210 degrees
      1.5708, // 90 degrees
      true,
      paint,
    );
    
    // Inner white circle (for the "G" shape)
    paint.color = Colors.white;
    canvas.drawCircle(center, radius * 0.4, paint);
    
    // Draw the "G" letter
    paint.color = const Color(0xFF4285F4);
    paint.strokeWidth = radius * 0.15;
    paint.style = PaintingStyle.stroke;
    paint.strokeCap = StrokeCap.round;
    
    // Vertical line of G
    canvas.drawLine(
      Offset(center.dx - radius * 0.2, center.dy - radius * 0.25),
      Offset(center.dx - radius * 0.2, center.dy + radius * 0.25),
      paint,
    );
    
    // Top horizontal line
    canvas.drawLine(
      Offset(center.dx - radius * 0.2, center.dy - radius * 0.25),
      Offset(center.dx + radius * 0.15, center.dy - radius * 0.25),
      paint,
    );
    
    // Bottom horizontal line
    canvas.drawLine(
      Offset(center.dx - radius * 0.2, center.dy + radius * 0.25),
      Offset(center.dx + radius * 0.15, center.dy + radius * 0.25),
      paint,
    );
    
    // Middle horizontal line (shorter)
    canvas.drawLine(
      Offset(center.dx + radius * 0.05, center.dy),
      Offset(center.dx + radius * 0.15, center.dy),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}