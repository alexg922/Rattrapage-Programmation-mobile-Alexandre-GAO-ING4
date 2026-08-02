# Application Morse — Rattrapage Programmation Mobile

## Description

Application Flutter de conversion de texte vers et à partir du code Morse.
Développée avec Flutter 3.44.8 / Dart 3.12.2.

## Fonctionnalités

### Page Convertisseur

#### Onglet Texte → Morse
- Saisie d'un texte libre
- Bouton **Convertir** → affiche le code Morse correspondant
- Support des caractères accentués français (É, È, À, Ç, Ü, Ë, Â)
- **Bonus** : Bouton **Jouer** → reproduit le code Morse par vibrations (package `vibration`)

#### Onglet Morse → Texte
- Bouton **Commencer** pour activer la saisie
- Bouton **Code** (`GestureDetector` avec `onTapDown` / `onTapUp`) :
  - Durée < 300 ms → point `.`
  - Durée ≥ 300 ms → tiret `-`
- Timer automatique : après 1,5 s sans appui, la lettre est finalisée
- Bouton **Espace** pour séparer les mots
- Affichage du code Morse composé et du texte décodé en temps réel
- Bouton **Arrêter** pour finir la saisie

### Page Jeux

#### Onglet Texte (Caractère → Morse)
- Affiche un caractère aléatoire (A–Z, 0–9, accents français)
- Boutons `.` et `-` pour composer le code Morse
- Bouton `⌫` pour effacer le dernier symbole
- Bouton **Valider** → icône ✓ (succès) ou ✗ (erreur) avec affichage de la bonne réponse
- Bouton **Recommencer** pour un nouveau tirage

#### Onglet Morse (Morse → Caractère)
- Affiche un code Morse aléatoire
- Saisie du caractère correspondant au clavier
- Le résultat (succès/erreur) apparaît automatiquement dès la saisie
- Bouton **Recommencer** pour un nouveau tirage

### Page Symboles
- Accessible via l'icône terminal dans l'AppBar de la page Convertisseur
- Liste complète de la table Morse : lettres, chiffres, accents, ponctuation

---

## Accessibilité

Toutes les modifications d'accessibilité sont listées ci-dessous, conformément aux critères WCAG 2.1 niveau AA.

### 1. Étiquettes sémantiques (`Semantics`)

Chaque widget interactif est enveloppé dans un widget `Semantics` avec :
- `label` : description vocale précise de l'élément
- `button: true` : annonce le rôle du widget aux technologies d'assistance
- `enabled` : état activé/désactivé communiqué aux lecteurs d'écran
- `readOnly` / `textField` : rôle des champs de texte

**Exemples :**
```dart
Semantics(
  label: 'Bouton Code : appui court = point, appui long = tiret',
  button: true,
  child: GestureDetector(...)
)
```

### 2. Étiquettes sur les BottomNavigationBar items

Chaque `BottomNavigationBarItem` encapsule son icône dans un `Semantics` avec un label descriptif :
- `'Navigation : Convertisseur'`
- `'Navigation : Jeux'`

### 3. Étiquettes sur les ModeTabs

Le composant `ModeTabs` accepte un paramètre `semanticsLabels` distinct du texte affiché, permettant des descriptions plus explicites :
- `'Onglet conversion Texte vers Morse'`
- `'Onglet conversion Morse vers Texte'`

### 4. MorseInputField et MorseOutput

- `MorseInputField` expose `semanticsLabel` pour les lecteurs d'écran
- `MorseOutput` concatène le label et le contenu dans l'annonce vocale

### 5. NeonButton

- Expose `semanticsLabel` distinct du texte visuel (en majuscules) pour une lecture plus naturelle
- Communique l'état `enabled` via `Semantics`

### 6. Affichage des résultats de jeu

Les icônes de succès/erreur sont entourées de `Semantics` avec des labels complets :
- `'Bonne réponse !'`
- `'Mauvaise réponse. La bonne réponse était .-'`

### 7. Contraste des couleurs

- Fond : `#000000` (noir)
- Couleur principale : `#39FF14` (vert néon) — ratio de contraste ≈ 15:1 (dépasse AA et AAA)
- Texte désactivé : `#39FF14` à 30% d'opacité — indicateur visuel complémentaire à l'état `enabled`

### 8. Taille des cibles tactiles

Tous les boutons ont une hauteur minimum de 53 px et une largeur minimum de 60 px, dépassant les recommandations Material Design (48 px minimum).

### 9. Locale forcée

La locale est forcée à `fr` dans `MaterialApp`, garantissant que les textes système (boutons de dialogue, etc.) s'affichent en français pour les utilisateurs francophones.

---

## Architecture

```
lib/
├── main.dart
├── models/
│   └── morse_code.dart       Table Morse complète
├── services/
│   └── morse_service.dart    Logique de conversion + vibrations
├── providers/
│   ├── converter_provider.dart
│   └── game_provider.dart
├── screens/
│   ├── home_screen.dart      Shell + BottomNavigationBar
│   ├── converter_screen.dart
│   ├── games_screen.dart
│   └── symbols_screen.dart
├── widgets/
│   ├── neon_button.dart
│   ├── mode_tabs.dart
│   ├── morse_input.dart
│   └── morse_output.dart
├── pages/
│   ├── homepage.dart         (compatibilité)
│   └── widgets/
│       └── app_bar.dart
├── res/
│   ├── app_colors.dart
│   └── app_icons.dart
└── l10n/
    ├── app_fr.arb
    ├── app_localizations.dart
    └── app_localizations_fr.dart
```

## Dépendances utilisées

| Package | Version | Usage |
|---|---|---|
| `provider` | 6.1.5+1 | Gestion d'état |
| `vibration` | 3.2.0 | Vibrations Morse (bonus) |
| `flutter_localizations` | sdk | Internationalisation |
| `intl` | any | Formatage des chaînes |
