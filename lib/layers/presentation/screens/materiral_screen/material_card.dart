import 'package:flutter/material.dart';
import 'package:ifg_mobile_estudante/layers/presentation/styles/colors.dart';

class MaterialCard extends StatelessWidget {
  final Map<String, String> material;

  const MaterialCard({Key? key, required this.material}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double horizontalPadding = size.width * 0.05;
    final double iconSize = size.width * 0.06;
    final double smallIconSize = size.width * 0.05;
    final double fontSizeTitle = size.width * 0.045;
    final double fontSizeInfo = size.width * 0.04;
    final double spacing = size.width * 0.02;
    final double cardRadius = size.width * 0.05;
    final double cardElevation = size.width * 0.02;

    return Container(
      margin: EdgeInsets.symmetric(vertical: spacing * 2, horizontal: horizontalPadding),
      padding: EdgeInsets.all(horizontalPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(cardRadius),
        gradient: LinearGradient(
          colors: AppColors.mainGradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColor,
            offset: Offset(cardElevation, cardElevation * 2),
            blurRadius: cardElevation * 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cabeçalho com ícone, nome do material e botão de download
          Row(
            children: [
              Icon(Icons.folder_open, color: AppColors.textColor, size: iconSize),
              SizedBox(width: spacing),
              Expanded(
                child: Text(
                  material['name'] ?? '',
                  style: TextStyle(
                    color: AppColors.textColor,
                    fontSize: fontSizeTitle,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.download, color: AppColors.textColor, size: iconSize),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Iniciando download...')),
                  );
                },
              ),
            ],
          ),
          SizedBox(height: spacing * 1.5),
          // Informações do arquivo: tipo e data
          Row(
            children: [
              Row(
                children: [
                  Icon(Icons.insert_drive_file, color: AppColors.descriptionColor, size: smallIconSize),
                  SizedBox(width: spacing),
                  Text(
                    material['fileType'] ?? '',
                    style: TextStyle(
                      color: AppColors.descriptionColor,
                      fontSize: fontSizeInfo,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  Icon(Icons.calendar_today, color: AppColors.descriptionColor, size: smallIconSize),
                  SizedBox(width: spacing),
                  Text(
                    material['date'] ?? '',
                    style: TextStyle(
                      color: AppColors.descriptionColor,
                      fontSize: fontSizeInfo,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
