import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('fr')];

  /// No description provided for @app_name.
  ///
  /// In fr, this message translates to:
  /// **'MORSE'**
  String get app_name;

  /// No description provided for @tab_converter.
  ///
  /// In fr, this message translates to:
  /// **'Convertisseur'**
  String get tab_converter;

  /// No description provided for @tab_games.
  ///
  /// In fr, this message translates to:
  /// **'Jeux'**
  String get tab_games;

  /// No description provided for @converter_tab_text.
  ///
  /// In fr, this message translates to:
  /// **'Texte'**
  String get converter_tab_text;

  /// No description provided for @converter_tab_morse.
  ///
  /// In fr, this message translates to:
  /// **'Morse'**
  String get converter_tab_morse;

  /// No description provided for @converter_text_input.
  ///
  /// In fr, this message translates to:
  /// **'Votre texte :'**
  String get converter_text_input;

  /// No description provided for @converter_text_button_convert.
  ///
  /// In fr, this message translates to:
  /// **'Convertir'**
  String get converter_text_button_convert;

  /// No description provided for @converter_text_result.
  ///
  /// In fr, this message translates to:
  /// **'En Morse :'**
  String get converter_text_result;

  /// No description provided for @converter_text_button_haptics.
  ///
  /// In fr, this message translates to:
  /// **'Jouer'**
  String get converter_text_button_haptics;

  /// No description provided for @converter_morse_button_start.
  ///
  /// In fr, this message translates to:
  /// **'Commencer'**
  String get converter_morse_button_start;

  /// No description provided for @converter_morse_button_signal.
  ///
  /// In fr, this message translates to:
  /// **'Code'**
  String get converter_morse_button_signal;

  /// No description provided for @converter_morse_button_stop.
  ///
  /// In fr, this message translates to:
  /// **'Arrêter'**
  String get converter_morse_button_stop;

  /// No description provided for @converter_morse_result_morse.
  ///
  /// In fr, this message translates to:
  /// **'En Morse :'**
  String get converter_morse_result_morse;

  /// No description provided for @converter_morse_result_text.
  ///
  /// In fr, this message translates to:
  /// **'En texte :'**
  String get converter_morse_result_text;

  /// No description provided for @game_tab_text.
  ///
  /// In fr, this message translates to:
  /// **'Texte'**
  String get game_tab_text;

  /// No description provided for @game_tab_morse.
  ///
  /// In fr, this message translates to:
  /// **'Morse'**
  String get game_tab_morse;

  /// No description provided for @game_text_character.
  ///
  /// In fr, this message translates to:
  /// **'Ecrire en morse :'**
  String get game_text_character;

  /// No description provided for @game_text_morse_input.
  ///
  /// In fr, this message translates to:
  /// **'Votre saisie :'**
  String get game_text_morse_input;

  /// No description provided for @game_text_button_validate.
  ///
  /// In fr, this message translates to:
  /// **'Valider'**
  String get game_text_button_validate;

  /// No description provided for @game_text_button_continue.
  ///
  /// In fr, this message translates to:
  /// **'Recommencer'**
  String get game_text_button_continue;

  /// No description provided for @game_morse_sentence.
  ///
  /// In fr, this message translates to:
  /// **'Ecrire en morse :'**
  String get game_morse_sentence;

  /// No description provided for @game_morse_input.
  ///
  /// In fr, this message translates to:
  /// **'Votre saisie :'**
  String get game_morse_input;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
