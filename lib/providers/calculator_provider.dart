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
      if (_expression.isEmpty) {
        _result = '0';
        notifyListeners();
        return;
      }

      // Use new GrammarParser instead of deprecated Parser
      GrammarParser p = GrammarParser();
      
      // Preprocess expression to handle special cases
      String finalExpression = _preprocessExpression(_expression);
      
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
      }
    } catch (e) {
      _result = 'Error';
    }
    notifyListeners();
  }

  String _preprocessExpression(String expression) {
    if (expression.isEmpty) return expression;
    
    String result = expression;
    
    // Replace visual symbols with math operators
    result = result.replaceAll('×', '*');
    result = result.replaceAll('÷', '/');
    result = result.replaceAll('π', '3.1415926535897932');
    
    // Handle percentage: convert "50%" to "50/100" or "50*0.01"
    // Percentage should be applied to the number before it
    // For example: "100%" should become "100/100" = 1
    // "50+25%" should become "50+25/100" = 50.25
    result = _handlePercentage(result);
    
    // Handle square root: convert "√" to "sqrt"
    // "√25" -> "sqrt(25)"
    result = _handleSquareRoot(result);
    
    // Handle power: convert "^" to "pow" function
    // "2^3" -> "pow(2,3)"
    result = _handlePower(result);
    
    // Handle trigonometric and logarithmic functions
    // They should already be in correct format (sin, cos, tan, log, ln)
    // but we need to ensure they have parentheses
    result = _handleFunctions(result);
    
    return result;
  }

  String _handlePercentage(String expression) {
    // Handle percentage operator
    // Examples: "50%" -> "50/100", "100+25%" -> "100+25/100"
    // We need to find numbers followed by % and convert them
    String result = expression;
    
    // Pattern: number followed by %
    // Replace "X%" with "(X/100)" to handle it properly
    RegExp percentagePattern = RegExp(r'(\d+(?:\.\d+)?)%');
    result = result.replaceAllMapped(percentagePattern, (match) {
      String number = match.group(1)!;
      return '($number/100)';
    });
    
    return result;
  }

  String _handleSquareRoot(String expression) {
    // Handle square root: "√X" -> "sqrt(X)"
    String result = expression;
    
    // Pattern: √ followed by number or expression in parentheses
    // Simple case: √25 -> sqrt(25)
    // Complex case: √(2+3) -> sqrt(2+3)
    
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
    // math_expressions supports ^ operator directly, so we don't need to convert it
    // However, we need to ensure proper spacing if needed
    // The parser should handle ^ operator correctly
    return expression;
  }

  String _handleFunctions(String expression) {
    // Ensure trigonometric and logarithmic functions have proper parentheses
    // sin, cos, tan, log, ln should be followed by (expression)
    String result = expression;
    
    // List of functions that need parentheses
    List<String> functions = ['sin', 'cos', 'tan', 'log', 'ln'];
    
    for (String func in functions) {
      // Pattern: function name followed by number (without parentheses)
      // sin25 -> sin(25), but sin(25) should remain unchanged
      // We need to avoid matching if parentheses already exist
      
      // Match function name followed by a number that's not already in parentheses
      // Use word boundary to avoid matching "sin" in "sine" or similar
      // Pattern: func name, not followed by '(', then a number
      RegExp funcWithoutParens = RegExp('\\b$func(?!\\()(\\d+(?:\\.\\d+)?)');
      result = result.replaceAllMapped(funcWithoutParens, (match) {
        return '$func(${match.group(1)})';
      });
    }
    
    return result;
  }
}
