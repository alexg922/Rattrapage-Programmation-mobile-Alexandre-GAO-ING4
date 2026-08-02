import 'package:flutter/material.dart';
import 'package:rattrapage/res/app_colors.dart';

enum NeonButtonVariant {
  primary, // Fond vert clair, texte noir
  secondary, // Fond vert foncé, texte blanc ou vert
}

/// Bouton stylisé pour correspondre aux maquettes.
class NeonButton extends StatelessWidget {
  const NeonButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.width = double.infinity,
    this.height = 53.0,
    this.enabled = true,
    this.semanticsLabel,
    this.variant = NeonButtonVariant.primary,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final double width;
  final double height;
  final bool enabled;
  final String? semanticsLabel;
  final NeonButtonVariant variant;

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;

    switch (variant) {
      case NeonButtonVariant.primary:
        bgColor = AppColors.primary;
        textColor = AppColors.black;
        break;
      case NeonButtonVariant.secondary:
        // Use a very dark green or tertiary for the secondary button
        bgColor = const Color(0xFF003B00); // AppColors.tertiary
        textColor = AppColors.white; // White text based on mockup for VALIDER
        break;
    }

    if (!enabled) {
      bgColor = bgColor.withValues(alpha: 0.3);
      textColor = textColor.withValues(alpha: 0.5);
    }

    return Semantics(
      label: semanticsLabel ?? label,
      button: true,
      enabled: enabled,
      child: GestureDetector(
        onTap: enabled ? onPressed : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: bgColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 8.0,
            children: <Widget>[
              if (icon != null) Icon(icon, color: textColor, size: 20.0),
              Text(
                label.toUpperCase(),
                style: TextStyle(
                  color: textColor,
                  fontFamily: 'SpaceGrotesk',
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
