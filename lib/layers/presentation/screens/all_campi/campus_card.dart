import 'package:flutter/material.dart';
import 'package:ifg_mobile_estudante/layers/presentation/styles/colors.dart';

class CampusCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final VoidCallback onTap;

  const CampusCard({
    super.key,
    required this.title,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Material(
      color: AppColors.cardColor,
      elevation: 4,
      borderRadius: BorderRadius.circular(size.width * 0.03),
      child: InkWell(
        borderRadius: BorderRadius.circular(size.width * 0.03),
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(size.width * 0.03),
                ),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Center(
                    child: Icon(
                      Icons.image_not_supported,
                      size: size.width * 0.1,
                      color: AppColors.alertColor,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(size.width * 0.02),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: size.width * 0.035,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
