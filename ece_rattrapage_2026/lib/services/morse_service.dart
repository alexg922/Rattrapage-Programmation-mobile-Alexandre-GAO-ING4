import 'package:rattrapage/models/morse_code.dart';

/// Service de conversion Texte ↔ Morse.
/// Fournit aussi les fonctions utilitaires pour le jeu et la vibration.
class MorseService {
  const MorseService._();

  /// Convertit un texte en code Morse.
  /// Les lettres d'un même mot sont séparées par un espace.
  /// Les mots sont séparés par " / ".
  static String textToMorse(String text) {
    if (text.trim().isEmpty) return '';

    return text
        .toUpperCase()
        .split('')
        .map((char) {
          final code = MorseCode.charToMorse[char];
          if (code == null) return '';
          return code;
        })
        .where((c) => c.isNotEmpty)
        .join(' ');
  }

  /// Convertit un code Morse en texte.
  /// Les lettres sont séparées par des espaces, les mots par " / ".
  static String morseToText(String morse) {
    if (morse.trim().isEmpty) return '';

    final words = morse.trim().split(' / ');
    return words.map((word) {
      final letters = word.trim().split(' ');
      return letters.map((letter) {
        return MorseCode.morseToChar[letter.trim()] ?? '?';
      }).join('');
    }).join(' ');
  }

  /// Pattern vibration au format Android / `vibration` package :
  /// `[delay, vibrate, pause, vibrate, …]` (commence par un délai, souvent 0).
  ///
  /// Unités (sujet) : `.` = 1, `-` = 3, `/` = 7 ; pause inter-symboles = 1.
  static List<int> morseToVibrationPattern(String morse) {
    const int unit = 100;
    const int dot = unit;
    const int dash = unit * 3;
    const int symbolGap = unit;
    const int letterGap = unit * 3;
    const int wordGap = unit * 7;

    // Alternance ON/OFF sans délai initial (ajouté ensuite).
    final onOff = <int>[];

    final parts = morse.trim().split(' ');
    for (int i = 0; i < parts.length; i++) {
      final part = parts[i];
      if (part == '/') {
        if (onOff.isNotEmpty && onOff.length.isOdd) {
          // Remplace la dernière pause (lettre) par une pause mot
          onOff[onOff.length - 1] = wordGap;
        } else if (onOff.isNotEmpty) {
          onOff.add(wordGap);
        }
        continue;
      }

      for (int j = 0; j < part.length; j++) {
        final symbol = part[j];
        if (symbol == '.') {
          onOff.add(dot);
        } else if (symbol == '-') {
          onOff.add(dash);
        } else {
          continue;
        }
        if (j < part.length - 1) {
          onOff.add(symbolGap);
        }
      }

      if (i < parts.length - 1 && parts[i + 1] != '/') {
        onOff.add(letterGap);
      } else if (i < parts.length - 1 && parts[i + 1] == '/') {
        onOff.add(wordGap);
      }
    }

    if (onOff.isEmpty) return <int>[];

    // Format package : [delay, on, off, on, off, ...]
    return <int>[0, ...onOff];
  }

  /// Durée totale du pattern en ms.
  static int patternDurationMs(List<int> pattern) {
    return pattern.fold<int>(0, (int sum, int ms) => sum + ms);
  }
}
