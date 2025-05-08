import 'package:flutter/material.dart';
import 'package:ifg_mobile_estudante/layers/presentation/screens/student_card/card_text_style.dart';
import 'package:ifg_mobile_estudante/layers/presentation/styles/colors.dart';

Widget infoRow(Size size, IconData icon, String label, String value) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: size.height * 0.004),
    child: Row(
      children: [
        Icon(
          icon,
          color: AppColors.textColor.withValues(alpha:0.95),
          size: size.width * 0.04,
          shadows: [
            Shadow(
              blurRadius: 2,
              color: AppColors.shadowColor,
              offset: const Offset(1, 1),
            ),
          ],
        ),
        SizedBox(width: size.width * 0.02),
        Expanded(
          child: RichText(
            text: TextSpan(
              text: '$label ',
              style: cardTextStyle(size, isBold: true),
              children: [TextSpan(text: value, style: cardTextStyle(size))],
            ),
          ),
        ),
      ],
    ),
  );
}
