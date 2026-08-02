import 'dart:js_interop';

/// Binding minimal vers `navigator.vibrate`.
@JS('navigator.vibrate')
external bool? _vibrate(JSAny? pattern);

/// Vibration navigateur via `navigator.vibrate` (Chrome Android, etc.).
Future<void> playMorseVibration(List<int> pattern) async {
  if (pattern.isEmpty) return;

  final int total =
      pattern.fold<int>(0, (int sum, int ms) => sum + ms);

  try {
    final JSArray<JSNumber> jsPattern =
        JSArray<JSNumber>.withLength(pattern.length);
    for (int i = 0; i < pattern.length; i++) {
      jsPattern[i] = pattern[i].toJS;
    }
    _vibrate(jsPattern);
  } catch (_) {
    // Desktop souvent sans vibrateur : silencieux, pas d'erreur UI.
  }

  await Future<void>.delayed(Duration(milliseconds: total));
}
