import 'package:flutter/material.dart';
import 'package:ifg_mobile_estudante/layers/presentation/styles/colors.dart';

class CustomAppBar extends StatelessWidget {
  final String title;

  const CustomAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;

    final double horizontalPadding = screenWidth * 0.04;
    final double verticalPadding = screenWidth * 0.02;
    final double iconSize = screenWidth * 0.065;
    final double titleFontSize = screenWidth * 0.06;
    final double shadowBlur = screenWidth * 0.008;
    final double spacingRight = iconSize;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.textColor.withAlpha(25),
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
                Icons.arrow_back_rounded,
                color: AppColors.textColor,
                size: iconSize,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),

          SizedBox(width: screenWidth * 0.03),

          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.textColor,
                fontSize: titleFontSize,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    blurRadius: shadowBlur * 1.5,
                    color: AppColors.shadowColor,
                    offset: Offset(shadowBlur, shadowBlur),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(width: spacingRight),
        ],
      ),
    );
  }
}
