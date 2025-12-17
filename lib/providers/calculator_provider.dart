import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/ad_service.dart';

// History item model
class HistoryItem {
  final String expression;
  final String result;
  final DateTime timestamp;

  HistoryItem({
    required this.expression,
    required this.result,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
    'expression': expression,
    'result': result,
    'timestamp': timestamp.toIso8601String(),
  };

  factory HistoryItem.fromJson(Map<String, dynamic> json) => HistoryItem(
    expression: json['expression'],
    result: json['result'],
    timestamp: DateTime.parse(json['timestamp']),
  );
}

class CalculatorProvider with ChangeNotifier {
  String _expression = '';
  String _result = '0';
  List<HistoryItem> _history = [];
  final AdService _adService = AdService();

  CalculatorProvider() {
    _loadState();
  }

  String get expression => _expression;
  String get result => _result;
  List<HistoryItem> get history => _history;

  // Load saved state from SharedPreferences
  Future<void> _loadState() async {
    final prefs = await SharedPreferences.getInstance();
    _expression = prefs.getString('calc_expression') ?? '';
    _result = prefs.getString('calc_result') ?? '0';
    
    // Load history
    final historyJson = prefs.getString('calc_history');
    if (historyJson != null) {
      try {
        final List<dynamic> decoded = jsonDecode(historyJson);
        _history = decoded.map((e) => HistoryItem.fromJson(e)).toList();
      } catch (e) {
        _history = [];
      }
    }
    notifyListeners();
  }

  // Save state to SharedPreferences
  Future<void> _saveState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('calc_expression', _expression);
    await prefs.setString('calc_result', _result);
    
    // Save history (limit to last 50 items)
    if (_history.length > 50) {
      _history = _history.sublist(_history.length - 50);
    }
    final historyJson = jsonEncode(_history.map((e) => e.toJson()).toList());
    await prefs.setString('calc_history', historyJson);
  }

  void addToExpression(String value) {
    _expression += value;
    _saveState();
    notifyListeners();
  }

  void clear() {
    _expression = '';
    _result = '0';
    _saveState();
    notifyListeners();
  }

  void delete() {
    if (_expression.isNotEmpty) {
      _expression = _expression.substring(0, _expression.length - 1);
      _saveState();
      notifyListeners();
    }
  }

  // Use a history item (restore expression and result)
  void useHistoryItem(HistoryItem item) {
    _expression = item.expression;
    _result = item.result;
    _saveState();
    notifyListeners();
  }

  // Clear all history
  void clearHistory() {
    _history = [];
    _saveState();
    notifyListeners();
  }

  void evaluate() {
    try {
      if (_expression.isEmpty) {
        _result = '0';
        notifyListeners();
        return;
      }

      // Preprocess expression to handle special cases
      String finalExpression = _preprocessExpression(_expression);
      
      // Remove trailing operators before evaluation
      finalExpression = _removeTrailingOperators(finalExpression);
      
      if (finalExpression.isEmpty) {
        _result = '0';
        notifyListeners();
        return;
      }

      // Use new GrammarParser instead of deprecated Parser
      GrammarParser p = GrammarParser();
      
      Expression exp = p.parse(finalExpression);
      // Use new RealEvaluator instead of deprecated evaluate method
      double eval = RealEvaluator().evaluate(exp).toDouble();
      
      // Handle special cases (infinity, NaN)
      if (eval.isInfinite || eval.isNaN) {
        _result = 'Error';
      } else {
        // Format result
        if (eval % 1 == 0) {
          _result = eval.toInt().toString();
        } else {
          _result = eval.toString();
        }
        
        // Add to history (only successful calculations)
        _history.add(HistoryItem(
          expression: _expression,
          result: _result,
          timestamp: DateTime.now(),
        ));
      }
    } catch (e) {
      _result = 'Error';
    }
    _saveState();
    notifyListeners();
  }

  // Remove trailing operators from expression
  String _removeTrailingOperators(String expression) {
    if (expression.isEmpty) return expression;
    
    // List of operators that should be removed from the end
    final operators = ['+', '-', '*', '/', '^'];
    
    String result = expression.trim();
    
    // Keep removing trailing operators
    while (result.isNotEmpty && operators.contains(result[result.length - 1])) {
      result = result.substring(0, result.length - 1).trim();
    }
    
    return result;
  }

  String _preprocessExpression(String expression) {
    if (expression.isEmpty) return expression;
    
    String result = expression;
    
    // Replace visual symbols with math operators
    result = result.replaceAll('×', '*');
    result = result.replaceAll('÷', '/');
    result = result.replaceAll('π', '3.1415926535897932');
    
    // Handle percentage
    result = _handlePercentage(result);
    
    // Handle square root
    result = _handleSquareRoot(result);
    
    // Handle power
    result = _handlePower(result);
    
    // Handle trigonometric and logarithmic functions
    result = _handleFunctions(result);
    
    return result;
  }

  String _handlePercentage(String expression) {
    String result = expression;
    RegExp percentagePattern = RegExp(r'(\d+(?:\.\d+)?)%');
    result = result.replaceAllMapped(percentagePattern, (match) {
      String number = match.group(1)!;
      return '($number/100)';
    });
    return result;
  }

  String _handleSquareRoot(String expression) {
    String result = expression;
    
    // First handle √(expression)
    RegExp sqrtWithParens = RegExp(r'√\(([^)]+)\)');
    result = result.replaceAllMapped(sqrtWithParens, (match) {
      return 'sqrt(${match.group(1)})';
    });
    
    // Then handle √number (without parentheses)
    RegExp sqrtNumber = RegExp(r'√(\d+(?:\.\d+)?)');
    result = result.replaceAllMapped(sqrtNumber, (match) {
      return 'sqrt(${match.group(1)})';
    });
    
    return result;
  }

  String _handlePower(String expression) {
    return expression;
  }

  String _handleFunctions(String expression) {
    String result = expression;
    List<String> functions = ['sin', 'cos', 'tan', 'log', 'ln'];
    
    for (String func in functions) {
      RegExp funcWithoutParens = RegExp('\\b$func(?!\\()(\\d+(?:\\.\\d+)?)');
      result = result.replaceAllMapped(funcWithoutParens, (match) {
        return '$func(${match.group(1)})';
      });
    }
    
    return result;
  }
}
