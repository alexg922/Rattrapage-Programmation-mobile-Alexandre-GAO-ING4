import 'vibration_player_stub.dart'
    if (dart.library.html) 'vibration_player_web.dart'
    if (dart.library.io) 'vibration_player_io.dart' as impl;

/// Joue un pattern Morse `[delay, on, off, …]` sans planter (web / desktop / mobile).
Future<void> playMorseVibration(List<int> pattern) {
  return impl.playMorseVibration(pattern);
}
