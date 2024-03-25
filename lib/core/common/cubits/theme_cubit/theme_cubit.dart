import 'package:flutter/material.dart';

// 3rd Party Packages
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Project Files
part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final SharedPreferences prefs;

  ThemeCubit(this.prefs) : super(const ThemeState()) {
    _loadTheme();
  }

  void setThemeMode(ThemeMode mode) async {
    final themeString = mode == ThemeMode.dark
        ? 'dark'
        : (mode == ThemeMode.light ? 'light' : 'system');
    await prefs.setString('theme', themeString);
    emit(ThemeState(themeMode: mode));
  }

  Future<void> _loadTheme() async {
    final themeString = prefs.getString('theme');
    final themeMode = themeString == 'dark'
        ? ThemeMode.dark
        : (themeString == 'light' ? ThemeMode.light : ThemeMode.system);
    emit(ThemeState(themeMode: themeMode));
  }
}
