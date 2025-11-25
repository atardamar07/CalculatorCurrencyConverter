import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/currency_provider.dart';

class CurrencySelectionScreen extends StatelessWidget {
  const CurrencySelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currencyProvider = Provider.of<CurrencyProvider>(context);
    final allCurrencies = currencyProvider.rates.keys.toList();
    allCurrencies.sort(); // Sort alphabetically

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Currency'),
      ),
      body: Builder(
        builder: (context) {
          // Loading state
          if (currencyProvider.isLoading) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Loading currencies...'),
                ],
              ),
            );
          }
          
          // Empty state (error loading)
          if (allCurrencies.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  const Text('Failed to load currencies'),
                  // Show detailed error message for debugging
                  if (currencyProvider.errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        currencyProvider.errorMessage!,
                        style: const TextStyle(fontSize: 12, color: Colors.red),
                        textAlign: TextAlign.center,
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  const SizedBox(height: 8),
                  ElevatedButton.icon(
                    onPressed: () => currencyProvider.fetchRates(),
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          
          // Success - show currency list
          return ListView.builder(
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
          );
        },
      ),
    );
  }
}
