import 'package:flutter/material.dart';
import 'package:ifg_mobile_estudante/layers/presentation/styles/colors.dart';

Widget buildHeader(Size size) {
  final double verticalPadding = size.height * 0.02;

  final double titleFontSize = size.width * 0.06;
  final double shadowBlur = size.width * 0.01;

  return Column(
    children: [
      SizedBox(height: verticalPadding),
      Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadowColor,
              offset: Offset(0, 2),
              blurRadius: 4,
            ),
          ],
        ),
        child: CircleAvatar(
          radius: size.height * 0.07,
          backgroundColor: AppColors.textColor,
          child: Icon(
            Icons.travel_explore_rounded,
            size: size.height * 0.06,
            color: AppColors.solidBackgroundColor,
          ),
        ),
      ),
      SizedBox(height: verticalPadding * 0.6),

      Text(
        "Campi",
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

      SizedBox(height: verticalPadding),
    ],
  );
}