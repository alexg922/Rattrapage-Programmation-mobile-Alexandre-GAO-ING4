import 'package:flutter/material.dart';
import 'package:rattrapage/res/app_colors.dart';

/// Zone d'affichage du résultat Morse — lecture seule, fond noir, texte vert.
class MorseOutput extends StatelessWidget {
  const MorseOutput({
    super.key,
    required this.label,
    required this.text,
    this.fontSize = 18.0,
    this.semanticsLabel,
  });

  final String label;
  final String text;
  final double fontSize;
  final String? semanticsLabel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label.toUpperCase(),
          style: const TextStyle(
            color: AppColors.primary,
            fontFamily: 'SpaceGrotesk',
            fontWeight: FontWeight.w500,
            fontSize: 13.0,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 8.0),
        Semantics(
          label: semanticsLabel ?? '$label $text',
          readOnly: true,
          child: Container(
            width: double.infinity,
            constraints: const BoxConstraints(minHeight: 60.0),
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.tertiary,
                width: 1.0,
              ),
              color: AppColors.neutral,
            ),
            child: Text(
              text.isEmpty ? '—' : text,
              style: TextStyle(
                color: text.isEmpty
                    ? AppColors.primary.withValues(alpha: 0.3)
                    : AppColors.primary,
                fontFamily: 'SpaceGrotesk',
                fontWeight: FontWeight.w400,
                fontSize: fontSize,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
