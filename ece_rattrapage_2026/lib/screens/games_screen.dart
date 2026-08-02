import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rattrapage/l10n/app_localizations.dart';
import 'package:rattrapage/pages/widgets/app_bar.dart';
import 'package:rattrapage/providers/game_provider.dart';
import 'package:rattrapage/res/app_colors.dart';
import 'package:rattrapage/res/app_icons.dart';
import 'package:rattrapage/widgets/mode_tabs.dart';
import 'package:rattrapage/widgets/neon_button.dart';
import 'package:rattrapage/widgets/morse_shape_display.dart';

/// Page Jeux — onglets TEXTE (Caractère → Morse) et MORSE (Morse → Caractère).
class GamesScreen extends StatelessWidget {
  const GamesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return ChangeNotifierProvider<GameProvider>(
      create: (_) => GameProvider()..startCharToMorseGame(),
      child: Consumer<GameProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            backgroundColor: AppColors.black,
            appBar: CustomAppBar(
              title: l10n.app_name,
              showBack: false,
            ),
            body: Column(
              children: <Widget>[
                // ── Sélecteur d'onglets ──────────────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(17.0, 16.0, 17.0, 0.0),
                  child: ModeTabs(
                    tabs: [
                      l10n.game_tab_text,
                      l10n.game_tab_morse,
                    ],
                    semanticsLabels: [
                      'Jeu : voir un caractère et saisir son code Morse',
                      'Jeu : voir un code Morse et saisir le caractère',
                    ],
                    selectedIndex:
                        provider.tab == GameTab.charToMorse ? 0 : 1,
                    onTabSelected: (i) {
                      final tab =
                          i == 0 ? GameTab.charToMorse : GameTab.morseToChar;
                      provider.selectTab(tab);
                      if (tab == GameTab.charToMorse) {
                        provider.startCharToMorseGame();
                      } else {
                        provider.startMorseToCharGame();
                      }
                    },
                  ),
                ),
                const SizedBox(height: 8.0),
                const Divider(height: 1.0, color: AppColors.tertiary),
                const SizedBox(height: 8.0),
                // ── Contenu ──────────────────────────────────
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    child: provider.tab == GameTab.charToMorse
                        ? _CharToMorseGame(
                            key: const ValueKey('charToMorse'),
                            provider: provider,
                            l10n: l10n,
                          )
                        : _MorseToCharGame(
                            key: const ValueKey('morseToChar'),
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
// Jeu Caractère → Morse
// ─────────────────────────────────────────────────────────────
class _CharToMorseGame extends StatelessWidget {
  const _CharToMorseGame({
    super.key,
    required this.provider,
    required this.l10n,
  });

  final GameProvider provider;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final isValidated = provider.charValidationResult != null;
    final isSuccess = provider.charValidationResult == true;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(17.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16.0,
        children: <Widget>[
          // Label
          Text(
            l10n.game_text_character.toUpperCase(),
            style: const TextStyle(
              color: AppColors.primary,
              fontFamily: 'SpaceGrotesk',
              fontWeight: FontWeight.w500,
              fontSize: 13.0,
              letterSpacing: 1.2,
            ),
          ),

          // Grand caractère à convertir
          Semantics(
            label:
                'Caractère à convertir en Morse : ${provider.currentChar}',
            child: Container(
              width: double.infinity,
              height: 150.0,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primary, width: 1.5),
                color: AppColors.black,
              ),
              alignment: Alignment.center,
              child: Text(
                provider.currentChar,
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'SpaceGrotesk',
                  fontWeight: FontWeight.w700,
                  fontSize: 96.0,
                ),
              ),
            ),
          ),

          // Zone saisie Morse (lecture seule, mis à jour par les boutons)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8.0,
            children: <Widget>[
              Text(
                l10n.game_text_morse_input.toUpperCase(),
                style: const TextStyle(
                  color: AppColors.primary,
                  fontFamily: 'SpaceGrotesk',
                  fontWeight: FontWeight.w500,
                  fontSize: 13.0,
                  letterSpacing: 1.2,
                ),
              ),
              Semantics(
                label: 'Votre saisie Morse : ${provider.userMorse}',
                readOnly: true,
                child: Container(
                  width: double.infinity,
                  height: 54.0,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.primary, width: 1.0),
                    color: AppColors.black,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    provider.userMorse.isEmpty
                        ? '…'
                        : provider.userMorse.split('').join('  '),
                    style: TextStyle(
                      color: provider.userMorse.isEmpty
                          ? AppColors.primary.withValues(alpha: 0.3)
                          : AppColors.primary,
                      fontFamily: 'SpaceGrotesk',
                      fontWeight: FontWeight.w700,
                      fontSize: 24.0,
                      letterSpacing: 4.0,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Boutons . et - (désactivés après validation)
          Row(
            spacing: 12.0,
            children: <Widget>[
              Expanded(
                child: Semantics(
                  label: 'Ajouter un point',
                  button: true,
                  child: NeonButton(
                    label: '·',
                    height: 53.0,
                    enabled: !isValidated,
                    onPressed: provider.addDot,
                  ),
                ),
              ),
              Expanded(
                child: Semantics(
                  label: 'Ajouter un tiret',
                  button: true,
                  child: NeonButton(
                    label: '—',
                    height: 53.0,
                    enabled: !isValidated,
                    onPressed: provider.addDash,
                  ),
                ),
              ),
              // Supprimer le dernier symbole
              Semantics(
                label: 'Supprimer le dernier symbole',
                button: true,
                child: NeonButton(
                  label: '⌫',
                  width: 60.0,
                  height: 53.0,
                  enabled: !isValidated && provider.userMorse.isNotEmpty,
                  onPressed: provider.deleteLastSymbol,
                ),
              ),
            ],
          ),

          NeonButton(
            label: l10n.game_text_button_validate,
            semanticsLabel: 'Valider ma réponse Morse',
            variant: NeonButtonVariant.secondary,
            enabled: provider.userMorse.isNotEmpty && !isValidated,
            onPressed: provider.validateCharToMorse,
          ),

          // Icône résultat
          if (isValidated) ...[
            Semantics(
              label: isSuccess
                  ? 'Bonne réponse !'
                  : 'Mauvaise réponse. La bonne réponse était ${provider.expectedMorse}',
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 16.0,
                children: <Widget>[
                  Container(
                    width: 80.0,
                    height: 80.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 6.0),
                    ),
                    child: Icon(
                      isSuccess ? AppIcons.success : AppIcons.error,
                      color: Colors.white,
                      size: 60.0,
                    ),
                  ),
                  if (!isSuccess)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Bonne réponse :',
                          style: TextStyle(
                            color:
                                AppColors.primary.withValues(alpha: 0.6),
                            fontFamily: 'SpaceGrotesk',
                            fontSize: 12.0,
                          ),
                        ),
                        Text(
                          provider.expectedMorse
                              .split('')
                              .join('  '),
                          style: const TextStyle(
                            color: AppColors.secondary,
                            fontFamily: 'SpaceGrotesk',
                            fontWeight: FontWeight.w700,
                            fontSize: 22.0,
                            letterSpacing: 4.0,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],

          // Bouton Recommencer
          NeonButton(
            label: l10n.game_text_button_continue,
            semanticsLabel: 'Recommencer avec un nouveau caractère',
            variant: NeonButtonVariant.secondary,
            onPressed: provider.restartCharToMorse,
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Jeu Morse → Caractère
// ─────────────────────────────────────────────────────────────
class _MorseToCharGame extends StatefulWidget {
  const _MorseToCharGame({
    super.key,
    required this.provider,
    required this.l10n,
  });

  final GameProvider provider;
  final AppLocalizations l10n;

  @override
  State<_MorseToCharGame> createState() => _MorseToCharGameState();
}

class _MorseToCharGameState extends State<_MorseToCharGame> {
  final TextEditingController _inputController = TextEditingController();

  @override
  void didUpdateWidget(_MorseToCharGame oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Réinitialise le champ lors d'un nouveau jeu
    if (widget.provider.morseUserInput.isEmpty &&
        _inputController.text.isNotEmpty) {
      _inputController.clear();
    }
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = widget.provider;
    final l10n = widget.l10n;
    final result = provider.morseValidationResult;
    final isSuccess = result == true;
    final isError = result == false;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(17.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16.0,
        children: <Widget>[
          // Label
          Text(
            l10n.game_morse_sentence.toUpperCase(),
            style: const TextStyle(
              color: AppColors.primary,
              fontFamily: 'SpaceGrotesk',
              fontWeight: FontWeight.w500,
              fontSize: 13.0,
              letterSpacing: 1.2,
            ),
          ),

          // Grand signal Morse affiché
          Semantics(
            label: 'Code Morse à identifier : ${provider.currentMorse}',
            child: Container(
              width: double.infinity,
              constraints: const BoxConstraints(minHeight: 100.0),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primary, width: 1.5),
                color: AppColors.black,
              ),
              padding: const EdgeInsets.symmetric(
                  horizontal: 16.0, vertical: 24.0),
              alignment: Alignment.center,
              child: MorseShapeDisplay(morseCode: provider.currentMorse),
            ),
          ),

          // Champ de saisie du caractère (clavier)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8.0,
            children: <Widget>[
              Text(
                l10n.game_morse_input.toUpperCase(),
                style: const TextStyle(
                  color: AppColors.primary,
                  fontFamily: 'SpaceGrotesk',
                  fontWeight: FontWeight.w500,
                  fontSize: 13.0,
                  letterSpacing: 1.2,
                ),
              ),
              Semantics(
                label:
                    'Champ de saisie : tapez le caractère correspondant au code Morse affiché',
                textField: true,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: result == null
                          ? AppColors.primary
                          : isSuccess
                              ? AppColors.primary
                              : Colors.redAccent,
                      width: 1.5,
                    ),
                    color: AppColors.black,
                  ),
                  child: TextField(
                    controller: _inputController,
                    autofocus: true,
                    maxLength: 1,
                    textCapitalization: TextCapitalization.characters,
                    onChanged: (val) {
                      provider.setMorseUserInput(val);
                    },
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontFamily: 'SpaceGrotesk',
                      fontWeight: FontWeight.w700,
                      fontSize: 32.0,
                    ),
                    decoration: InputDecoration(
                      hintText: '?',
                      hintStyle: TextStyle(
                        color: AppColors.primary.withValues(alpha: 0.3),
                        fontSize: 32.0,
                      ),
                      contentPadding: const EdgeInsets.all(12.0),
                      border: InputBorder.none,
                      counterText: '',
                    ),
                    cursorColor: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),

          // Résultat automatique (icône succès / erreur)
          if (result != null)
            Semantics(
              label: isSuccess
                  ? 'Bonne réponse !'
                  : 'Mauvaise réponse. Le bon caractère était ${provider.expectedChar}',
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 16.0,
                children: <Widget>[
                  Container(
                    width: 80.0,
                    height: 80.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 6.0),
                    ),
                    child: Icon(
                      isSuccess ? AppIcons.success : AppIcons.error,
                      color: Colors.white,
                      size: 60.0,
                    ),
                  ),
                  if (isError)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Bonne réponse :',
                          style: TextStyle(
                            color:
                                AppColors.primary.withValues(alpha: 0.6),
                            fontFamily: 'SpaceGrotesk',
                            fontSize: 12.0,
                          ),
                        ),
                        Text(
                          provider.expectedChar,
                          style: const TextStyle(
                            color: AppColors.secondary,
                            fontFamily: 'SpaceGrotesk',
                            fontWeight: FontWeight.w700,
                            fontSize: 48.0,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),

          // Bouton Recommencer
          NeonButton(
            label: l10n.game_text_button_continue,
            semanticsLabel: 'Recommencer avec un nouveau code Morse',
            variant: NeonButtonVariant.secondary,
            onPressed: () {
              _inputController.clear();
              provider.restartMorseToChar();
            },
          ),
        ],
      ),
    );
  }
}
