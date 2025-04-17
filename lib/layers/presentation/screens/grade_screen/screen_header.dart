import 'package:flutter/material.dart';
import 'package:ifg_mobile_estudante/layers/presentation/providers/notas_list_controller_provider.dart';
import 'package:ifg_mobile_estudante/layers/presentation/styles/colors.dart';
import 'package:provider/provider.dart';

class ScreenHeader extends StatelessWidget {
  final String title;
  final Size size;
  final double verticalPadding;
  final List<String> disciplines;
  final String selectedDiscipline;
  final ValueChanged<String> onDisciplineSelected;

  const ScreenHeader({
    Key? key,
    required this.title,
    required this.size,
    required this.verticalPadding,
    required this.disciplines,
    required this.selectedDiscipline,
    required this.onDisciplineSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = size.width;
    final screenHeight = size.height;

    final double horizontalPadding = screenWidth * 0.04;
    final double iconSize = screenWidth * 0.065;
    final double titleFontSize = screenWidth * 0.06;
    final double dropdownFontSize = screenWidth * 0.03;
    final double dropdownPadding = screenHeight * 0.018;
    final double dropdownRadius = screenWidth * 0.02;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Cabeçalho
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: verticalPadding,
            horizontal: horizontalPadding,
          ),
          child: Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: AppColors.textColor,
                  size: iconSize,
                ),
                onPressed: () {
                  Provider.of<NotasControlerProvider>(
                    context,
                    listen: false,
                  ).controller;

                  Navigator.pop(context);
                },
              ),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: AppColors.textColor,
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(width: iconSize + 16),
            ],
          ),
        ),
        // Dropdown com gradiente
        Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: AppColors.screenBackgroundGradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(dropdownRadius),
              boxShadow: [
                BoxShadow(
                  color: AppColors.buttonShadowColor,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: dropdownPadding),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedDiscipline,
                  isExpanded: true,
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: AppColors.textColor,
                    size: iconSize,
                  ),
                  style: TextStyle(
                    color: AppColors.textColor,
                    fontSize: dropdownFontSize,
                  ),
                  selectedItemBuilder: (context) {
                    return disciplines.map((discipline) {
                      return Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          discipline,
                          style: TextStyle(
                            color: AppColors.textColor,
                            fontSize: dropdownFontSize,
                            fontFamily: "Quicksand",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }).toList();
                  },
                  dropdownColor: AppColors.mainGradientColors.first,
                  onChanged: (newValue) {
                    if (newValue != null) {
                      onDisciplineSelected(newValue);
                    }
                  },
                  items:
                      disciplines.map((discipline) {
                        return DropdownMenuItem<String>(
                          value: discipline,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: dropdownPadding,
                              vertical: dropdownPadding * 0.6,
                            ),
                            child: Text(
                              discipline,
                              style: TextStyle(
                                color: AppColors.textColor,
                                fontSize: dropdownFontSize,
                                fontFamily: "Quicksand",
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
