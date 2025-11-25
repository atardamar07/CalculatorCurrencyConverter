import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/ad_service.dart';

class CalculatorProvider with ChangeNotifier {
  String _expression = '';
  String _result = '0';
  final AdService _adService = AdService();
  int _clearCount = 0; // Track clear button presses
  static const int _adFrequency = 5; // Show ad every 5 clears

  CalculatorProvider() {
    _adService.createInterstitialAd();
    _loadClearCount(); // Load saved count on startup
  }

  String get expression => _expression;
  String get result => _result;

  // Load clear count from SharedPreferences
  Future<void> _loadClearCount() async {
    final prefs = await SharedPreferences.getInstance();
    _clearCount = prefs.getInt('clear_count') ?? 0;
    notifyListeners();
  }

  // Save clear count to SharedPreferences
  Future<void> _saveClearCount() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('clear_count', _clearCount);
  }

  void addToExpression(String value) {
    _expression += value;
    notifyListeners();
  }

  void clear() {
    _expression = '';
    _result = '0';
    notifyListeners();
    
    // Smart ad display: only show every N clears
    _clearCount++;
    _saveClearCount(); // Save after increment
    
    if (_clearCount >= _adFrequency) {
      _adService.showInterstitialAd();
      _clearCount = 0; // Reset counter
      _saveClearCount(); // Save reset
    }
  }

  void delete() {
    if (_expression.isNotEmpty) {
      _expression = _expression.substring(0, _expression.length - 1);
      notifyListeners();
    }
  }

  void evaluate() {
    try {
      // Use new GrammarParser instead of deprecated Parser
      GrammarParser p = GrammarParser();
      // Replace visual symbols with math operators if needed (e.g., '×' to '*', '÷' to '/')
      String finalExpression = _expression
          .replaceAll('×', '*')
          .replaceAll('÷', '/')
          .replaceAll('π', '3.1415926535897932');
      
      Expression exp = p.parse(finalExpression);
      // Use new RealEvaluator instead of deprecated evaluate method
      double eval = RealEvaluator().evaluate(exp).toDouble();
      
      // Format result
      if (eval % 1 == 0) {
        _result = eval.toInt().toString();
      } else {
        _result = eval.toString();
      }
    } catch (e) {
      _result = 'Error';
    }
    notifyListeners();
  }
}
