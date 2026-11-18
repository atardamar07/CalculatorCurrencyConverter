import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../providers/currency_provider.dart';
import '../utils/currency_flags.dart';

class CurrencySelectionScreen extends StatefulWidget {
  const CurrencySelectionScreen({super.key});

  @override
  State<CurrencySelectionScreen> createState() => _CurrencySelectionScreenState();
}

class _CurrencySelectionScreenState extends State<CurrencySelectionScreen> {
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final currencyProvider = Provider.of<CurrencyProvider>(context);
    final allCurrencies = currencyProvider.rates.keys.toList();
    allCurrencies.sort(); // Sort alphabetically

    // Filter currencies based on search query
    final filteredCurrencies = _searchQuery.isEmpty
        ? allCurrencies
        : allCurrencies.where((currency) {
            final query = _searchQuery.toLowerCase();
            final currencyLower = currency.toLowerCase();
            final currencyName = getCurrencyName(currency).toLowerCase();
            return currencyLower.contains(query) || currencyName.contains(query);
          }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.selectCurrency),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: l10n.searchCurrency,
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            _searchQuery = '';
                            _searchController.clear();
                          });
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Theme.of(context).cardColor,
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          // Content
          Expanded(
            child: Builder(
              builder: (context) {
                // Loading state (only before any rates exist; cached rates stay usable)
                if (allCurrencies.isEmpty && !currencyProvider.loadFailed) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircularProgressIndicator(),
                        const SizedBox(height: 16),
                        Text(l10n.loadingCurrencies),
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
                        Text(l10n.ratesLoadFailed),
                        const SizedBox(height: 8),
                        ElevatedButton.icon(
                          onPressed: () => currencyProvider.fetchRates(),
                          icon: const Icon(Icons.refresh),
                          label: Text(l10n.retry),
                        ),
                      ],
                    ),
                  );
                }

                // No results for search
                if (filteredCurrencies.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.search_off, size: 64, color: Colors.grey),
                        const SizedBox(height: 16),
                        Text(l10n.noCurrencyFound(_searchQuery)),
                      ],
                    ),
                  );
                }
                
                // Success - show currency list
                return ListView.builder(
                  itemCount: filteredCurrencies.length,
                  itemBuilder: (context, index) {
                    final currency = filteredCurrencies[index];
                    final isSelected = currencyProvider.activeCurrencies.contains(currency);
                    return ListTile(
                      leading: Text(
                        getCurrencyFlag(currency),
                        style: const TextStyle(fontSize: 24),
                      ),
                      title: Text(currency),
                      subtitle: Text(
                        getCurrencyName(currency),
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).textTheme.bodySmall?.color,
                        ),
                      ),
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
          ),
        ],
      ),
    );
  }
}
