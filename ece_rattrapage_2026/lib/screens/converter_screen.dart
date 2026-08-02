import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rattrapage/l10n/app_localizations.dart';
import 'package:rattrapage/pages/widgets/app_bar.dart';
import 'package:rattrapage/providers/converter_provider.dart';
import 'package:rattrapage/res/app_colors.dart';
import 'package:rattrapage/res/app_icons.dart';
import 'package:rattrapage/screens/symbols_screen.dart';
import 'package:rattrapage/widgets/mode_tabs.dart';
import 'package:rattrapage/widgets/morse_input.dart';
import 'package:rattrapage/widgets/morse_output.dart';
import 'package:rattrapage/widgets/neon_button.dart';

/// Page Convertisseur — onglets TEXTE (→ Morse) et MORSE (→ Texte).
class ConverterScreen extends StatefulWidget {
  const ConverterScreen({super.key});

  @override
  State<ConverterScreen> createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  final TextEditingController _textController = TextEditingController();
  late final ConverterProvider _converterProvider;

  @override
  void initState() {
    super.initState();
    _converterProvider = ConverterProvider();
  }

  @override
  void dispose() {
    _textController.dispose();
    _converterProvider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return ChangeNotifierProvider<ConverterProvider>.value(
      value: _converterProvider,
      child: Consumer<ConverterProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            backgroundColor: AppColors.black,
            appBar: CustomAppBar(
              title: l10n.app_name,
              showBack: false,
              actions: [
                Semantics(
                  label: 'Voir la table des symboles Morse',
                  button: true,
                  child: IconButton(
                    icon: const Icon(AppIcons.terminal),
                    color: AppColors.primary,
                    tooltip: 'Symboles',
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => const SymbolsScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            body: Column(
              children: <Widget>[
                // ── Sélecteur d'onglets ──────────────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(17.0, 16.0, 17.0, 0.0),
                  child: ModeTabs(
                    tabs: [
                      l10n.converter_tab_text,
                      l10n.converter_tab_morse,
                    ],
                    semanticsLabels: [
                      'Onglet conversion Texte vers Morse',
                      'Onglet conversion Morse vers Texte',
                    ],
                    selectedIndex: provider.tab == ConverterTab.text ? 0 : 1,
                    onTabSelected: (i) => provider.selectTab(
                      i == 0 ? ConverterTab.text : ConverterTab.morse,
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
                const Divider(height: 1.0, color: AppColors.tertiary),
                const SizedBox(height: 8.0),
                // ── Contenu selon l'onglet ───────────────────
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    child: provider.tab == ConverterTab.text
                        ? _TextToMorseTab(
                            key: const ValueKey('text'),
                            provider: provider,
                            controller: _textController,
                            l10n: l10n,
                          )
                        : _MorseToTextTab(
                            key: const ValueKey('morse'),
                            provider: provider,
                            l10n: l10n,
                          ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Onglet Texte → Morse
// ─────────────────────────────────────────────────────────────
class _TextToMorseTab extends StatelessWidget {
  const _TextToMorseTab({
    super.key,
    required this.provider,
    required this.controller,
    required this.l10n,
  });

  final ConverterProvider provider;
  final TextEditingController controller;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(17.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16.0,
        children: <Widget>[
          // Champ de saisie texte
          MorseInputField(
            label: l10n.converter_text_input,
            controller: controller,
            hint: 'Saisissez votre texte…',
            maxLines: 4,
            textCapitalization: TextCapitalization.sentences,
            semanticsLabel: 'Champ de saisie du texte à convertir en Morse',
            onChanged: provider.setTextInput,
          ),
          // Bouton Convertir
          NeonButton(
            label: l10n.converter_text_button_convert,
            semanticsLabel: 'Convertir le texte en code Morse',
            onPressed: () {
              provider.setTextInput(controller.text);
              provider.convertTextToMorse();
            },
          ),
          // Résultat Morse
          if (provider.morseResult.isNotEmpty) ...[
            MorseOutput(
              label: l10n.converter_text_result,
              text: provider.morseResult,
              semanticsLabel: 'Résultat en code Morse : ${provider.morseResult}',
            ),
            // Bouton Jouer (vibrations — bonus)
            NeonButton(
              label: provider.isPlaying
                  ? 'Lecture…'
                  : l10n.converter_text_button_haptics,
              icon: AppIcons.haptics,
              enabled: !provider.isPlaying,
              semanticsLabel:
                  'Jouer le code Morse par vibrations',
              onPressed: provider.playMorse,
            ),
          ],
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Onglet Morse → Texte
// ─────────────────────────────────────────────────────────────
class _MorseToTextTab extends StatelessWidget {
  const _MorseToTextTab({
    super.key,
    required this.provider,
    required this.l10n,
  });

  final ConverterProvider provider;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(17.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16.0,
        children: <Widget>[
          // Instructions
          if (!provider.isStarted)
            Text(
              'Appuyez sur ${l10n.converter_morse_button_start.toUpperCase()} puis\n'
              'maintenez le bouton CODE pour composer\nle Morse.\n'
              '< 300 ms = point  ·    ≥ 300 ms = tiret  —',
              style: TextStyle(
                color: AppColors.primary.withValues(alpha: 0.6),
                fontFamily: 'SpaceGrotesk',
                fontSize: 14.0,
                height: 1.6,
              ),
            ),

          if (!provider.isStarted)
            // Bouton Commencer
            NeonButton(
              label: l10n.converter_morse_button_start,
              semanticsLabel: 'Commencer la saisie en code Morse',
              variant: NeonButtonVariant.primary,
              onPressed: provider.startMorseInput,
            ),

          if (provider.isStarted) ...[
            // Lettre en cours de composition
            _CurrentLetterDisplay(provider: provider),

            // Bouton CODE et STOP en ligne
            Row(
              spacing: 12.0,
              children: <Widget>[
                Expanded(
                  child: Semantics(
                    label:
                        'Bouton Code : appui court = point, appui long = tiret',
                    button: true,
                    child: GestureDetector(
                      onTapDown: (_) => provider.onCodeTapDown(),
                      onTapUp: (_) => provider.onCodeTapUp(),
                      onTapCancel: () {
                        // Si l'utilisateur annule, on considère un point
                        provider.onCodeTapUp();
                      },
                      child: Container(
                        height: 53.0,
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          l10n.converter_morse_button_signal.toUpperCase(),
                          style: const TextStyle(
                            color: AppColors.black,
                            fontFamily: 'SpaceGrotesk',
                            fontWeight: FontWeight.w700,
                            fontSize: 18.0,
                            letterSpacing: 2.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // Bouton STOP
                Expanded(
                  child: Semantics(
                    label: 'Arrêter la saisie Morse et décoder',
                    button: true,
                    child: NeonButton(
                      label: l10n.converter_morse_button_stop,
                      variant: NeonButtonVariant.secondary,
                      onPressed: provider.stopMorseInput,
                    ),
                  ),
                ),
              ],
            ),

            // Morse accumulé
            MorseOutput(
              label: l10n.converter_morse_result_morse,
              text: [
                provider.allMorse,
                if (provider.currentLetterMorse.isNotEmpty)
                  provider.currentLetterMorse,
              ].where((s) => s.isNotEmpty).join(' '),
              semanticsLabel:
                  'Code Morse composé : ${provider.allMorse} ${provider.currentLetterMorse}',
            ),
          ],

          // Résultat texte décodé
          if (provider.decodedText.isNotEmpty)
            MorseOutput(
              label: l10n.converter_morse_result_text,
              text: provider.decodedText,
              semanticsLabel: 'Texte décodé : ${provider.decodedText}',
            ),
        ],
      ),
    );
  }
}

/// Affichage de la lettre Morse en cours de composition.
class _CurrentLetterDisplay extends StatelessWidget {
  const _CurrentLetterDisplay({required this.provider});
  final ConverterProvider provider;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60.0,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.tertiary, width: 1.0),
        color: AppColors.neutral,
      ),
      alignment: Alignment.center,
      child: Text(
        provider.currentLetterMorse.isEmpty
            ? '·  ·  ·'
            : provider.currentLetterMorse.split('').join('  '),
        style: TextStyle(
          color: provider.currentLetterMorse.isEmpty
              ? AppColors.primary.withValues(alpha: 0.2)
              : AppColors.primary,
          fontFamily: 'SpaceGrotesk',
          fontWeight: FontWeight.w700,
          fontSize: 24.0,
          letterSpacing: 4.0,
        ),
      ),
    );
  }
}
