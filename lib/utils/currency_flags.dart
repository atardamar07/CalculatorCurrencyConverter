import 'package:flutter/services.dart';

// ISO 4217 codes start with the country's ISO 3166 code, which maps straight to
// regional-indicator letters (TRY → 🇹🇷, EUR → 🇪🇺). X codes (XOF, XDR…) belong to
// no single country; ANG's Netherlands Antilles no longer exists, so Curaçao stands in.
String getCurrencyFlag(String code) {
  if (!RegExp(r'^[A-Z]{3}$').hasMatch(code) || code.startsWith('X')) {
    return '🌐';
  }
  final country = code == 'ANG' ? 'CW' : code.substring(0, 2);
  return String.fromCharCodes(country.codeUnits.map((c) => c - 0x41 + 0x1F1E6));
}

// Currency code to name mapping
final Map<String, String> currencyNames = {
  'USD': 'US Dollar',
  'EUR': 'Euro',
  'GBP': 'British Pound',
  'JPY': 'Japanese Yen',
  'CNY': 'Chinese Yuan',
  'AUD': 'Australian Dollar',
  'CAD': 'Canadian Dollar',
  'CHF': 'Swiss Franc',
  'INR': 'Indian Rupee',
  'SGD': 'Singapore Dollar',
  'HKD': 'Hong Kong Dollar',
  'KRW': 'South Korean Won',
  'NZD': 'New Zealand Dollar',
  'MXN': 'Mexican Peso',
  'BRL': 'Brazilian Real',
  'ZAR': 'South African Rand',
  'RUB': 'Russian Ruble',
  'TRY': 'Turkish Lira',
  'SEK': 'Swedish Krona',
  'NOK': 'Norwegian Krone',
  'DKK': 'Danish Krone',
  'PLN': 'Polish Zloty',
  'THB': 'Thai Baht',
  'IDR': 'Indonesian Rupiah',
  'MYR': 'Malaysian Ringgit',
  'PHP': 'Philippine Peso',
  'VND': 'Vietnamese Dong',
  'AED': 'UAE Dirham',
  'SAR': 'Saudi Riyal',
  'ILS': 'Israeli Shekel',
  'EGP': 'Egyptian Pound',
  'ARS': 'Argentine Peso',
  'CLP': 'Chilean Peso',
  'COP': 'Colombian Peso',
  'PEN': 'Peruvian Sol',
  'UAH': 'Ukrainian Hryvnia',
  'CZK': 'Czech Koruna',
  'HUF': 'Hungarian Forint',
  'RON': 'Romanian Leu',
  'BGN': 'Bulgarian Lev',
  'HRK': 'Croatian Kuna',
  'ISK': 'Icelandic Krona',
  'PKR': 'Pakistani Rupee',
  'BDT': 'Bangladeshi Taka',
  'LKR': 'Sri Lankan Rupee',
  'NPR': 'Nepalese Rupee',
  'KZT': 'Kazakhstani Tenge',
  'UZS': 'Uzbekistani Som',
  'KWD': 'Kuwaiti Dinar',
  'QAR': 'Qatari Riyal',
  'OMR': 'Omani Rial',
  'BHD': 'Bahraini Dinar',
  'JOD': 'Jordanian Dinar',
  'LBP': 'Lebanese Pound',
  'IQD': 'Iraqi Dinar',
  'IRR': 'Iranian Rial',
  'AFN': 'Afghan Afghani',
  'NGN': 'Nigerian Naira',
  'KES': 'Kenyan Shilling',
  'ETB': 'Ethiopian Birr',
  'GHS': 'Ghanaian Cedi',
  'TZS': 'Tanzanian Shilling',
  'UGX': 'Ugandan Shilling',
  'RWF': 'Rwandan Franc',
  'MAD': 'Moroccan Dirham',
  'TND': 'Tunisian Dinar',
  'DZD': 'Algerian Dinar',
  'XOF': 'West African CFA Franc',
  'XAF': 'Central African CFA Franc',
  'XPF': 'CFP Franc',
};

// Names in the app language, filled from Android (see MainActivity.kt).
Map<String, String> _localCurrencyNames = {};

Future<void> loadLocalCurrencyNames(String languageTag) async {
  try {
    final names = await const MethodChannel(
      'currency_names',
    ).invokeMapMethod<String, String>('names', {'locale': languageTag});
    _localCurrencyNames = (names ?? {})
      ..removeWhere((code, name) => name == code);
  } catch (e) {
    _localCurrencyNames =
        {}; // tests and platforms without the channel use English names
  }
}

String getCurrencyName(String currencyCode) {
  return _localCurrencyNames[currencyCode] ??
      currencyNames[currencyCode] ??
      currencyCode;
}

// Currency code to symbol mapping
final Map<String, String> currencySymbols = {
  'USD': '\$',
  'EUR': '€',
  'GBP': '£',
  'JPY': '¥',
  'CNY': '¥',
  'AUD': 'A\$',
  'CAD': 'C\$',
  'CHF': 'Fr',
  'INR': '₹',
  'SGD': 'S\$',
  'HKD': 'HK\$',
  'KRW': '₩',
  'NZD': 'NZ\$',
  'MXN': 'Mex\$',
  'BRL': 'R\$',
  'ZAR': 'R',
  'RUB': '₽',
  'TRY': '₺',
  'SEK': 'kr',
  'NOK': 'kr',
  'DKK': 'kr',
  'PLN': 'zł',
  'THB': '฿',
  'IDR': 'Rp',
  'MYR': 'RM',
  'PHP': '₱',
  'VND': '₫',
  'AED': 'د.إ',
  'SAR': '﷼',
  'ILS': '₪',
  'EGP': 'E£',
  'ARS': '\$',
  'CLP': '\$',
  'COP': '\$',
  'PEN': 'S/',
  'UAH': '₴',
  'CZK': 'Kč',
  'HUF': 'Ft',
  'RON': 'lei',
  'BGN': 'лв',
  'HRK': 'kn',
  'ISK': 'kr',
  'PKR': '₨',
  'BDT': '৳',
  'LKR': '₨',
  'NPR': '₨',
  'KZT': '₸',
  'UZS': 'so\'m',
  'KWD': 'د.ك',
  'QAR': '﷼',
  'OMR': '﷼',
  'BHD': '.د.ب',
  'JOD': 'د.ا',
  'LBP': 'ل.ل',
  'IQD': 'ع.د',
  'IRR': '﷼',
  'AFN': '؋',
  'NGN': '₦',
  'KES': 'KSh',
  'ETB': 'Br',
  'GHS': '₵',
  'TZS': 'TSh',
  'UGX': 'USh',
  'RWF': 'FRw',
  'MAD': 'د.م.',
  'TND': 'د.ت',
  'DZD': 'د.ج',
  'XOF': 'CFA',
  'XAF': 'FCFA',
  'XPF': '₣',
};

String getCurrencySymbol(String currencyCode) {
  return currencySymbols[currencyCode] ?? currencyCode;
}

// Get currency display with symbol: "USD ($)"
String getCurrencyWithSymbol(String currencyCode) {
  final symbol = getCurrencySymbol(currencyCode);
  if (symbol == currencyCode) {
    return currencyCode;
  }
  return '$currencyCode ($symbol)';
}
