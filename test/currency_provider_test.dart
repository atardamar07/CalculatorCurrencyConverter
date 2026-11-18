import 'dart:convert';

import 'package:calculator_currency_converter/providers/currency_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

// A cached API response that is still fresh, so the provider never uses the network.
String freshRates(Map<String, num> rates) => jsonEncode({
      'result': 'success',
      'time_last_update_unix': DateTime.now().millisecondsSinceEpoch ~/ 1000,
      'time_next_update_unix': DateTime.now().add(const Duration(days: 1)).millisecondsSinceEpoch ~/ 1000,
      'rates': rates,
    });

Future<CurrencyProvider> providerWith(Map<String, Object> prefs) async {
  SharedPreferences.setMockInitialValues(prefs);
  final provider = CurrencyProvider();
  await Future<void>.delayed(Duration.zero); // let saved settings and cache load
  return provider;
}

void main() {
  final rates = freshRates({'USD': 1, 'EUR': 0.9, 'TRY': 45});

  test('converts any pair through the USD rates', () async {
    final provider = await providerWith({'rates_cache': rates});
    provider.setAmount(100);
    expect(provider.convert('EUR'), closeTo(90, 1e-9));
    expect(provider.convert('TRY'), closeTo(4500, 1e-9));
    expect(provider.isLoading, isFalse); // fresh cache: no network request
  });

  test('a saved base currency converts correctly right after start', () async {
    final provider = await providerWith({'base_currency': 'EUR', 'rates_cache': rates});
    expect(provider.baseCurrency, 'EUR');
    provider.setAmount(90);
    expect(provider.convert('USD'), closeTo(100, 1e-9));
    expect(provider.convert('TRY'), closeTo(4500, 1e-9));
  });

  test('changing the base keeps every value the same', () async {
    final provider = await providerWith({'rates_cache': rates});
    provider.setAmount(100);
    provider.setBaseCurrency('EUR');
    expect(provider.amount, closeTo(90, 1e-9));
    expect(provider.convert('USD'), closeTo(100, 1e-9));
    expect(provider.convert('TRY'), closeTo(4500, 1e-9));
  });

  test('zero, negative and non-numeric rates are dropped', () async {
    final provider = await providerWith({
      'rates_cache': jsonEncode({
        'result': 'success',
        'time_last_update_unix': 0,
        'time_next_update_unix': DateTime.now().add(const Duration(days: 1)).millisecondsSinceEpoch ~/ 1000,
        'rates': {'USD': 1, 'EUR': 0, 'XXX': -1, 'YYY': 'x'},
      }),
    });
    expect(provider.rates.keys, ['USD']);
  });
}
