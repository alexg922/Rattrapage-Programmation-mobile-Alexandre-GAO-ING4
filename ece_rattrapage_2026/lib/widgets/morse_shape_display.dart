import 'package:flutter/material.dart';

/// Affiche un code Morse sous forme de formes graphiques (cercles blancs pour les points,
/// rectangles blancs pour les tirets) pour correspondre exactement aux maquettes.
class MorseShapeDisplay extends StatelessWidget {
  const MorseShapeDisplay({
    super.key,
    required this.morseCode,
  });

  final String morseCode;

  @override
  Widget build(BuildContext context) {
    if (morseCode.isEmpty) {
      return const SizedBox(height: 24.0);
    }

    return Wrap(
      spacing: 16.0,
      runSpacing: 16.0,
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: morseCode.split('').map((char) {
        if (char == '.') {
          return Container(
            width: 24.0,
            height: 24.0,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          );
        } else if (char == '-') {
          return Container(
            width: 48.0,
            height: 16.0,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
          );
        } else if (char == '/') {
          return const SizedBox(width: 24.0); // Espace entre les mots
        }
        return const SizedBox.shrink();
      }).toList(),
    );
  }
}
