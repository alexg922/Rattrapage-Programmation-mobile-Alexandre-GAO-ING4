import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:rattrapage/models/morse_code.dart';

enum GameTab { charToMorse, morseToChar }

/// Provider gérant l'état de la page Jeux.
///
/// - Onglet TEXTE (Caractère → Morse) :
///   Affiche un caractère, l'utilisateur compose le Morse avec les boutons . et -
///   puis valide.
///
/// - Onglet MORSE (Morse → Caractère) :
///   Affiche un code Morse, l'utilisateur saisit le caractère ; résultat auto.
class GameProvider extends ChangeNotifier {
  final Random _random = Random();

  // ─── Tab ───────────────────────────────────────────────
  GameTab _tab = GameTab.charToMorse;
  GameTab get tab => _tab;

  void selectTab(GameTab t) {
    if (_tab == t) return;
    _tab = t;
    _resetCharToMorse();
    _resetMorseToChar();
    notifyListeners();
  }

  // ─── Jeu Caractère → Morse ─────────────────────────────
  String _currentChar = '';
  String get currentChar => _currentChar;

  String _userMorse = '';
  String get userMorse => _userMorse;

  /// null = pas encore validé | true = correct | false = incorrect
  bool? _charValidationResult;
  bool? get charValidationResult => _charValidationResult;

  String get expectedMorse => MorseCode.charToMorse[_currentChar] ?? '';

  void startCharToMorseGame() {
    _resetCharToMorse();
    _pickRandomChar();
    notifyListeners();
  }

  void addDot() {
    if (_charValidationResult != null) return;
    _userMorse += '.';
    notifyListeners();
  }

  void addDash() {
    if (_charValidationResult != null) return;
    _userMorse += '-';
    notifyListeners();
  }

  void deleteLastSymbol() {
    if (_charValidationResult != null || _userMorse.isEmpty) return;
    _userMorse = _userMorse.substring(0, _userMorse.length - 1);
    notifyListeners();
  }

  void validateCharToMorse() {
    if (_userMorse.isEmpty) return;
    _charValidationResult = _userMorse == expectedMorse;
    notifyListeners();
  }

  void restartCharToMorse() {
    _resetCharToMorse();
    _pickRandomChar();
    notifyListeners();
  }

  void _resetCharToMorse() {
    _userMorse = '';
    _charValidationResult = null;
  }

  void _pickRandomChar() {
    final chars = MorseCode.gameCharacters;
    if (chars.isEmpty) return;
    _currentChar = chars[_random.nextInt(chars.length)];
  }

  // ─── Jeu Morse → Caractère ─────────────────────────────
  String _currentMorse = '';
  String get currentMorse => _currentMorse;

  String _morseUserInput = '';
  String get morseUserInput => _morseUserInput;

  /// null = pas encore saisi | true = correct | false = incorrect
  bool? _morseValidationResult;
  bool? get morseValidationResult => _morseValidationResult;

  String get expectedChar =>
      MorseCode.morseToChar[_currentMorse] ?? '?';

  void startMorseToCharGame() {
    _resetMorseToChar();
    _pickRandomMorse();
    notifyListeners();
  }

  void setMorseUserInput(String value) {
    _morseUserInput = value.toUpperCase();
    if (_morseUserInput.isNotEmpty) {
      // Résultat automatique
      _morseValidationResult =
          _morseUserInput.trim() == expectedChar;
    } else {
      _morseValidationResult = null;
    }
    notifyListeners();
  }

  void restartMorseToChar() {
    _resetMorseToChar();
    _pickRandomMorse();
    notifyListeners();
  }

  void _resetMorseToChar() {
    _morseUserInput = '';
    _morseValidationResult = null;
  }

  void _pickRandomMorse() {
    final chars = MorseCode.gameCharacters;
    if (chars.isEmpty) return;
    final char = chars[_random.nextInt(chars.length)];
    _currentMorse = MorseCode.charToMorse[char] ?? '';
  }
}
