import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/currency_service.dart';

class CurrencyProvider with ChangeNotifier {
  final CurrencyService _currencyService = CurrencyService();
  
  String _baseCurrency = 'USD';
  Map<String, double> _rates = {};
  List<String> _activeCurrencies = ['USD', 'EUR', 'TRY', 'GBP']; // Default active
  double _amount = 1.0;
  bool _isLoading = false;

  CurrencyProvider() {
    _loadPreferences();
    fetchRates();
  }

  String get baseCurrency => _baseCurrency;
  Map<String, double> get rates => _rates;
  List<String> get activeCurrencies => _activeCurrencies;
  double get amount => _amount;
  bool get isLoading => _isLoading;

  Future<void> fetchRates() async {
    _isLoading = true;
    notifyListeners();
    try {
      final data = await _currencyService.fetchRates(_baseCurrency);
      _rates = Map<String, double>.from(data['rates']);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      print("Error fetching rates: $e");
    }
  }

  void setBaseCurrency(String currency) {
    if (_baseCurrency != currency) {
      _baseCurrency = currency;
      fetchRates(); // Refetch rates for new base
      _savePreferences();
    }
  }

  void setAmount(double amount) {
    _amount = amount;
    notifyListeners();
  }

  void addCurrency(String currency) {
    if (!_activeCurrencies.contains(currency)) {
      _activeCurrencies.add(currency);
      _savePreferences();
      notifyListeners();
    }
  }

  void removeCurrency(String currency) {
    _activeCurrencies.remove(currency);
    _savePreferences();
    notifyListeners();
  }

  double convert(String targetCurrency) {
    if (_rates.containsKey(targetCurrency)) {
      return _amount * _rates[targetCurrency]!;
    }
    return 0.0;
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _baseCurrency = prefs.getString('base_currency') ?? 'USD';
    final activeList = prefs.getStringList('active_currencies');
    if (activeList != null) {
      _activeCurrencies = activeList;
    }
    notifyListeners();
  }

  Future<void> _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('base_currency', _baseCurrency);
    await prefs.setStringList('active_currencies', _activeCurrencies);
  }
}
