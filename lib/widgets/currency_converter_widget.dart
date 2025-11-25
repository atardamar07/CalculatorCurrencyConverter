import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/currency_provider.dart';
import '../providers/settings_provider.dart';
import '../screens/currency_selection_screen.dart';
import '../widgets/numpad_widget.dart';

class CurrencyConverterWidget extends StatefulWidget {
  const CurrencyConverterWidget({super.key});

  @override
  State<CurrencyConverterWidget> createState() => _CurrencyConverterWidgetState();
}

class _CurrencyConverterWidgetState extends State<CurrencyConverterWidget> {
  bool _isEditing = false;
  final Map<String, TextEditingController> _controllers = {};
  String? _selectedCurrency; // Track which currency is selected for numpad input

  @override
  void dispose() {
    // Clean up all controllers
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  TextEditingController _getController(String currency, String value) {
    if (!_controllers.containsKey(currency)) {
      _controllers[currency] = TextEditingController(text: value);
    } else {
      // Only update text if value changed
      if (_controllers[currency]!.text != value) {
        final selection = _controllers[currency]!.selection;
        _controllers[currency]!.text = value;
        // Restore cursor position if valid
        if (selection.start <= value.length) {
          _controllers[currency]!.selection = selection;
        }
      }
    }
    return _controllers[currency]!;
  }

  void _handleNumpadKey(String key, CurrencyProvider currencyProvider) {
    if (_selectedCurrency == null) return;
    
    final controller = _controllers[_selectedCurrency];
    if (controller == null) return;
    
    if (key == 'C') {
      controller.clear();
      currencyProvider.setAmount(0);
    } else {
      // Insert at cursor position
      final text = controller.text;
      final selection = controller.selection;
      final newText = text.replaceRange(
        selection.start,
        selection.end,
        key,
      );
      controller.text = newText;
      controller.selection = TextSelection.fromPosition(
        TextPosition(offset: selection.start + 1),
      );
      
      // Update provider
      double? amount = double.tryParse(newText);
      if (amount != null) {
        if (_selectedCurrency != currencyProvider.baseCurrency) {
          currencyProvider.setBaseCurrency(_selectedCurrency!);
        }
        currencyProvider.setAmount(amount);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final currencyProvider = Provider.of<CurrencyProvider>(context);
    final settingsProvider = Provider.of<SettingsProvider>(context);

    return Column(
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Currencies",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const CurrencySelectionScreen()),
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(_isEditing ? Icons.check : Icons.edit),
                    onPressed: () {
                      setState(() {
                        _isEditing = !_isEditing;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        // List
        Expanded(
          flex: 3,
          child: currencyProvider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: currencyProvider.activeCurrencies.length,
                  itemBuilder: (context, index) {
                    final currency = currencyProvider.activeCurrencies[index];
                    // Calculate value based on base currency
                    // If this is the base currency, show amount.
                    // Else show converted amount.
                    // But we want all to be editable.
                    // If user edits one, that becomes base.
                    
                    double value;
                    if (currency == currencyProvider.baseCurrency) {
                      value = currencyProvider.amount;
                    } else {
                      // Convert base amount to this currency
                      // base -> target = amount * rate(target) / rate(base)
                      // Since our rates are based on USD (from API), we need to handle cross rates if base is not USD.
                      // Provider logic: convert(target) assumes base is set correctly.
                      // But provider.convert uses _rates[target]. If _baseCurrency is not USD, we need to adjust.
                      // Wait, the API returns rates relative to USD.
                      // If user selects EUR as base, we need to fetch rates for EUR or calculate cross rates.
                      // Provider `fetchRates` fetches for `_baseCurrency`. So `_rates` are relative to `_baseCurrency`.
                      // So `convert` is correct: amount * rate.
                      value = currencyProvider.convert(currency);
                    }

                    return ListTile(
                      title: Text(
                        currency,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      trailing: _isEditing
                          ? IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/currency_provider.dart';
import '../providers/settings_provider.dart';
import '../screens/currency_selection_screen.dart';
import '../widgets/numpad_widget.dart';

class CurrencyConverterWidget extends StatefulWidget {
  const CurrencyConverterWidget({super.key});

  @override
  State<CurrencyConverterWidget> createState() => _CurrencyConverterWidgetState();
}

class _CurrencyConverterWidgetState extends State<CurrencyConverterWidget> {
  bool _isEditing = false;
  final Map<String, TextEditingController> _controllers = {};
  String? _selectedCurrency; // Track which currency is selected for numpad input

  @override
  void dispose() {
    // Clean up all controllers
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  TextEditingController _getController(String currency, String value) {
    if (!_controllers.containsKey(currency)) {
      _controllers[currency] = TextEditingController(text: value);
    } else {
      // Only update text if value changed
      if (_controllers[currency]!.text != value) {
        final selection = _controllers[currency]!.selection;
        _controllers[currency]!.text = value;
        // Restore cursor position if valid
        if (selection.start <= value.length) {
          _controllers[currency]!.selection = selection;
        }
      }
    }
    return _controllers[currency]!;
  }

  void _handleNumpadKey(String key, CurrencyProvider currencyProvider) {
    if (_selectedCurrency == null) return;
    
    final controller = _controllers[_selectedCurrency];
    if (controller == null) return;
    
    if (key == 'C') {
      controller.clear();
      currencyProvider.setAmount(0);
    } else {
      // Insert at cursor position
      final text = controller.text;
      final selection = controller.selection;
      final newText = text.replaceRange(
        selection.start,
        selection.end,
        key,
      );
      controller.text = newText;
      controller.selection = TextSelection.fromPosition(
        TextPosition(offset: selection.start + 1),
      );
      
      // Update provider
      double? amount = double.tryParse(newText);
      if (amount != null) {
        if (_selectedCurrency != currencyProvider.baseCurrency) {
          currencyProvider.setBaseCurrency(_selectedCurrency!);
        }
        currencyProvider.setAmount(amount);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final currencyProvider = Provider.of<CurrencyProvider>(context);
    final settingsProvider = Provider.of<SettingsProvider>(context);

    return Column(
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Currencies",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const CurrencySelectionScreen()),
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(_isEditing ? Icons.check : Icons.edit),
                    onPressed: () {
                      setState(() {
                        _isEditing = !_isEditing;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        // List
        Expanded(
          flex: 3,
          child: currencyProvider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: currencyProvider.activeCurrencies.length,
                  itemBuilder: (context, index) {
                    final currency = currencyProvider.activeCurrencies[index];
                    // Calculate value based on base currency
                    // If this is the base currency, show amount.
                    // Else show converted amount.
                    // But we want all to be editable.
                    // If user edits one, that becomes base.
                    
                    double value;
                    if (currency == currencyProvider.baseCurrency) {
                      value = currencyProvider.amount;
                    } else {
                      // Convert base amount to this currency
                      // base -> target = amount * rate(target) / rate(base)
                      // Since our rates are based on USD (from API), we need to handle cross rates if base is not USD.
                      // Provider logic: convert(target) assumes base is set correctly.
                      // But provider.convert uses _rates[target]. If _baseCurrency is not USD, we need to adjust.
                      // Wait, the API returns rates relative to USD.
                      // If user selects EUR as base, we need to fetch rates for EUR or calculate cross rates.
                      // Provider `fetchRates` fetches for `_baseCurrency`. So `_rates` are relative to `_baseCurrency`.
                      // So `convert` is correct: amount * rate.
                      value = currencyProvider.convert(currency);
                    }

                    return ListTile(
                      title: Text(
                        currency,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      trailing: _isEditing
                          ? IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                currencyProvider.removeCurrency(currency);
                              },
                            )
                          : SizedBox(
                              width: 150,
                              child: TextField(
                                controller: _getController(
                                  currency,
                                  value.toStringAsFixed(settingsProvider.precision),
                                ),
                                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                                textAlign: TextAlign.right,
                                onChanged: (val) {
                                  if (val.isNotEmpty) {
                                    double? newAmount = double.tryParse(val);
                                    if (newAmount != null) {
                                      if (currency == currencyProvider.baseCurrency) {
                                        currencyProvider.setAmount(newAmount);
                                      } else {
                                        currencyProvider.setBaseCurrency(currency);
                                        currencyProvider.setAmount(newAmount);
                                      }
                                    }
                                  } else {
                                    currencyProvider.setAmount(0);
                                  }
                                },
                                onTap: () {
                                  setState(() {
                                    _selectedCurrency = currency;
                                  });
                                  if (currency != currencyProvider.baseCurrency) {
                                    currencyProvider.setBaseCurrency(currency);
                                  }
                                },
                              ),
                            ),
                    );
                  },
                ),
        ),
        const Divider(height: 1),
        // Numpad
        Container(
          height: 240,
          padding: const EdgeInsets.all(8),
          child: NumpadWidget(
            onKeyPressed: (key) => _handleNumpadKey(key, currencyProvider),
          ),
        ),
      ],
    );
  }
}
