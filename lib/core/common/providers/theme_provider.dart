import 'package:flutter/material.dart';

// 3rd Party Packages
import 'package:shared_preferences/shared_preferences.dart';

/// A class that provides access to the current theme mode and allows
/// changing it persistently using SharedPreferences.
///
/// This class utilizes ChangeNotifier to notify listeners whenever the
/// theme mode changes.
class ThemeProvider with ChangeNotifier {
  /// The current theme mode of the application.
  ThemeMode _themeMode = ThemeMode.system;

  /// The SharedPreferences instance used to store the theme preference.
  final SharedPreferences _prefs;

  /// The key used to store the theme mode in SharedPreferences.
  final String _key = 'theme';

  /// Creates a new instance of ThemeProvider with the provided
  /// SharedPreferences instance.
  ThemeProvider({required SharedPreferences prefs}) : _prefs = prefs {
    _init();
  }

  /// Getter for the current theme mode.
  ThemeMode get themeMode => _themeMode;

  /// Sets the theme mode of the application and persists it to
  /// SharedPreferences.
  ///
  /// Notifies listeners after updating the theme mode.
  Future<void> setThemeMode(ThemeMode value) async {
    _themeMode = value;
    notifyListeners();
    await saveTheme();
  }

  /// Saves the current theme mode to SharedPreferences.
  Future<void> saveTheme() async {
    final themeString = _themeMode == ThemeMode.dark
        ? 'dark'
        : (_themeMode == ThemeMode.light ? 'light' : 'system');
    await _prefs.setString(_key, themeString);
  }

  /// Initializes the theme mode from SharedPreferences on object creation.
  void _init() {
    final themeString = _prefs.getString(_key);
    _themeMode = themeString == 'dark'
        ? ThemeMode.dark
        : (themeString == 'light' ? ThemeMode.light : ThemeMode.system);
    notifyListeners();
  }
}
