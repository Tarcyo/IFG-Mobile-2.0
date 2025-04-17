import 'package:flutter/material.dart';
import 'package:ifg_mobile_estudante/layers/presentation/styles/colors.dart';

class MenuItem extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const MenuItem({
    Key? key,
    required this.icon,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  State<MenuItem> createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTapDown: (_) => setState(() => _scale = 0.95),
      onTapUp: (_) => setState(() => _scale = 1.0),
      onTapCancel: () => setState(() => _scale = 1.0),
      onTap: widget.onTap,
      child: AnimatedScale(
        duration: const Duration(milliseconds: 100),
        scale: _scale,
        child: CustomPaint(
          painter: MenuItemPainter(borderRadius: size.width * 0.05),
          child: Padding(
            padding: EdgeInsets.all(size.width * 0.02),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    widget.icon,
                    size: size.width * 0.08,
                    color: AppColors.textColor, // Usando a cor de texto
                    shadows: const [
                      Shadow(
                        color: Colors.black26,
                        offset: Offset(1, 1),
                        blurRadius: 1,
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.01),
                  Text(
                    widget.label,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: size.width * 0.03,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textColor, // Usando a cor de texto
                      shadows: const [
                        Shadow(
                          color: Colors.black26,
                          offset: Offset(0.5, 0.5),
                          blurRadius: 1,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MenuItemPainter extends CustomPainter {
  final double borderRadius;

  MenuItemPainter({required this.borderRadius});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);

    final shadowPaint =
        Paint()
          ..color =
              AppColors
                  .shadowColor // Usando a cor de sombra definida
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        rect.shift(const Offset(2, 2)),
        Radius.circular(borderRadius),
      ),
      shadowPaint,
    );

    final gradientPaint =
        Paint()
          ..shader = LinearGradient(
            colors:
                AppColors.mainGradientColors, // Usando o gradiente das cores
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(rect);
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, Radius.circular(borderRadius)),
      gradientPaint,
    );

    final borderPaint =
        Paint()
          ..color = AppColors.textColor.withValues(
            alpha: 0.85,
          ) // Usando a cor de texto
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        rect.deflate(0.75),
        Radius.circular(borderRadius - 1),
      ),
      borderPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
