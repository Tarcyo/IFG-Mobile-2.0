import 'package:flutter/material.dart';
import 'package:ifg_mobile_estudante/layers/presentation/styles/colors.dart';

class LoginButton extends StatelessWidget {
  final VoidCallback onLogin;
  
  const LoginButton({Key? key, required this.onLogin}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double buttonWidth = size.width * 0.6;
    final double fontSizeButton = size.width * 0.05;
    
    return ElevatedButton(
      onPressed: onLogin,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(
          horizontal: buttonWidth * 0.5,
          vertical: 16,
        ),
        backgroundColor: AppColors.textColor,  // Usando a cor sólida definida em AppColors
        elevation: 10,
        shadowColor: AppColors.shadowColor,  // Usando a cor de sombra definida
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(180),
        ),
      ),
      child: Text(
        'Entrar',
        style: TextStyle(
          fontSize: fontSizeButton,
          fontWeight: FontWeight.bold,
          color: AppColors.solidBackgroundColor,  // Usando a cor do texto definida
        ),
      ),
    );
  }
}
