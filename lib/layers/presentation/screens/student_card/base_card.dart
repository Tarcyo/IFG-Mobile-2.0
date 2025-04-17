import 'package:flutter/material.dart';
import 'package:ifg_mobile_estudante/layers/presentation/screens/student_card/stylist_painter.dart';
import 'package:ifg_mobile_estudante/layers/presentation/styles/colors.dart';

class CardBase extends StatelessWidget {
  final Size size;
  final Widget child;
  final bool showTopRightIcon;

  const CardBase({
    Key? key,
    required this.size,
    required this.child,
    this.showTopRightIcon = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = size.width * 0.9;
    final double height = size.height * 0.5;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: AppColors.mainGradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColor,
            offset: const Offset(0, 6),
            blurRadius: 12,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: AppColors.mainGradientColors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            CustomPaint(painter: StylishPainter()),
            if (showTopRightIcon)
              Positioned(
                top: size.height * 0.035,
                right: size.width * 0.045,
                child: Image.asset(
                  'assets/images/logo B.png', // Substitua pelo caminho correto da sua imagem
                  width: size.width * 0.26,
                  height: size.width * 0.26,
                  color: AppColors.textColor,
                  colorBlendMode: BlendMode.srcIn,
                ),
              ),
            Padding(
              padding: EdgeInsets.all(size.width * 0.045),
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
