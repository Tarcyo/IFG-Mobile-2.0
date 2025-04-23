import 'package:flutter/material.dart';
import 'package:ifg_mobile_estudante/layers/presentation/styles/colors.dart';

class CustomHeader extends StatelessWidget {
  final double verticalPadding;
  final Size size;

  const CustomHeader({
    Key? key,
    required this.verticalPadding,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = size.width;

    // 📐 Mesmas proporções do ScreenHeader original
    final double horizontalPadding = screenWidth * 0.04;
    final double iconSize = screenWidth * 0.065;
    final double titleFontSize = screenWidth * 0.06;
    final double shadowBlur = screenWidth * 0.008;
    final double spacing = screenWidth * 0.03;
    final double fakeRightSpace = screenWidth * 0.13;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadowColor,
                  blurRadius: shadowBlur,
                  offset: Offset(shadowBlur, shadowBlur),
                ),
              ],
            ),
            child: IconButton(
              iconSize: iconSize,
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: iconSize,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          SizedBox(width: spacing),
          Expanded(
            child: Text(
              'Carteira do Estudante',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.textColor,
                fontSize: titleFontSize,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    blurRadius: shadowBlur * 1.5,
                    color: Colors.black38,
                    offset: Offset(shadowBlur, shadowBlur),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: fakeRightSpace),
        ],
      ),
    );
  }
}
