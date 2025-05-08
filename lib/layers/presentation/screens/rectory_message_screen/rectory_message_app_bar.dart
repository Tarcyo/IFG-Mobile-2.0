
import 'package:flutter/material.dart';
import 'package:ifg_mobile_estudante/layers/presentation/styles/colors.dart';

// AppBar customizada para reitoria
class ReitoriaAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final horizontalPadding = size.width * 0.04;
    final verticalPadding = size.width * 0.02;
    final iconSize = size.width * 0.065;
    final titleFontSize = size.width * 0.06;
    final shadowBlur = size.width * 0.008;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      child: Row(
        children: [
          // Botão de voltar
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

          SizedBox(width: size.width * 0.03),

          Expanded(
            child: Text(
              'Mensagem da Reitoria',
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

          SizedBox(width: iconSize),
        ],
      ),
    );
  }
}