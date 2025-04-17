import 'package:flutter/material.dart';
import 'package:ifg_mobile_estudante/layers/presentation/styles/colors.dart';

class LessonCard extends StatelessWidget {
  final Map<String, String> lesson;

  const LessonCard({Key? key, required this.lesson}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final double horizontalPadding = size.width * 0.05;
    final double innerPadding = size.width * 0.045;
    final double iconSize = size.width * 0.06;
    final double titleFontSize = size.width * 0.05;
    final double smallFontSize = size.width * 0.04;
    final double spacing = size.height * 0.015;
    final double borderRadius = size.width * 0.05;

    return Container(
      margin: EdgeInsets.symmetric(vertical: spacing, horizontal: horizontalPadding),
      padding: EdgeInsets.all(innerPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        gradient: LinearGradient(
          colors: [
            AppColors.mainGradientColors[0],
            AppColors.mainGradientColors[1],
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColor,
            offset: const Offset(2, 4),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Linha superior: horário e local
          Row(
            children: [
              Icon(Icons.access_time, color: AppColors.descriptionColor, size: iconSize),
              SizedBox(width: size.width * 0.02),
              Text(
                '${lesson['start']} - ${lesson['end']}',
                style: TextStyle(
                  color: AppColors.descriptionColor,
                  fontSize: smallFontSize,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Icon(Icons.location_on, color: AppColors.descriptionColor, size: iconSize),
              SizedBox(width: size.width * 0.015),
              Text(
                lesson['location'] ?? '',
                style: TextStyle(
                  color: AppColors.descriptionColor,
                  fontSize: smallFontSize,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: spacing),
          // Nome da disciplina
          Row(
            children: [
              Icon(Icons.book, color: AppColors.textColor, size: iconSize + 2),
              SizedBox(width: size.width * 0.025),
              Expanded(
                child: Text(
                  lesson['subject'] ?? '',
                  style: TextStyle(
                    color: AppColors.textColor,
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spacing * 0.8),
          // Professor
          Row(
            children: [
              Icon(Icons.person_outline, color: AppColors.descriptionColor, size: iconSize),
              SizedBox(width: size.width * 0.02),
              Text(
                lesson['professor'] ?? '',
                style: TextStyle(
                  color: AppColors.descriptionColor,
                  fontSize: smallFontSize,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
