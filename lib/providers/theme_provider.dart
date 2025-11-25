import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  static const String _themeKey = 'theme_mode';

  ThemeProvider() {
    _loadTheme();
  }

  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode {
    if (_themeMode == ThemeMode.system) {
      // This is a bit tricky without context, but we can default to false or check platform brightness if needed.
      // For simplicity in toggle logic, we'll rely on the explicit mode or assume system follows device.
      // But for the switch state, we might want to know the effective brightness.
      // We'll handle the switch logic in the UI based on the current ThemeMode.
      return false; 
    }
    return _themeMode == ThemeMode.dark;
  }

  void toggleTheme(bool isDark) {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    _saveTheme();
    notifyListeners();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeString = prefs.getString(_themeKey);
    if (themeString == 'dark') {
      _themeMode = ThemeMode.dark;
    } else if (themeString == 'light') {
      _themeMode = ThemeMode.light;
    } else {
      _themeMode = ThemeMode.system;
    }
    notifyListeners();
  }

  Future<void> _saveTheme() async {
    final prefs = await SharedPreferences.getInstance();
    String themeString;
    if (_themeMode == ThemeMode.dark) {
      themeString = 'dark';
    } else if (_themeMode == ThemeMode.light) {
      themeString = 'light';
    } else {
      themeString = 'system';
    }
    await prefs.setString(_themeKey, themeString);
  }
}
