import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import '../services/ad_service.dart';

class CalculatorProvider with ChangeNotifier {
  String _expression = '';
  String _result = '0';
  final AdService _adService = AdService();

  CalculatorProvider() {
    _adService.createInterstitialAd();
  }

  String get expression => _expression;
  String get result => _result;

  void addToExpression(String value) {
    _expression += value;
    notifyListeners();
  }

  void clear() {
    _expression = '';
    _result = '0';
    notifyListeners();
    _adService.showInterstitialAd();
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
