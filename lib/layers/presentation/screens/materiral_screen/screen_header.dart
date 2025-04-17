import 'package:flutter/material.dart';
import 'package:ifg_mobile_estudante/layers/presentation/styles/colors.dart';

class ScreenHeader extends StatelessWidget {
  final String title;
  final VoidCallback onBack;
  final double horizontalPadding;
  final double verticalPadding;
  final double fontSize;

  const ScreenHeader({
    Key? key,
    required this.title,
    required this.onBack,
    required this.horizontalPadding,
    required this.verticalPadding,
    required this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
                  blurRadius: 4,
                  offset: const Offset(2, 2),
                ),
              ],
            ),
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: AppColors.textColor),
              onPressed: onBack,
            ),
          ),
          SizedBox(width: size.width * 0.03),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.textColor,
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    blurRadius: 3,
                    color: AppColors.shadowColor,
                    offset: const Offset(1, 1),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: size.width * 0.13),
        ],
      ),
    );
  }
}
