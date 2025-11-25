import 'dart:convert';
import 'package:http/http.dart' as http;

class CurrencyService {
  static const String _baseUrl = 'https://api.exchangerate-api.com/v4/latest/';

  Future<Map<String, dynamic>> fetchRates(String baseCurrency) async {
    final response = await http.get(Uri.parse('$_baseUrl$baseCurrency'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load exchange rates');
    }
  }
}
