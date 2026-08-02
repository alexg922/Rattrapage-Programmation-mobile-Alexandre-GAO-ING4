import 'package:flutter/material.dart';
import 'package:rattrapage/l10n/app_localizations.dart';
import 'package:rattrapage/models/morse_code.dart';
import 'package:rattrapage/pages/widgets/app_bar.dart';
import 'package:rattrapage/res/app_colors.dart';
import 'package:rattrapage/widgets/bottom_bar_image.dart';

/// Page Symboles — table Morse complète sous forme de grille.
class SymbolsScreen extends StatelessWidget {
  const SymbolsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final entries = MorseCode.charToMorse.entries
        .where((e) => e.key != ' ')
        .toList();

    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: CustomAppBar(
        showBack: true,
        title: l10n.app_name,
      ),
      bottomNavigationBar: const BottomBarImage(),
      body: Semantics(
        label: 'Table des symboles Morse',
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 16.0),
          itemCount: entries.length,
          separatorBuilder: (_, __) => const Divider(
            color: AppColors.tertiary,
            height: 1.0,
          ),
          itemBuilder: (context, index) {
            final entry = entries[index];
            return Semantics(
              label: '${entry.key} : ${entry.value}',
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Row(
                  children: <Widget>[
                    // Caractère
                    SizedBox(
                      width: 60.0,
                      child: Text(
                        entry.key,
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontFamily: 'SpaceGrotesk',
                          fontWeight: FontWeight.w700,
                          fontSize: 22.0,
                        ),
                      ),
                    ),
                    // Séparateur vertical
                    Container(
                      width: 1.5,
                      height: 28.0,
                      color: AppColors.tertiary,
                    ),
                    const SizedBox(width: 20.0),
                    // Code Morse
                    Expanded(
                      child: Text(
                        entry.value,
                        style: const TextStyle(
                          color: AppColors.secondary,
                          fontFamily: 'SpaceGrotesk',
                          fontWeight: FontWeight.w400,
                          fontSize: 20.0,
                          letterSpacing: 4.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
