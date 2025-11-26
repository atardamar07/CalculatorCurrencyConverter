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

