import 'package:flutter/material.dart';
import 'package:ifg_mobile_estudante/layers/presentation/providers/boletim_controller_provider.dart';
import 'package:ifg_mobile_estudante/layers/presentation/styles/colors.dart';
import 'package:provider/provider.dart';

class HeaderWidget extends StatelessWidget {

  const HeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;

    final double horizontalPadding = screenWidth * 0.04;
    final double verticalPadding = screenWidth * 0.04;
    final double iconSize = screenWidth * 0.065;
    final double spacingAfterIcon = screenWidth * 0.03;
    final double spacingEnd = screenWidth * 0.13;
    final double titleFontSize = screenWidth * 0.06;
    final double shadowBlur = screenWidth * 0.008;

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
                  offset: Offset(iconSize * 0.07, iconSize * 0.07),
                ),
              ],
            ),
            child: IconButton(
              iconSize: iconSize,
              icon: Icon(
                Icons.arrow_back,
                color: AppColors.textColor,
                size: iconSize,
              ),
              onPressed: () {
                Provider.of<AnosBoletimControllerProvider>(context,listen: false).controller.anosBoletim=null;
                Navigator.pop(context);
              }
            ),
          ),
          SizedBox(width: spacingAfterIcon),

          Expanded(
            child: Text(
              'Boletim Escolar',
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

          SizedBox(width: spacingEnd),
        ],
      ),
    );
  }
}
