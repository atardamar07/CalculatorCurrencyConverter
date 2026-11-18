import 'dart:convert';

import 'package:calculator_currency_converter/main.dart';
import 'package:calculator_currency_converter/providers/currency_provider.dart';
import 'package:calculator_currency_converter/widgets/currency_converter_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Starts the app on a small 360x640 phone with fresh cached rates (no network).
Future<void> startApp(WidgetTester tester, {Locale? locale}) async {
  tester.view.physicalSize = const Size(1080, 1920);
  tester.view.devicePixelRatio = 3.0;
  addTearDown(tester.view.reset);
  if (locale != null) {
    tester.platformDispatcher.localesTestValue = [locale];
    addTearDown(tester.platformDispatcher.clearLocalesTestValue);
  }
  SharedPreferences.setMockInitialValues({
    'rates_cache': jsonEncode({
      'result': 'success',
      'time_last_update_unix': DateTime.now().millisecondsSinceEpoch ~/ 1000,
      'time_next_update_unix': DateTime.now().add(const Duration(days: 1)).millisecondsSinceEpoch ~/ 1000,
      'rates': {'USD': 1, 'EUR': 0.9, 'TRY': 45, 'GBP': 0.75},
    }),
  });
  await tester.pumpWidget(const MyApp());
  // Times out if the home screen keeps rebuilding itself every frame.
  await tester.pumpAndSettle();
}

Future<void> pressKeys(WidgetTester tester, List<String> keys) async {
  for (final key in keys) {
    await tester.tap(find.widgetWithText(ElevatedButton, key));
    await tester.pump();
  }
}

void main() {
  testWidgets('app settles and calculates without layout overflow', (tester) async {
    await startApp(tester);
    await pressKeys(tester, ['9', '×', '9', '=']);
    expect(find.text('81'), findsOneWidget);
  });

  testWidgets('small results are not rounded away to 0.00', (tester) async {
    await startApp(tester);
    await pressKeys(tester, ['1', '÷', '1', '0', '0', '0', '=']);
    expect(find.text('0.001'), findsOneWidget);
  });

  testWidgets('Arabic: right-to-left screen, keypad keeps calculator order', (tester) async {
    await startApp(tester, locale: const Locale('ar'));
    expect(Directionality.of(tester.element(find.byType(AppBar))), TextDirection.rtl);
    final seven = tester.getCenter(find.widgetWithText(ElevatedButton, '7'));
    final nine = tester.getCenter(find.widgetWithText(ElevatedButton, '9'));
    expect(seven.dx, lessThan(nine.dx));
    await pressKeys(tester, ['9', '×', '9', '=']);
    expect(find.text('81'), findsOneWidget);
  });

  testWidgets('currency numpad can type 0.5', (tester) async {
    await startApp(tester);
    await tester.tap(find.text('Currencies')); // switches the numpad to currency mode
    await tester.pumpAndSettle();
    await pressKeys(tester, ['0', '.', '5']);

    final currency = Provider.of<CurrencyProvider>(
      tester.element(find.byType(CurrencyConverterWidget)),
      listen: false,
    );
    expect(currency.baseCurrency, 'USD');
    expect(currency.amount, 0.5);
    expect(currency.convert('EUR'), closeTo(0.45, 1e-9));
  });
}
