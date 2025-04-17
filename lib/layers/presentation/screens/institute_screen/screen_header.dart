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
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadowColor,  // Usando a cor de sombra
                  offset: const Offset(0, 2),
                  blurRadius: 4,
                ),
              ],
            ),
            child: CircleAvatar(
              radius: avatarRadius,
              backgroundColor: Colors.white,
              child: Icon(
                icon,
                size: iconSize,
                color: iconColor ?? AppColors.textColor,  // Usando a cor de ícone
              ),
            ),
          ),
          SizedBox(height: verticalPadding * 0.5),
          Text(
            title,
            style: TextStyle(
              fontSize: size.width * 0.03,
              fontWeight: FontWeight.bold,
              color: AppColors.textColor,  // Usando a cor de texto
              letterSpacing: 1.2,
              shadows: [
                Shadow(
                  color: AppColors.shadowColor,  // Usando a cor de sombra
                  offset: const Offset(0, 1),
                  blurRadius: 2,
                ),
              ],
            ),
          ),
          SizedBox(height: verticalPadding * 0.05),
        ],
      ),
    );
  }
}
