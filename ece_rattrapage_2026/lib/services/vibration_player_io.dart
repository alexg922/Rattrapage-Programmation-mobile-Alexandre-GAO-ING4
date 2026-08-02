import 'package:vibration/vibration.dart';

/// Vibration native (Android / iOS / desktop avec plugin).
Future<void> playMorseVibration(List<int> pattern) async {
  if (pattern.isEmpty) return;

  final int total =
      pattern.fold<int>(0, (int sum, int ms) => sum + ms);

  try {
    final bool hasVibrator = await Vibration.hasVibrator();
    if (hasVibrator) {
      final bool hasCustom =
          await Vibration.hasCustomVibrationsSupport();
      if (hasCustom) {
        await Vibration.vibrate(pattern: pattern);
      } else {
        // Pas de pattern custom : enchaîne des vibrations courtes.
        // pattern = [delay, on, off, on, off, ...]
        for (int i = 0; i < pattern.length; i++) {
          final int ms = pattern[i];
          if (ms <= 0) continue;
          if (i.isEven) {
            await Future<void>.delayed(Duration(milliseconds: ms));
          } else {
            await Vibration.vibrate(duration: ms);
            await Future<void>.delayed(Duration(milliseconds: ms));
          }
        }
        return;
      }
    }
  } catch (_) {
    // Pas de vibrateur / plugin indisponible : on attend quand même.
  }

  await Future<void>.delayed(Duration(milliseconds: total));
}
