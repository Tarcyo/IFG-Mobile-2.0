import 'package:flutter/material.dart';
import 'package:ifg_mobile_estudante/layers/presentation/styles/colors.dart';

class YearSelector extends StatelessWidget {
  final List<String> years;
  final String selectedYear;
  final Function(String) onYearSelected;

  const YearSelector({
    Key? key,
    required this.years,
    required this.selectedYear,
    required this.onYearSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: years.map((year) {
          final isSelected = year == selectedYear;
          return ChoiceChip(
            label: Text(
              year,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isSelected ? AppColors.cardColor : AppColors.textColor,
              ),
            ),
            selected: isSelected,
            onSelected: (_) {
              if (!isSelected) {
                onYearSelected(year);
              }
            },
            selectedColor: AppColors.textColor,
            backgroundColor: AppColors.screenBackgroundGradient.first,
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
