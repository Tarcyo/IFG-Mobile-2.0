// Exemplo de atualização no app_colors.dart:
import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const List<Color> mainGradientColors = [
    Color(0xFF00695C),
    Color(0xFF388E3C),
    Color(0xFF4CAF50),
  ];
  static const List<Color> screenBackgroundGradient = [
    Color(0xFF00695C),
    Color(0xFF388E3C),
  ];

  static const List<Color> tabBarGradient = [
    Color(0xFF00695C),
    Color(0xFF388E3C),
    Color(0xFF388E3C),
  ];


  static const Color textColor = Colors.white;
  static const Color descriptionColor = Colors.white70;
  static const Color solidBackgroundColor = Color(0xFF4CAF50);
  static final Color cardColor = Colors.teal.shade900;
  static final Color buttonTextColor = Colors.green.shade100;
  static const Color alertColor = Colors.red;

  // Novas propriedades para sombras e elementos do CampusScreen:
  static const Color shadowColor = Colors.black26;
  static final Color buttonShadowColor = Colors.black.withValues(alpha: 0.2);
}
