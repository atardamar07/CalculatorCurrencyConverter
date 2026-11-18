import 'dart:math' as math;

import 'package:calculator_currency_converter/providers/calculator_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<CalculatorProvider> newCalculator() async {
  SharedPreferences.setMockInitialValues({});
  final calculator = CalculatorProvider();
  await Future<void>.delayed(Duration.zero); // let the saved state load first
  return calculator;
}

// Presses space-separated keys like the keypad does, then "=".
String press(CalculatorProvider calculator, String keys) {
  for (final key in keys.split(' ')) {
    calculator.addToExpression(key);
  }
  calculator.evaluate();
  return calculator.result;
}

void main() {
  late CalculatorProvider calc;
  setUp(() async => calc = await newCalculator());

  group('arithmetic', () {
    test('basic operations', () {
      expect(press(calc, '2 + 3'), '5');
      expect(press(calc, '10 ÷ 4'), '2.5');
      expect(press(calc, '2 ^ 10'), '1024');
    });
    test('float noise is hidden, also in history', () {
      expect(press(calc, '0.1 + 0.2'), '0.3');
      expect(calc.history.last.result, '0.3');
    });
    test('division by zero is an error and not saved', () {
      expect(press(calc, '5 ÷ 0'), 'Error');
      expect(calc.history, isEmpty);
    });
    test('large results are not clamped to int64', () {
      final result = press(calc, '99999999999 × 99999999999');
      expect(result, isNot('9223372036854775807'));
      expect(double.parse(result), closeTo(1e22, 1e13));
    });
    test('trailing operator or point is ignored', () {
      expect(press(calc, '5 +'), '5');
      calc.clear();
      expect(press(calc, '5 .'), '5');
    });
  });

  group('percent works like phone calculators', () {
    test('a ± b% is b percent of a', () {
      expect(press(calc, '200 + 10 %'), '220');
      calc.clear();
      expect(press(calc, '200 - 10 %'), '180');
      calc.clear();
      expect(press(calc, '100 + 10 % + 5 %'), '115.5');
      calc.clear();
      expect(press(calc, '( 5 + 10 % ) × 2'), '11');
    });
    test('other percents divide by 100', () {
      expect(press(calc, '200 × 10 %'), '20');
      calc.clear();
      expect(press(calc, '50 %'), '0.5');
    });
  });

  group('scientific', () {
    test('pi and implicit multiplication', () {
      expect(double.parse(press(calc, '2 π')), closeTo(2 * math.pi, 1e-9));
      calc.clear();
      expect(press(calc, '2 ( 3 + 4 )'), '14');
      calc.clear();
      expect(press(calc, '( 1 + 2 ) ( 3 + 4 )'), '21');
      calc.clear();
      expect(press(calc, '2 √ 9'), '6');
    });
    test('square root, with and without parentheses', () {
      expect(press(calc, '√ 9'), '3');
      calc.clear();
      expect(press(calc, '√ ( 16'), '4');
    });
    test('trig functions use degrees', () {
      expect(press(calc, 'sin 30'), '0.5');
      calc.clear();
      expect(press(calc, 'cos 60'), '0.5');
      calc.clear();
      expect(press(calc, 'tan 45'), '1');
      calc.clear();
      expect(press(calc, 'sin 180'), '0');
      calc.clear();
      expect(press(calc, 'tan 90'), 'Error');
    });
    test('log is base 10, ln is natural', () {
      expect(press(calc, 'log 100'), '2');
      calc.clear();
      expect(press(calc, 'ln 1'), '0');
    });
  });

  group('input rules', () {
    test('after "=", an operator continues from the result', () {
      press(calc, '2 + 3');
      expect(press(calc, '× 2'), '10');
    });
    test('after "=", a digit starts a new calculation', () {
      press(calc, '2 + 3');
      calc.addToExpression('7');
      expect(calc.expression, '7');
      expect(calc.result, '0');
    });
    test('after "=", % works on the result', () {
      press(calc, '200');
      expect(press(calc, '%'), '2');
    });
    test('a second operator replaces the first, minus after × stays', () {
      expect(press(calc, '5 + × 3'), '15');
      calc.clear();
      expect(press(calc, '5 × - 3'), '-15');
    });
    test('one decimal point per number, leading point becomes 0.', () {
      for (final key in ['1', '.', '2', '.', '3']) {
        calc.addToExpression(key);
      }
      expect(calc.expression, '1.23');
      calc.clear();
      calc.addToExpression('.');
      expect(calc.expression, '0.');
    });
    test('backspace removes a whole function name', () {
      calc.addToExpression('2');
      calc.addToExpression('sin');
      calc.delete();
      expect(calc.expression, '2');
    });
  });
}
