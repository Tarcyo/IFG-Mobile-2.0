import 'package:flutter/material.dart';
import 'package:ifg_mobile_estudante/layers/presentation/styles/colors.dart';

TextStyle cardTextStyle(Size size, {bool isBold = false, double? fontSize}) {
  return TextStyle(
    color: AppColors.textColor,
    fontSize: fontSize ?? size.width * 0.038,
    fontWeight: isBold ? FontWeight.bold : FontWeight.w400,
    shadows: const [
      Shadow(blurRadius: 3, color: Colors.black26, offset: Offset(1, 1)),
    ],
  );
}
