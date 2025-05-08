import 'package:flutter/material.dart';
import 'package:ifg_mobile_estudante/layers/presentation/styles/colors.dart';
import 'button_painter.dart';

class MenuItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback? onTap;
  final Size size;

  const MenuItem({
    Key? key,
    required this.label,
    required this.icon,
    this.onTap,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        splashColor: AppColors.textColor.withValues( alpha: 0.24),
        highlightColor: AppColors.textColor.withValues( alpha: 0.10),
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
                color: Colors.black26,
                offset: Offset(2, 2),
                blurRadius: 6,
              ),
            ],
            border: Border.all(color: AppColors.textColor, width: 1.5),
          ),
          child: Stack(
            children: [
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
