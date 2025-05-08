import 'package:flutter/material.dart';
import 'package:ifg_mobile_estudante/layers/presentation/styles/colors.dart';

class DisciplineSelector extends StatelessWidget {
  final List<String> disciplines;
  final String selectedDiscipline;
  final Function(String) onDisciplineSelected;

  const DisciplineSelector({
    Key? key,
    required this.disciplines,
    required this.selectedDiscipline,
    required this.onDisciplineSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: disciplines.map((discipline) {
          final isSelected = discipline == selectedDiscipline;
          return ChoiceChip(
            label: Text(
              discipline,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isSelected
                    ? AppColors.cardColor
                    : AppColors.textColor,
              ),
            ),
            selected: isSelected,
            onSelected: (_) {
              if (!isSelected) {
                onDisciplineSelected(discipline);
              }
            },
            selectedColor: AppColors.textColor,
            backgroundColor: AppColors.mainGradientColors.first,
            labelPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            side: BorderSide.none,
            visualDensity: VisualDensity.compact,
          );
        }).toList(),
      ),
    );
  }
}
