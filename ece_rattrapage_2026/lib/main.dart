import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rattrapage/l10n/app_localizations.dart';
import 'package:rattrapage/res/app_colors.dart';
import 'package:rattrapage/screens/home_screen.dart';
import 'package:rattrapage/widgets/phone_frame.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: AppColors.black,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Morse',
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return PhoneFrame(child: child ?? const SizedBox.shrink());
      },
      theme: ThemeData(
        fontFamily: 'SpaceGrotesk',
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          secondary: AppColors.secondary,
          tertiary: AppColors.tertiary,
          brightness: Brightness.dark,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.black,
          foregroundColor: AppColors.primary,
          elevation: 0,
        ),
        dividerTheme: const DividerThemeData(
          color: AppColors.tertiary,
          thickness: 1.0,
        ),
        scaffoldBackgroundColor: AppColors.black,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.black,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: Color(0xFF1A5C0A),
          elevation: 0,
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: InputBorder.none,
          filled: true,
          fillColor: AppColors.black,
          hintStyle: TextStyle(
            color: AppColors.primary.withValues(alpha: 0.3),
          ),
        ),
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('fr'),
      home: const HomeScreen(),
    );
  }
}
