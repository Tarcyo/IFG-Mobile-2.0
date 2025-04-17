import 'package:flutter/material.dart';
import 'package:ifg_mobile_estudante/layers/presentation/styles/colors.dart';

class SubjectCard extends StatelessWidget {
  final Map<String, String> subjectData;

  const SubjectCard({
    Key? key,
    required this.subjectData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double padding = size.width * 0.05;
    final double spacing = size.width * 0.02;

    return Container(
      margin: EdgeInsets.symmetric(vertical: spacing * 1.5, horizontal: padding),
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
           ...AppColors.mainGradientColors
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColor,
            offset: Offset(2, spacing),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Nome da disciplina com ícone.
          Row(
            children: [
              Icon(
                Icons.menu_book,
                color: AppColors.textColor,
                size: size.width * 0.065,
              ),
              SizedBox(width: spacing),
              Expanded(
                child: Text(
                  subjectData['subject'] ?? '',
                  style: TextStyle(
                    color: AppColors.textColor,
                    fontSize: size.width * 0.05,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spacing),
          // Nome do professor.
          Row(
            children: [
              Icon(
                Icons.person,
                color: AppColors.descriptionColor,
                size: size.width * 0.045,
              ),
              SizedBox(width: spacing),
              Expanded(
                child: Text(
                  subjectData['teacher'] ?? '',
                  style: TextStyle(
                    color: AppColors.descriptionColor,
                    fontSize: size.width * 0.04,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spacing),
          // Situação na disciplina.
          Row(
            children: [
              Icon(
                Icons.verified,
                color: AppColors.buttonTextColor,
                size: size.width * 0.045,
              ),
              SizedBox(width: spacing),
              Expanded(
                child: Text(
                  subjectData['status'] ?? '',
                  style: TextStyle(
                    color: AppColors.descriptionColor,
                    fontSize: size.width * 0.04,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spacing),
          // Média final.
          Row(
            children: [
              Icon(
                Icons.grade,
                color: Colors.amber, // Caso deseje padronizar, crie uma propriedade em AppColors
                size: size.width * 0.05,
              ),
              SizedBox(width: spacing),
              Expanded(
                child: Text(
                  'Média: ${subjectData['average'] ?? ''}',
                  style: TextStyle(
                    color: AppColors.descriptionColor,
                    fontSize: size.width * 0.04,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spacing),
          // Faltas.
          Row(
            children: [
              Icon(
                Icons.warning_amber_outlined,
                color: AppColors.alertColor,
                size: size.width * 0.045,
              ),
              SizedBox(width: spacing),
              Expanded(
                child: Text(
                  'Faltas: ${subjectData['absences'] ?? ''}',
                  style: TextStyle(
                    color: AppColors.descriptionColor,
                    fontSize: size.width * 0.04,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
