import 'package:flutter/material.dart';
import 'package:rattrapage/screens/home_screen.dart';

/// Point d'entrée de navigation — redirige vers HomeScreen.
/// Conservé pour la compatibilité avec les imports existants.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeScreen();
  }
}
