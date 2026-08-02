import 'package:flutter/material.dart';
import 'package:rattrapage/res/app_colors.dart';

/// Sélecteur d'onglet TEXTE / MORSE.
/// L'onglet actif a un fond vert avec texte noir.
/// L'onglet inactif a un fond noir avec texte vert.
class ModeTabs extends StatelessWidget {
  const ModeTabs({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onTabSelected,
    this.semanticsLabels,
  });

  final List<String> tabs;
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;
  final List<String>? semanticsLabels;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primary, width: 1.0),
        color: AppColors.black,
      ),
      child: Row(
        children: List.generate(tabs.length, (index) {
          final isSelected = index == selectedIndex;
          return Expanded(
            child: Semantics(
              label: semanticsLabels?[index] ?? tabs[index],
              selected: isSelected,
              button: true,
              child: GestureDetector(
                onTap: () => onTabSelected(index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.all(2.0),
                  color: isSelected ? AppColors.primary : AppColors.black,
                  alignment: Alignment.center,
                  child: Text(
                    tabs[index].toUpperCase(),
                    style: TextStyle(
                      color:
                          isSelected ? AppColors.black : AppColors.primary,
                      fontFamily: 'SpaceGrotesk',
                      fontWeight: FontWeight.w600,
                      fontSize: 14.0,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
