/// Stub — aucune vibration (plateforme inconnue).
Future<void> playMorseVibration(List<int> pattern) async {
  final int total =
      pattern.fold<int>(0, (int sum, int ms) => sum + ms);
  if (total > 0) {
    await Future<void>.delayed(Duration(milliseconds: total));
  }
}
