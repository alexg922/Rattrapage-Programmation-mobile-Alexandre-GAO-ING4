import 'package:flutter/material.dart';
import 'package:rattrapage/res/app_colors.dart';

/// Zone de saisie Morse stylisée — bordure verte, fond noir, texte vert.
class MorseInputField extends StatelessWidget {
  const MorseInputField({
    super.key,
    required this.label,
    required this.controller,
    this.hint,
    this.maxLines = 3,
    this.readOnly = false,
    this.autofocus = false,
    this.onChanged,
    this.textCapitalization = TextCapitalization.characters,
    this.semanticsLabel,
  });

  final String label;
  final TextEditingController controller;
  final String? hint;
  final int maxLines;
  final bool readOnly;
  final bool autofocus;
  final ValueChanged<String>? onChanged;
  final TextCapitalization textCapitalization;
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
          label: semanticsLabel ?? label,
          textField: true,
          readOnly: readOnly,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.primary, width: 1.0),
              color: AppColors.black,
            ),
            child: TextField(
              controller: controller,
              maxLines: maxLines,
              readOnly: readOnly,
              autofocus: autofocus,
              textCapitalization: textCapitalization,
              onChanged: onChanged,
              style: const TextStyle(
                color: AppColors.primary,
                fontFamily: 'SpaceGrotesk',
                fontWeight: FontWeight.w400,
                fontSize: 16.0,
              ),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(
                  color: AppColors.primary.withValues(alpha: 0.3),
                  fontFamily: 'SpaceGrotesk',
                ),
                contentPadding: const EdgeInsets.all(12.0),
                border: InputBorder.none,
              ),
              cursorColor: AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }
}
