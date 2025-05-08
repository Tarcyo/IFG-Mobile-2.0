// lib/widgets/button_painter.dart

import 'package:flutter/material.dart';
import 'package:ifg_mobile_estudante/layers/presentation/styles/colors.dart';

class ButtonPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..shader = LinearGradient(
            colors: [
              AppColors.textColor.withValues(alpha: .1),
              AppColors.textColor.withValues(alpha: 0.0),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
          ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height * 0.2);
    path.quadraticBezierTo(size.width * 0.5, 0, size.width, size.height * 0.2);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
