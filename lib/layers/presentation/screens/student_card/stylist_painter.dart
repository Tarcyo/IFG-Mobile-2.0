import 'package:flutter/material.dart';
import 'package:ifg_mobile_estudante/layers/presentation/styles/colors.dart';

class StylishPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..shader = LinearGradient(
            colors: [
              AppColors.textColor.withValues(alpha: 0.05),
              AppColors.textColor.withValues(alpha: 0.1),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
          ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height * 0.4);
    path.quadraticBezierTo(
      size.width * 0.3,
      size.height * 0.25,
      size.width * 0.65,
      size.height * 0.35,
    );
    path.quadraticBezierTo(
      size.width * 0.9,
      size.height * 0.45,
      size.width,
      size.height * 0.3,
    );
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
