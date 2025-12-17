// Currency code to flag emoji mapping
final Map<String, String> currencyFlags = {
  'USD': '🇺🇸', // United States
  'EUR': '🇪🇺', // European Union
  'GBP': '🇬🇧', // United Kingdom
  'JPY': '🇯🇵', // Japan
  'CNY': '🇨🇳', // China
  'AUD': '🇦🇺', // Australia
  'CAD': '🇨🇦', // Canada
  'CHF': '🇨🇭', // Switzerland
  'INR': '🇮🇳', // India
  'SGD': '🇸🇬', // Singapore
  'HKD': '🇭🇰', // Hong Kong
  'KRW': '🇰🇷', // South Korea
  'NZD': '🇳🇿', // New Zealand
  'MXN': '🇲🇽', // Mexico
  'BRL': '🇧🇷', // Brazil
  'ZAR': '🇿🇦', // South Africa
  'RUB': '🇷🇺', // Russia
  'TRY': '🇹🇷', // Turkey
  'SEK': '🇸🇪', // Sweden
  'NOK': '🇳🇴', // Norway
  'DKK': '🇩🇰', // Denmark
  'PLN': '🇵🇱', // Poland
  'THB': '🇹🇭', // Thailand
  'IDR': '🇮🇩', // Indonesia
  'MYR': '🇲🇾', // Malaysia
  'PHP': '🇵🇭', // Philippines
  'VND': '🇻🇳', // Vietnam
  'AED': '🇦🇪', // United Arab Emirates
  'SAR': '🇸🇦', // Saudi Arabia
  'ILS': '🇮🇱', // Israel
  'EGP': '🇪🇬', // Egypt
  'ARS': '🇦🇷', // Argentina
  'CLP': '🇨🇱', // Chile
  'COP': '🇨🇴', // Colombia
  'PEN': '🇵🇪', // Peru
  'UAH': '🇺🇦', // Ukraine
  'CZK': '🇨🇿', // Czech Republic
  'HUF': '🇭🇺', // Hungary
  'RON': '🇷🇴', // Romania
  'BGN': '🇧🇬', // Bulgaria
  'HRK': '🇭🇷', // Croatia
  'ISK': '🇮🇸', // Iceland
  'PKR': '🇵🇰', // Pakistan
  'BDT': '🇧🇩', // Bangladesh
  'LKR': '🇱🇰', // Sri Lanka
  'NPR': '🇳🇵', // Nepal
  'KZT': '🇰🇿', // Kazakhstan
  'UZS': '🇺🇿', // Uzbekistan
  'KWD': '🇰🇼', // Kuwait
  'QAR': '🇶🇦', // Qatar
  'OMR': '🇴🇲', // Oman
  'BHD': '🇧🇭', // Bahrain
  'JOD': '🇯🇴', // Jordan
  'LBP': '🇱🇧', // Lebanon
  'IQD': '🇮🇶', // Iraq
  'IRR': '🇮🇷', // Iran
  'AFN': '🇦🇫', // Afghanistan
  'NGN': '🇳🇬', // Nigeria
  'KES': '🇰🇪', // Kenya
  'ETB': '🇪🇹', // Ethiopia
  'GHS': '🇬🇭', // Ghana
  'TZS': '🇹🇿', // Tanzania
  'UGX': '🇺🇬', // Uganda
  'RWF': '🇷🇼', // Rwanda
  'MAD': '🇲🇦', // Morocco
  'TND': '🇹🇳', // Tunisia
  'DZD': '🇩🇿', // Algeria
  'XOF': '🌍', // West African CFA franc
  'XAF': '🌍', // Central African CFA franc
  'XPF': '🌍', // CFP franc
};

String getCurrencyFlag(String currencyCode) {
  return currencyFlags[currencyCode] ?? '🌐'; // Default globe emoji for unknown currencies
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

String getCurrencyName(String currencyCode) {
  return currencyNames[currencyCode] ?? currencyCode;
}
