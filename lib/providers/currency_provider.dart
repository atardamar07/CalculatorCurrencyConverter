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
  String? _errorMessage; // Track error details

  CurrencyProvider() {
    _loadPreferences();
    fetchRates();
  }

  String get baseCurrency => _baseCurrency;
  Map<String, double> get rates => _rates;
  List<String> get activeCurrencies => _activeCurrencies;
  double get amount => _amount;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage; // Expose error message

  Future<void> fetchRates() async {
    _isLoading = true;
    _errorMessage = null; // Clear previous errors
    notifyListeners();
    try {
      final data = await _currencyService.fetchRates(_baseCurrency);
      
      // Check if API response has rates
      if (data.containsKey('rates') && data['rates'] is Map) {
        _rates = Map<String, double>.from(data['rates']);
        
        // IMPORTANT: Add base currency with rate 1.0
        _rates[_baseCurrency] = 1.0;
        
        _isLoading = false;
        notifyListeners();
      } else {
        throw Exception('Invalid API response format');
      }
    } catch (e) {
      _isLoading = false;
      _rates = {};
      _errorMessage = e.toString(); // Save detailed error
      notifyListeners();
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
