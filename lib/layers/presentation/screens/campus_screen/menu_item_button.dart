import 'package:flutter/material.dart';
import 'package:ifg_mobile_estudante/layers/presentation/styles/colors.dart';

class MenuItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback? onTap;

  const MenuItem({
    Key? key,
    required this.label,
    required this.icon,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        splashColor: AppColors.textColor.withValues(alpha: 0.24),
        highlightColor: AppColors.textColor.withValues(alpha: 0.10),
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: const LinearGradient(
              colors: AppColors.mainGradientColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: const [
              BoxShadow(
                color: AppColors.shadowColor,
                offset: Offset(2, 2),
                blurRadius: 6,
              ),
            ],
            border: Border.all(color: AppColors.textColor, width: 1.5),
          ),
          child: Stack(
            children: [
              // CustomPainter para efeito extra no botão.
              CustomPaint(
                size: Size(double.infinity, double.infinity),
                painter: ButtonPainter(),
              ),
              Padding(
                padding: EdgeInsets.all(size.width * 0.04),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      icon,
                      size: size.width * 0.12,
                      color: AppColors.textColor,
                    ),
                    SizedBox(height: size.height * 0.01),
                    Text(
                      label,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: size.width * 0.04,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ButtonPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..shader = LinearGradient(
            colors: [
              AppColors.textColor.withValues(alpha: 0.1),
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
