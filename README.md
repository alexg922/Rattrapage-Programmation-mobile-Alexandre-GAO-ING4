# Rattrapage-Programmation-mobile-Alexandre-GAO-ING4
 
Convertisseur et Jeux Code Morse: Application Flutter de conversion et d'apprentissage du code Morse (gestion des caractères accentués incluse)

Fonctionnalités

- Texte vers Morse : Saisie de texte et conversion au clic sur le bouton.  
- Morse vers Texte : Saisie dynamique du code Morse en fonction de la durée d'appui (GestureDetector / onTapDown et onTapUp).  
- Jeu Morse vers Caractère : Propose un signal aléatoire, réponse via le clavier virtuel. 
- Jeu Caractère vers Morse : Propose un caractère aléatoire, composition du code avec les boutons . et -.

  
UX/UI et Architecture

- Interface : Implémentation fidèle des maquettes Sketch (écrans Convertisseur et Jeux).  
- Design System : Utilisation stricte de la charte graphique fournie (AppColors, AppIcons, AppLocalizations).  
- Ergonomie : Saisie tactile intuitive du Morse via la durée de maintien du bouton et retours visuels immédiats dans les jeux.
- Environnement : Développé sous Flutter 3.44.8 et Dart 3.12.2.  
- Bonus et AccessibilitéVibrations : Émission haptique de la séquence Morse au clic sur Jouer (package vibrate). 
- Accessibilité : Balisage Semantics sur les éléments interactifs pour assurer la compatibilité avec les lecteurs d'écran.


