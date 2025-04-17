import 'package:flutter/material.dart';
import 'package:ifg_mobile_estudante/layers/presentation/styles/colors.dart';

class SystemButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const SystemButton({
    Key? key,
    required this.label,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: size.height * 0.015,
          horizontal: size.width * 0.02,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: AppColors.mainGradientColors,  // Usando o gradiente definido no AppColors
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.textColor, width: 2),  // Cor da borda ajustada para textColor
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowColor,  // Usando a cor de sombra definida
              offset: const Offset(0, 2),
              blurRadius: 4,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: size.width * 0.08,
              color: AppColors.textColor,  // Usando a cor do texto para o ícone
              shadows: [
                Shadow(
                  color: AppColors.shadowColor,  // Sombra do ícone
                  offset: const Offset(1, 1),
                  blurRadius: 1,
                ),
              ],
            ),
            SizedBox(height: size.height * 0.008),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: size.width * 0.03,
                fontWeight: FontWeight.bold,
                color: AppColors.textColor,  // Usando a cor de texto definida
                shadows: [
                  Shadow(
                    color: AppColors.shadowColor,  // Sombra do texto
                    offset: const Offset(0.5, 0.5),
                    blurRadius: 1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
