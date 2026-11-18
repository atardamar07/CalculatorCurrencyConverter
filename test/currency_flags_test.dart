import 'package:calculator_currency_converter/utils/currency_flags.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('flags come from the country part of the currency code', () {
    expect(getCurrencyFlag('TRY'), '🇹🇷');
    expect(getCurrencyFlag('EUR'), '🇪🇺');
    expect(getCurrencyFlag('ALL'), '🇦🇱');
    expect(getCurrencyFlag('ANG'), '🇨🇼');
    expect(getCurrencyFlag('XOF'), '🌐');
    expect(getCurrencyFlag('btc'), '🌐');
  });
}
