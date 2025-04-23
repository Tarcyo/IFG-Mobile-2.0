import 'package:flutter/material.dart';
import 'package:ifg_mobile_estudante/layers/presentation/styles/colors.dart';

class ScreenHeader extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color? iconColor;
  final double verticalPadding;
  final double avatarRadius;
  final double iconSize;

  const ScreenHeader({
    Key? key,
    required this.title,
    required this.icon,
    this.iconColor,
    required this.verticalPadding,
    required this.avatarRadius,
    required this.iconSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: verticalPadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
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
              radius: avatarRadius,
              backgroundColor: AppColors.textColor,
              child: Icon(
                icon,
                size: iconSize,
                color: iconColor ?? AppColors.solidBackgroundColor,
              ),
            ),
          ),
          SizedBox(height: verticalPadding * 0.6),
          Text(
            title,
            style: TextStyle(
              fontSize: size.width * 0.06,
              fontWeight: FontWeight.bold,
              color: AppColors.textColor,
              letterSpacing: 1.5,
              shadows: const [
                Shadow(
                  color: AppColors.shadowColor,
                  offset: Offset(0, 1),
                  blurRadius: 2,
                ),
              ],
            ),
          ),
          SizedBox(height: verticalPadding),
        ],
      ),
    );
  }
}
