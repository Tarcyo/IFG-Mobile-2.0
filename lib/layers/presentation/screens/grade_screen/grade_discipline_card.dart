import 'package:flutter/material.dart';
import 'package:ifg_mobile_estudante/layers/presentation/styles/colors.dart';

class GradeCard extends StatelessWidget {
  final Map<String, String> gradeData;

  const GradeCard({Key? key, required this.gradeData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double horizontalPadding = size.width * 0.05;
    final double verticalMargin = size.height * 0.015;

    final double titleFontSize = size.width * 0.045;
    final double gradeFontSize = size.width * 0.055;
    final double descriptionFontSize = size.width * 0.04;
    final double mainIconSize = size.width * 0.065;
    final double secondaryIconSize = size.width * 0.05;

    return Container(
      margin: EdgeInsets.symmetric(vertical: verticalMargin, horizontal: horizontalPadding),
      padding: EdgeInsets.all(horizontalPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: AppColors.mainGradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowColor,
            offset: Offset(2, 4),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.assignment, color: AppColors.textColor, size: mainIconSize),
              SizedBox(width: horizontalPadding * 0.5),
              Expanded(
                child: Text(
                  gradeData['activity'] ?? '',
                  style: TextStyle(
                    color: AppColors.textColor,
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: horizontalPadding * 0.5),
          Row(
            children: [
              Row(
                children: [
                  Icon(Icons.star_rate, color: Colors.amber, size: secondaryIconSize),
                  SizedBox(width: horizontalPadding * 0.3),
                  Text(
                    '${gradeData['grade'] ?? ''}/100.0',
                    style: TextStyle(
                      color: AppColors.textColor,
                      fontSize: gradeFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  Icon(Icons.calendar_today, color: AppColors.descriptionColor, size: secondaryIconSize),
                  SizedBox(width: horizontalPadding * 0.3),
                  Text(
                    gradeData['date'] ?? '',
                    style: TextStyle(
                      color: AppColors.descriptionColor,
                      fontSize: descriptionFontSize,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: horizontalPadding * 0.6),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.info_outline, color: AppColors.descriptionColor, size: secondaryIconSize),
              SizedBox(width: horizontalPadding * 0.4),
              Expanded(
                child: Text(
                  gradeData['description'] ?? '',
                  style: TextStyle(
                    color: AppColors.descriptionColor,
                    fontSize: descriptionFontSize,
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
