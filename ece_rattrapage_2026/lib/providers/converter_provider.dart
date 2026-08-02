import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:rattrapage/services/morse_service.dart';
import 'package:rattrapage/services/vibration_player.dart';

enum ConverterTab { text, morse }

/// Provider gérant l'état de la page Convertisseur.
/// - Onglet TEXTE : convertit un texte saisi en Morse + vibration bonus.
/// - Onglet MORSE : accumule les pressions du bouton CODE pour décoder en texte.
class ConverterProvider extends ChangeNotifier {
  // ─── Tab ───────────────────────────────────────────────
  ConverterTab _tab = ConverterTab.text;
  ConverterTab get tab => _tab;

  void selectTab(ConverterTab t) {
    if (_tab == t) return;
    _tab = t;
    // Réinitialisation au changement d'onglet
    _morseResult = '';
    _textInput = '';
    _isPlaying = false;
    _resetMorseInput();
    notifyListeners();
  }

  // ─── Onglet TEXTE → Morse ──────────────────────────────
  String _textInput = '';
  String get textInput => _textInput;

  String _morseResult = '';
  String get morseResult => _morseResult;

  bool _isPlaying = false;
  bool get isPlaying => _isPlaying;

  void setTextInput(String value) {
    _textInput = value;
    notifyListeners();
  }

  void convertTextToMorse() {
    _morseResult = MorseService.textToMorse(_textInput);
    notifyListeners();
  }

  Future<void> playMorse() async {
    if (_morseResult.isEmpty || _isPlaying) return;
    _isPlaying = true;
    notifyListeners();

    try {
      final List<int> pattern =
          MorseService.morseToVibrationPattern(_morseResult);
      if (pattern.isEmpty) return;
      await playMorseVibration(pattern);
    } catch (_) {
      // Aucune exception ne doit remonter vers l'UI (web / émulateur).
    } finally {
      _isPlaying = false;
      notifyListeners();
    }
  }

  // ─── Onglet MORSE → Texte ──────────────────────────────
  bool _isStarted = false;
  bool get isStarted => _isStarted;

  /// Code Morse composé pour la lettre en cours (ex. ".-")
  String _currentLetterMorse = '';
  String get currentLetterMorse => _currentLetterMorse;

  /// Séquence complète accumulée (ex. "... --- ...")
  String _allMorse = '';
  String get allMorse => _allMorse;

  /// Texte décodé depuis allMorse
  String _decodedText = '';
  String get decodedText => _decodedText;

  DateTime? _tapStartTime;
  Timer? _letterTimer;

  static const int _dotThresholdMs = 300;
  static const int _letterPauseMs = 1500;

  void startMorseInput() {
    _isStarted = true;
    _resetMorseInput();
    notifyListeners();
  }

  void stopMorseInput() {
    _letterTimer?.cancel();
    _isStarted = false;
    // Finaliser la lettre en cours si besoin
    if (_currentLetterMorse.isNotEmpty) {
      _finalizeCurrentLetter();
    }
    _decodeAll();
    notifyListeners();
  }

  void onCodeTapDown() {
    if (!_isStarted) return;
    _letterTimer?.cancel();
    _tapStartTime = DateTime.now();
  }

  void onCodeTapUp() {
    if (!_isStarted || _tapStartTime == null) return;
    final duration = DateTime.now().difference(_tapStartTime!).inMilliseconds;
    _tapStartTime = null;

    if (duration < _dotThresholdMs) {
      _currentLetterMorse += '.';
    } else {
      _currentLetterMorse += '-';
    }

    notifyListeners();

    // Timer : après 1,5 s sans appui, on finalise la lettre
    _letterTimer = Timer(
      const Duration(milliseconds: _letterPauseMs),
      _onLetterTimeout,
    );
  }

  void _onLetterTimeout() {
    if (_currentLetterMorse.isNotEmpty) {
      _finalizeCurrentLetter();
      _decodeAll();
      notifyListeners();
    }
  }

  void _finalizeCurrentLetter() {
    if (_allMorse.isEmpty) {
      _allMorse = _currentLetterMorse;
    } else {
      _allMorse += ' $_currentLetterMorse';
    }
    _currentLetterMorse = '';
  }

  void addWordSpace() {
    if (!_isStarted) return;
    _letterTimer?.cancel();
    if (_currentLetterMorse.isNotEmpty) {
      _finalizeCurrentLetter();
    }
    _allMorse += ' /';
    _decodeAll();
    notifyListeners();
  }

  void _decodeAll() {
    _decodedText = MorseService.morseToText(_allMorse);
  }

  void _resetMorseInput() {
    _letterTimer?.cancel();
    _currentLetterMorse = '';
    _allMorse = '';
    _decodedText = '';
    _tapStartTime = null;
  }

  @override
  void dispose() {
    _letterTimer?.cancel();
    super.dispose();
  }
}
