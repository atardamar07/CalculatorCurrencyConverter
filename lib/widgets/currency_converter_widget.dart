import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/currency_provider.dart';
import '../providers/settings_provider.dart';
import '../screens/currency_selection_screen.dart';

class CurrencyConverterWidget extends StatefulWidget {
  const CurrencyConverterWidget({super.key});

  @override
  State<CurrencyConverterWidget> createState() => _CurrencyConverterWidgetState();
}

class _CurrencyConverterWidgetState extends State<CurrencyConverterWidget> {
  bool _isEditing = false;

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
                                controller: TextEditingController(
                                  text: value.toStringAsFixed(settingsProvider.precision),
                                )
                                  ..selection = TextSelection.fromPosition(
                                      TextPosition(offset: value.toStringAsFixed(settingsProvider.precision).length)),
                                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                                textAlign: TextAlign.right,
                                onChanged: (val) {
                                  if (val.isNotEmpty) {
                                    double? newAmount = double.tryParse(val);
                                    if (newAmount != null) {
                                      // Only update amount, base currency stays the same until tap
                                      // This allows real-time updates
                                      if (currency == currencyProvider.baseCurrency) {
                                        currencyProvider.setAmount(newAmount);
                                      } else {
                                        // User is editing a non-base currency
                                        // First make it base, then set amount
                                        currencyProvider.setBaseCurrency(currency);
                                        currencyProvider.setAmount(newAmount);
                                      }
                                    }
                                  } else {
                                    // Empty input, set amount to 0
                                    currencyProvider.setAmount(0);
                                  }
                                },
                                onTap: () {
                                  // When tapped, make this the base currency if not already
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
      ],
    );
  }
}
