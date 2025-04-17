import 'package:flutter/material.dart';
import 'package:ifg_mobile_estudante/layers/presentation/screens/student_card/carteirinhaEstudanteScreen.dart';
import 'package:ifg_mobile_estudante/layers/presentation/styles/colors.dart';
import 'button_painter.dart';

class BottomNavigation extends StatelessWidget {
  final Size size;
  final double horizontalPadding;
  final double verticalPadding;

  const BottomNavigation({
    Key? key,
    required this.size,
    required this.horizontalPadding,
    required this.verticalPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CarteirinhaEstudanteScreen(),
          ),
        ),
        child: Container(
          height: size.height * 0.07,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: const LinearGradient(
              colors: AppColors.mainGradientColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 8,
                offset: const Offset(2, 2),
              ),
            ],
            border: Border.all(
              color: AppColors.textColor,
              width: 1.5,
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              CustomPaint(
                size: Size(double.infinity, size.height * 0.07),
                painter: ButtonPainter(),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.badge_rounded,
                    color: AppColors.textColor,
                    size: size.width * 0.07,
                  ),
                  SizedBox(width: size.width * 0.03),
                  Text(
                    'Carteira do Estudante',
                    style: TextStyle(
                      color: AppColors.textColor,
                      fontSize: size.width * 0.045,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
