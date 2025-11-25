import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/currency_provider.dart';

class CurrencySelectionScreen extends StatelessWidget {
  const CurrencySelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currencyProvider = Provider.of<CurrencyProvider>(context);
    final allCurrencies = currencyProvider.rates.keys.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Currency'),
      ),
      body: allCurrencies.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: allCurrencies.length,
              itemBuilder: (context, index) {
                final currency = allCurrencies[index];
                final isSelected = currencyProvider.activeCurrencies.contains(currency);
                return ListTile(
                  title: Text(currency),
                  trailing: isSelected
                      ? Icon(Icons.check, color: Theme.of(context).primaryColor)
                      : null,
                  onTap: () {
                    if (!isSelected) {
                      currencyProvider.addCurrency(currency);
                      Navigator.pop(context);
                    }
                  },
                );
              },
            ),
    );
  }
}
