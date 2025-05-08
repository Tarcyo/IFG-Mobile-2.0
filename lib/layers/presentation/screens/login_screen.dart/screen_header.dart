import 'package:flutter/material.dart';
import 'package:ifg_mobile_estudante/layers/presentation/styles/colors.dart';



class LoginHeader extends StatelessWidget {
  final String logoAsset;
  
  const LoginHeader({Key? key, required this.logoAsset}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double logoSize = size.width * 0.35;
    final double titleFontSize = size.width * 0.07;
    final double shadowBlur = size.width * 0.01;
    
    return Column(
      children: [
        Container(
          width: logoSize,
          height: logoSize,
          decoration: BoxDecoration(
            color: AppColors.textColor,
            shape: BoxShape.circle,
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 12,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Center(
            child: Image.asset(
              logoAsset,
              width: logoSize * 0.7,
            ),
          ),
        ),
        const SizedBox(height: 25),
        Text(
          'Bem-vindo ao IFG',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: titleFontSize,
            fontWeight: FontWeight.bold,
            color: AppColors.textColor,
            shadows: [
              Shadow(
                blurRadius: shadowBlur * 1.5,
                color: Colors.black38,
                offset: Offset(shadowBlur, shadowBlur),
              ),
            ],
          ),
        ),
      ],
    );
  }
}