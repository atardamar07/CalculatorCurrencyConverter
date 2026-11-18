import 'dart:convert';
import 'package:http/http.dart' as http;

class CurrencyService {
  // Free open-access endpoint: USD based, updated daily. Its terms require an
  // attribution link in the app (shown under the currency list).
  static const String _url = 'https://open.er-api.com/v6/latest/USD';

  Future<Map<String, dynamic>> fetchRates() async {
    final response = await http.get(Uri.parse(_url)).timeout(const Duration(seconds: 15));
    if (response.statusCode != 200) {
      throw Exception('Failed to load exchange rates (${response.statusCode})');
    }
    final data = json.decode(response.body);
    if (data is! Map<String, dynamic> || data['result'] != 'success' || data['rates'] is! Map) {
      throw const FormatException('Invalid exchange rate response');
    }
    return data;
  }
}
