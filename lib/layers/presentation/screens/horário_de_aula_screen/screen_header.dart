import 'package:flutter/material.dart';
import 'package:ifg_mobile_estudante/layers/presentation/styles/colors.dart';

class ScreenHeader extends StatelessWidget {
  final String title;
  final Size size;
  final double verticalPadding;

  const ScreenHeader({
    Key? key,
    required this.title,
    required this.size,
    required this.verticalPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double iconSize = size.width * 0.065;
    final double horizontalPadding = size.width * 0.04;
    final double spacing = size.width * 0.03;
    final double fakeRightSpace = size.width * 0.13;
    final double titleFontSize = size.width * 0.06;
    final double shadowBlur = size.width * 0.008;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.textColor.withValues(alpha: 0.1),
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
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          SizedBox(width: spacing),
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
          SizedBox(width: fakeRightSpace),
        ],
      ),
    );
  }
}
