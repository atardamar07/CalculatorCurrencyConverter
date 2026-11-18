import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/currency_service.dart';

class CurrencyProvider with ChangeNotifier {
  final CurrencyService _currencyService = CurrencyService();
  static const String _cacheKey = 'rates_cache';

  String _baseCurrency = 'USD';
  Map<String, double> _rates = {}; // units of each currency per 1 USD
  DateTime? _updatedAt;
  DateTime? _nextUpdateAt;
  List<String> _activeCurrencies = ['USD', 'EUR', 'TRY', 'GBP']; // Default active
  double _amount = 0;
  bool _isLoading = false;
  bool _loadFailed = false;

  CurrencyProvider() {
    _init();
  }

  String get baseCurrency => _baseCurrency;
  Map<String, double> get rates => _rates;
  List<String> get activeCurrencies => _activeCurrencies;
  double get amount => _amount;
  bool get isLoading => _isLoading;
  bool get loadFailed => _loadFailed;
  DateTime? get updatedAt => _updatedAt;

  // Saved settings and cached rates load first; the network is only used when
  // the API has published newer rates than the cached ones.
  Future<void> _init() async {
    await _loadPreferences();
    await refreshIfStale();
  }

  // Also runs when the app returns from the background, which can be days later.
  Future<void> refreshIfStale() async {
    final next = _nextUpdateAt;
    if (_rates.isEmpty || next == null || DateTime.now().isAfter(next)) {
      await fetchRates();
    }
  }

  Future<void> fetchRates() async {
    if (_isLoading) return;
    _isLoading = true;
    _loadFailed = false;
    notifyListeners();
    try {
      final data = await _currencyService.fetchRates();
      _applyRates(data);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_cacheKey, jsonEncode(data));
    } catch (e) {
      _loadFailed = true; // keep showing the cached rates
    }
    _isLoading = false;
    notifyListeners();
  }

  void _applyRates(Map<String, dynamic> data) {
    final rates = <String, double>{
      for (final entry in (data['rates'] as Map).entries)
        if (entry.value is num && (entry.value as num) > 0)
          entry.key.toString(): (entry.value as num).toDouble(),
    };
    final updated = (data['time_last_update_unix'] as num).toInt();
    final next = (data['time_next_update_unix'] as num).toInt();
    _rates = rates;
    _updatedAt = DateTime.fromMillisecondsSinceEpoch(updated * 1000);
    _nextUpdateAt = DateTime.fromMillisecondsSinceEpoch(next * 1000);
  }

  void setBaseCurrency(String currency) {
    if (_baseCurrency != currency) {
      _amount = convert(currency); // every row keeps showing the same value
      _baseCurrency = currency;
      _savePreferences();
      notifyListeners();
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

  // Reorder currencies (for drag and drop)
  void reorderCurrency(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final item = _activeCurrencies.removeAt(oldIndex);
    _activeCurrencies.insert(newIndex, item);
    _savePreferences();
    notifyListeners();
  }

  // Rates are per 1 USD, so every pair converts through USD.
  double convert(String targetCurrency) {
    final from = _rates[_baseCurrency];
    final to = _rates[targetCurrency];
    if (from == null || to == null) return 0.0;
    return _amount / from * to;
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _baseCurrency = prefs.getString('base_currency') ?? 'USD';
    final activeList = prefs.getStringList('active_currencies');
    if (activeList != null) {
      _activeCurrencies = activeList;
    }
    final cached = prefs.getString(_cacheKey);
    if (cached != null) {
      try {
        _applyRates(jsonDecode(cached) as Map<String, dynamic>);
      } catch (e) {
        // Unreadable cache: fresh rates are fetched instead.
      }
    }
    notifyListeners();
  }

  Future<void> _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('base_currency', _baseCurrency);
    await prefs.setStringList('active_currencies', _activeCurrencies);
  }
}
