import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider with ChangeNotifier {
  int _precision = 2;

  SettingsProvider() {
    _loadPreferences();
  }

  int get precision => _precision;

  void setPrecision(int value) {
    _precision = value;
    _savePreferences();
    notifyListeners();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _precision = prefs.getInt('precision') ?? 2;
    notifyListeners();
  }

  Future<void> _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('precision', _precision);
  }
}
