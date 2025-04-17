import 'package:flutter/material.dart';
import 'package:ifg_mobile_estudante/layers/presentation/styles/colors.dart';

class DedicationFooter extends StatelessWidget {
  final Size size;
  final double verticalPadding;
  
  const DedicationFooter({
    Key? key,
    required this.size,
    required this.verticalPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double nameSize = size.width * 0.045;
    final double subtitleSize = size.width * 0.035;
    return Padding(
      padding: EdgeInsets.only(
        top: verticalPadding * 0.5,
        bottom: verticalPadding * 0.7,
      ),
      child: Column(
        children: [
          Text(
            'Tarcyo Guilherme Maia Borges',
            style: TextStyle(
              fontSize: nameSize,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              color: AppColors.textColor,
              shadows: const [
                Shadow(
                  color: AppColors.shadowColor,
                  offset: Offset(0.5, 0.5),
                  blurRadius: 1.5,
                ),
              ],
            ),
          ),
          SizedBox(height: size.height * 0.005),
          Text(
            'Programador do aplicativo',
            style: TextStyle(
              fontSize: subtitleSize,
              color: AppColors.descriptionColor,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              shadows: const [
                Shadow(
                  color: AppColors.shadowColor,
                  offset: Offset(0.5, 0.5),
                  blurRadius: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
