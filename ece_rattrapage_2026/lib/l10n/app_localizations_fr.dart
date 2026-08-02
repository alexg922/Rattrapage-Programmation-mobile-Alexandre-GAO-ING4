// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get app_name => 'MORSE';

  @override
  String get tab_converter => 'Convertisseur';

  @override
  String get tab_games => 'Jeux';

  @override
  String get converter_tab_text => 'Texte';

  @override
  String get converter_tab_morse => 'Morse';

  @override
  String get converter_text_input => 'Votre texte :';

  @override
  String get converter_text_button_convert => 'Convertir';

  @override
  String get converter_text_result => 'En Morse :';

  @override
  String get converter_text_button_haptics => 'Jouer';

  @override
  String get converter_morse_button_start => 'Commencer';

  @override
  String get converter_morse_button_signal => 'Code';

  @override
  String get converter_morse_button_stop => 'Arrêter';

  @override
  String get converter_morse_result_morse => 'En Morse :';

  @override
  String get converter_morse_result_text => 'En texte :';

  @override
  String get game_tab_text => 'Texte';

  @override
  String get game_tab_morse => 'Morse';

  @override
  String get game_text_character => 'Ecrire en morse :';

  @override
  String get game_text_morse_input => 'Votre saisie :';

  @override
  String get game_text_button_validate => 'Valider';

  @override
  String get game_text_button_continue => 'Recommencer';

  @override
  String get game_morse_sentence => 'Ecrire en morse :';

  @override
  String get game_morse_input => 'Votre saisie :';
}
