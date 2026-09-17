import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// User preferences, persisted locally. Nothing here leaves the device.
class AppSettings extends ChangeNotifier {
  AppSettings(this.preferences) {
    final savedLanguage = preferences.getString('language');
    language = languages.contains(savedLanguage) ? savedLanguage! : 'system';
    theme = ThemeMode.values.firstWhere(
      (m) => m.name == preferences.getString('theme'),
      orElse: () => ThemeMode.system,
    );
    final saved = preferences.getString('firstScreen');
    firstScreen = firstScreens.contains(saved) ? saved! : 'home';
  }

  /// The language the app falls back to when the device asks for one it does
  /// not have. English, not Finnish: the generated `supportedLocales` list is
  /// alphabetical, so the fallback has to be named rather than inferred.
  static const fallbackLanguage = 'en';

  /// FP-S01, widened: every shipped translation, or the device's own choice.
  /// Each language is offered under its own name, so a reader who does not
  /// share the current interface language can still find theirs.
  static const languageNames = <String, String>{
    'en': 'English',
    'ca': 'Català',
    'cs': 'Čeština',
    'da': 'Dansk',
    'de': 'Deutsch',
    'es': 'Español',
    'et': 'Eesti',
    'fi': 'Suomi',
    'fr': 'Français',
    'is': 'Íslenska',
    'it': 'Italiano',
    'lt': 'Lietuvių',
    'lv': 'Latviešu',
    'nb': 'Norsk bokmål',
    'nl': 'Nederlands',
    'pl': 'Polski',
    'pt': 'Português',
    'ro': 'Română',
    'sl': 'Slovenščina',
    'sv': 'Svenska',
    'tr': 'Türkçe',
    'uk': 'Українська',
  };

  /// `system` plus every key of [languageNames], in that order.
  static final List<String> languages = ['system', ...languageNames.keys];
  static const firstScreens = ['home', 'weeks', 'calendar', 'tools'];

  final SharedPreferences preferences;
  late String language;
  late ThemeMode theme;
  late String firstScreen;

  /// Null hands the choice back to the device, which the app resolves against
  /// its own supported list, falling back to English.
  Locale? get locale => language == 'system' ? null : Locale(language);

  Future<void> setLanguage(String value) async {
    await preferences.setString('language', value);
    language = value;
    notifyListeners();
  }

  Future<void> setTheme(ThemeMode value) async {
    await preferences.setString('theme', value.name);
    theme = value;
    notifyListeners();
  }

  Future<void> setFirstScreen(String value) async {
    await preferences.setString('firstScreen', value);
    firstScreen = value;
    notifyListeners();
  }

  String note(int year, int week) =>
      preferences.getString('note_${year}_$week') ?? '';
  Future<void> saveNote(int year, int week, String value) =>
      preferences.setString('note_${year}_$week', value);
}
