import 'package:flutter/material.dart';
import 'package:ifg_mobile_estudante/layers/presentation/styles/colors.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController matriculaController;
  final TextEditingController senhaController;
  final bool lembrarDados;
  final bool loginAutomatico;
  final ValueChanged<bool?> onLoginAutoChanged;
  
  const LoginForm({
    Key? key,
    required this.matriculaController,
    required this.senhaController,
    required this.lembrarDados,
    required this.loginAutomatico,
    required this.onLoginAutoChanged,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double inputFontSize = size.width * 0.04;
    
    return Column(
      children: [
        _buildTextField(
          controller: matriculaController,
          hintText: 'Matrícula',
          icon: Icons.account_circle,
          fontSize: inputFontSize,
        ),
        const SizedBox(height: 15),
        _buildTextField(
          controller: senhaController,
          hintText: 'Senha',
          icon: Icons.lock,
          obscureText: true,
          fontSize: inputFontSize,
        ),
        const SizedBox(height: 20),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 10,
          runSpacing: 10,
          children: [
            _buildCheckbox('Login automático', loginAutomatico, onLoginAutoChanged),
          ],
        ),
      ],
    );
  }
  
  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool obscureText = false,
    required double fontSize,
  }) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
        borderRadius: BorderRadius.circular(180),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: TextStyle(fontSize: fontSize),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(fontSize: fontSize * 0.9),
          filled: true,
          fillColor: AppColors.textColor,  // Usando a cor sólida do AppColors para o fundo
          contentPadding: const EdgeInsets.symmetric(vertical: 18),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(180),
            borderSide: BorderSide.none,
          ),
          prefixIcon: Icon(
            icon,
            color: AppColors.solidBackgroundColor,  // Usando a cor do texto definida
            size: fontSize * 1.2,
          ),
        ),
      ),
    );
  }
  
  Widget _buildCheckbox(String title, bool value, Function(bool?) onChanged) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
          activeColor: AppColors.textColor,  // Usando a cor de texto definida para o checkbox
          checkColor: AppColors.solidBackgroundColor,  // Usando o verde para o check
        ),
        Flexible(
          child: Text(
            title,
            style: TextStyle(color: AppColors.textColor),  // Usando a cor do texto definida
            overflow: TextOverflow.visible,
            softWrap: true,
          ),
        ),
      ],
    );
  }
}
