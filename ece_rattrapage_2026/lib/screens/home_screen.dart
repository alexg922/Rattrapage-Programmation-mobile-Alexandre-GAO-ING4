import 'package:flutter/material.dart';
import 'package:rattrapage/l10n/app_localizations.dart';
import 'package:rattrapage/res/app_colors.dart';
import 'package:rattrapage/res/app_icons.dart';
import 'package:rattrapage/screens/converter_screen.dart';
import 'package:rattrapage/screens/games_screen.dart';
import 'package:rattrapage/widgets/bottom_bar_image.dart';

/// Shell principal de l'application.
/// Contient la BottomNavigationBar (Convertisseur / Jeux)
/// et un IndexedStack pour conserver l'état de chaque page.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    ConverterScreen(),
    GamesScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.black,
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: _buildBottomNav(context, l10n),
    );
  }

  Widget _buildBottomNav(BuildContext context, AppLocalizations l10n) {
    return BottomBarImage(
      child: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.transparent,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.primary.withValues(alpha: 0.35),
        selectedLabelStyle: const TextStyle(
          fontFamily: 'SpaceGrotesk',
          fontWeight: FontWeight.w600,
          fontSize: 12.0,
          letterSpacing: 0.8,
        ),
        unselectedLabelStyle: const TextStyle(
          fontFamily: 'SpaceGrotesk',
          fontWeight: FontWeight.w400,
          fontSize: 12.0,
        ),
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Semantics(
              label: 'Navigation : Convertisseur',
              child: const Icon(AppIcons.convert),
            ),
            label: l10n.tab_converter,
          ),
          BottomNavigationBarItem(
            icon: Semantics(
              label: 'Navigation : Jeux',
              child: const Icon(AppIcons.games),
            ),
            label: l10n.tab_games,
          ),
        ],
      ),
    );
  }
}
