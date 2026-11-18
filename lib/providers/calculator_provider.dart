import 'dart:convert';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  bool _justEvaluated = false;

  static const _operators = ['+', '-', '×', '÷', '^'];

  // Trig functions take degrees like phone calculators; one-argument log is base 10
  // (the library's own log needs two arguments).
  static final GrammarParser _parser = GrammarParser()
    ..functions1.remove('sin')
    ..functions1.remove('cos')
    ..functions1.remove('tan')
    ..addFunction('sin', (a) => math.sin(a[0] * math.pi / 180))
    ..addFunction('cos', (a) => math.cos(a[0] * math.pi / 180))
    ..addFunction('tan', (a) {
      final r = a[0] * math.pi / 180;
      return math.cos(r).abs() < 1e-12 ? double.nan : math.tan(r); // tan90 is undefined
    })
    ..addFunction('log', (a) => math.log(a[0]) / math.ln10);

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

  // Save state to SharedPreferences. History is only rewritten when it changed,
  // not on every key press.
  Future<void> _saveState({bool withHistory = false}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('calc_expression', _expression);
    await prefs.setString('calc_result', _result);
    if (!withHistory) return;

    // Save history (limit to last 50 items)
    if (_history.length > 50) {
      _history = _history.sublist(_history.length - 50);
    }
    final historyJson = jsonEncode(_history.map((e) => e.toJson()).toList());
    await prefs.setString('calc_history', historyJson);
  }

  void addToExpression(String value) {
    final isOperator = _operators.contains(value);
    if (_justEvaluated) {
      _justEvaluated = false;
      // After "=", an operator or % continues from the result; anything else starts over.
      final resultIsPlainNumber = double.tryParse(_result) != null && !_result.contains('e');
      if ((isOperator || value == '%') && resultIsPlainNumber) {
        _expression = _result;
      } else {
        _expression = '';
        _result = '0';
      }
    }
    if (isOperator && _expression.isNotEmpty) {
      final last = _expression[_expression.length - 1];
      // A second operator replaces the first; "×-", "÷-" and "^-" stay for negative numbers.
      if (_operators.contains(last) && !(value == '-' && '×÷^'.contains(last))) {
        _expression = _expression.substring(0, _expression.length - 1);
      }
    }
    if (value == '.') {
      if (RegExp(r'\d*\.\d*$').hasMatch(_expression)) return; // number already has a point
      if (!RegExp(r'\d$').hasMatch(_expression)) value = '0.';
    }
    _expression += value;
    _saveState();
    notifyListeners();
  }

  void clear() {
    _expression = '';
    _result = '0';
    _justEvaluated = false;
    _saveState();
    notifyListeners();
  }

  void delete() {
    if (_expression.isNotEmpty) {
      _justEvaluated = false;
      // Function names like "sin" are deleted in one step.
      final fn = RegExp(r'(sin|cos|tan|log|ln)$').firstMatch(_expression);
      final cut = fn == null ? 1 : fn.end - fn.start;
      _expression = _expression.substring(0, _expression.length - cut);
      _saveState();
      notifyListeners();
    }
  }

  // Use a history item (restore expression and result)
  void useHistoryItem(HistoryItem item) {
    _expression = item.expression;
    _result = item.result;
    _justEvaluated = true;
    _saveState();
    notifyListeners();
  }

  // Clear all history
  void clearHistory() {
    _history = [];
    _saveState(withHistory: true);
    notifyListeners();
  }

  void evaluate() {
    final prepared = _prepare(_expression);
    if (prepared.isEmpty) {
      _result = '0';
    } else {
      try {
        final value = RealEvaluator().evaluate(_parser.parse(prepared)).toDouble();
        _result = value.isFinite ? _format(value) : 'Error';
      } catch (e) {
        _result = 'Error';
      }
      // Add to history (only successful calculations)
      if (_result != 'Error') {
        _history.add(HistoryItem(
          expression: _expression,
          result: _result,
          timestamp: DateTime.now(),
        ));
      }
    }
    _justEvaluated = true;
    _saveState(withHistory: true);
    notifyListeners();
  }

  // Turns what the user typed into something the parser accepts.
  static String _prepare(String input) {
    var s = _handlePercentage(input.replaceAll('×', '*').replaceAll('÷', '/'));
    // Implicit multiplication: 2π, 2(…), (…)(…), 2√9, 2sin30, π2, (…)2
    s = s.replaceAll(RegExp(r'(?<=[\d.)π])(?=[(π√a-z])|(?<=[)π])(?=[\d.])'), '*');
    // Bare arguments get parentheses: √9 → √(9), sin30 → sin(30), √π → √(π)
    s = s.replaceAllMapped(
      RegExp(r'(√|sin|cos|tan|log|ln)(\d+(?:\.\d+)?|π)'),
      (m) => '${m[1]}(${m[2]})',
    );
    s = s.replaceAll('√', 'sqrt').replaceAll('π', 'pi');
    // Drop trailing operators or a dangling point, then close open parentheses.
    s = s.replaceFirst(RegExp(r'[+\-*/^.]+$'), '');
    final open = '('.allMatches(s).length - ')'.allMatches(s).length;
    return s + ')' * math.max(open, 0);
  }

  // a+b% → a+(a)*b/100 like phone calculators (200+10% = 220); any other b% → b/100.
  static String _handlePercentage(String s) {
    final m = RegExp(r'(?<=[\d.)π])([+\-])(\d+(?:\.\d+)?)%').firstMatch(s);
    if (m == null) {
      return s.replaceAllMapped(RegExp(r'(\d+(?:\.\d+)?)%'), (m) => '(${m[1]}/100)');
    }
    // The left operand runs back to the nearest unclosed "(" or the start.
    var start = m.start, depth = 0;
    while (start > 0) {
      final c = s[start - 1];
      if (c == '(' && depth == 0) break;
      if (c == ')') depth++;
      if (c == '(') depth--;
      start--;
    }
    final left = s.substring(start, m.start);
    return _handlePercentage(s.replaceRange(m.start, m.end, '${m[1]}($left)*${m[2]}/100'));
  }

  static String _format(double v) {
    // shortcut: anything this small is shown as 0 to hide float noise (sin180° = 1e-16);
    // switch to relative rounding if users need results below 1e-12.
    if (v.abs() < 1e-12) return '0';
    // toInt() would clamp at 9223372036854775807, so large values use exponent form.
    if (v.abs() >= 1e15) {
      return v.toStringAsExponential(9).replaceFirst(RegExp(r'\.?0+e'), 'e');
    }
    final rounded = double.parse(v.toStringAsPrecision(15)); // 0.1+0.2 → 0.3
    return rounded == rounded.roundToDouble() ? rounded.toInt().toString() : rounded.toString();
  }
}
