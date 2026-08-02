/// Table de correspondance Morse complète.
/// Inclut les lettres A–Z, chiffres 0–9,
/// caractères étendus internationaux et ponctuation.
class MorseCode {
  const MorseCode._();

  static const Map<String, String> charToMorse = {
    // Lettres
    'A': '.-',
    'B': '-...',
    'C': '-.-.',
    'D': '-..',
    'E': '.',
    'F': '..-.',
    'G': '--.',
    'H': '....',
    'I': '..',
    'J': '.---',
    'K': '-.-',
    'L': '.-..',
    'M': '--',
    'N': '-.',
    'O': '---',
    'P': '.--.',
    'Q': '--.-',
    'R': '.-.',
    'S': '...',
    'T': '-',
    'U': '..-',
    'V': '...-',
    'W': '.--',
    'X': '-..-',
    'Y': '-.--',
    'Z': '--..',
    // Chiffres
    '0': '-----',
    '1': '.----',
    '2': '..---',
    '3': '...--',
    '4': '....-',
    '5': '.....',
    '6': '-....',
    '7': '--...',
    '8': '---..',
    '9': '----.',
    // Ponctuation et Caractères Spéciaux
    '_': '..--.-',
    '-': '-....-',
    ',': '--..--',
    ';': '-.-.-.',
    ':': '---...',
    '!': '-.-.--',
    '¡': '--...-',
    '?': '..--..',
    '¿': '..-.-',
    '.': '.-.-.-',
    "'": '.----.',
    '"': '.-..-.',
    '(': '-.--.',
    ')': '-.--.-',
    '@': '.--.-.',
    '/': '-..-.',
    '&': '.-...',
    '+': '.-.-.',
    '=': '-...-',
    '\$': '...-..-',
    // Caractères Étendus Internationaux
    'Å': '.--.-',
    'Ä': '.-.-',
    'É': '..-..',
    'Ñ': '--.--',
    'Ó': '---.',
    'Ö': '---.-',
    'Ú': '..--',
    // Espace
    ' ': '/',
  };

  /// Table inverse : code Morse → caractère.
  /// En cas de doublon (ex. Å), le premier itéré (souvent Z ou autre) peut primer
  /// Mais l'idéal est de prioriser les caractères standard si possible.
  /// Le Map Dart respecte l'ordre d'insertion, donc les lettres A-Z seront prioritaires
  /// sur les caractères étendus si jamais il y a collision.
  static final Map<String, String> morseToChar = () {
    final map = <String, String>{};
    for (final entry in charToMorse.entries) {
      if (entry.value != '/' && !map.containsKey(entry.value)) {
        map[entry.value] = entry.key;
      }
    }
    return map;
  }();

  /// Ensemble de caractères utilisables dans les jeux (codes uniques).
  static final List<String> gameCharacters = () {
    final seen = <String>{};
    final result = <String>[];
    for (final entry in charToMorse.entries) {
      if (entry.value == '/') continue;
      if (seen.contains(entry.value)) continue;
      // N'inclure que les lettres, chiffres et accents (pas la ponctuation)
      // On autorise A-Z, 0-9 et les caractères étendus définis
      if (entry.key.length == 1 &&
          RegExp(r'^[A-Z0-9ÅÄÉÑÓÖÚ]$').hasMatch(entry.key)) {
        seen.add(entry.value);
        result.add(entry.key);
      }
    }
    return result;
  }();
}
