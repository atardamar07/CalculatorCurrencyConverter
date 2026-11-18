import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../l10n/app_localizations.dart';
import '../providers/currency_provider.dart';
import '../providers/calculator_provider.dart';
import '../providers/settings_provider.dart';
import '../screens/currency_selection_screen.dart';
import '../services/ad_service.dart';
import '../utils/currency_flags.dart';

class CurrencyConverterWidget extends StatefulWidget {
  final bool isActive;
  final VoidCallback? onCurrencyFieldTapped;
  final Function(Function(String))? onNumpadHandlerReady;

  const CurrencyConverterWidget({
    super.key,
    this.isActive = false,
    this.onCurrencyFieldTapped,
    this.onNumpadHandlerReady,
  });

  @override
  State<CurrencyConverterWidget> createState() => _CurrencyConverterWidgetState();
}

class _CurrencyConverterWidgetState extends State<CurrencyConverterWidget> {
  bool _isEditing = false;
  final Map<String, TextEditingController> _controllers = {};
  String? _selectedCurrency; // Track which currency is selected for numpad input
  final Map<String, bool> _isUserEditing = {}; // Track if user is actively editing
  String? _lastImportedCalcResult; // calculator result already copied into a field

  @override
  void initState() {
    super.initState();
    // Register the numpad handler once; this tear-off never changes for this State.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onNumpadHandlerReady?.call(handleNumpadKey);
    });
  }

  @override
  void didUpdateWidget(CurrencyConverterWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Auto-select first currency when widget becomes active (after this build,
    // because it changes providers).
    if (widget.isActive && !oldWidget.isActive) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _autoSelectFirstCurrency());
    }
  }

  void _autoSelectFirstCurrency() {
    if (!mounted) return;
    final currencyProvider = Provider.of<CurrencyProvider>(context, listen: false);
    if (currencyProvider.activeCurrencies.isEmpty || _selectedCurrency != null) return;
    final first = currencyProvider.activeCurrencies[0];
    setState(() {
      _selectedCurrency = first;
      _isUserEditing[first] = true;
    });
    currencyProvider.setBaseCurrency(first);
    _selectAll(first);
  }

  // A selected value is replaced by the next key press.
  void _selectAll(String currency) {
    final controller = _controllers[currency];
    if (controller != null) {
      controller.selection = TextSelection(baseOffset: 0, extentOffset: controller.text.length);
    }
  }

  @override
  void dispose() {
    // Clean up all controllers
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  // Format value smartly: no decimals for whole numbers, otherwise use precision
  String _formatValue(double value, int precision) {
    if (value == 0) return '0';
    if (value == value.truncateToDouble() && value.abs() < 1e15) {
      return value.toInt().toString();
    }
    return value.toStringAsFixed(precision);
  }

  TextEditingController _getController(String currency, String value) {
    if (!_controllers.containsKey(currency)) {
      _controllers[currency] = TextEditingController(text: value);
      _isUserEditing[currency] = false;
    } else {
      // Only update if this is NOT the currently selected/editing currency
      // This allows live updates for other currencies while user types
      final isCurrentlyEditing = _selectedCurrency == currency && _isUserEditing[currency] == true;
      if (!isCurrentlyEditing && _controllers[currency]!.text != value) {
        _controllers[currency]!.text = value;
        _controllers[currency]!.selection = TextSelection.fromPosition(
          TextPosition(offset: value.length),
        );
      }
    }
    return _controllers[currency]!;
  }

  // Public method to be called from parent
  void handleNumpadKey(String key) {
    if (!widget.isActive) return;

    // Auto-select first currency if none selected
    if (_selectedCurrency == null) {
      _autoSelectFirstCurrency();
      if (_selectedCurrency == null) return;
    }

    final controller = _controllers[_selectedCurrency];
    if (controller == null) return;

    final currencyProvider = Provider.of<CurrencyProvider>(context, listen: false);
    // Keys replace a selected value; otherwise they edit the end of the text.
    final selection = controller.selection;
    final appending = selection.isValid && selection.isCollapsed;

    if (key == '✓') {
      // Done - finish editing and deselect
      _isUserEditing[_selectedCurrency!] = false;
      setState(() {
        _selectedCurrency = null;
      });
      return;
    } else if (key == 'C') {
      controller.clear();
      currencyProvider.setAmount(0);
      _isUserEditing[_selectedCurrency!] = false;
      return;
    }

    var text = appending ? controller.text : '';
    if (key == '⌫') {
      text = text.isEmpty ? '' : text.substring(0, text.length - 1);
      if (text.isEmpty) text = '0';
    } else if (key == '.') {
      if (text.contains('.')) return;
      text = text.isEmpty ? '0.' : '$text.';
    } else {
      // Digits and "00", without leading zeros ("0.5" still works)
      text = (text == '0' ? '' : text) + key;
      if (RegExp(r'^0+$').hasMatch(text)) text = '0';
    }
    controller.value = TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
    final amount = double.tryParse(text);
    if (amount != null) {
      if (_selectedCurrency != currencyProvider.baseCurrency) {
        currencyProvider.setBaseCurrency(_selectedCurrency!);
      }
      currencyProvider.setAmount(amount);
    }
    _isUserEditing[_selectedCurrency!] = true;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final currencyProvider = Provider.of<CurrencyProvider>(context);
    final settingsProvider = Provider.of<SettingsProvider>(context);

    // The list stays visible while cached rates refresh; a spinner or retry is
    // only needed before any rates exist.
    final Widget list;
    if (currencyProvider.rates.isEmpty) {
      list = currencyProvider.loadFailed
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(l10n.ratesLoadFailed),
                  TextButton.icon(
                    onPressed: currencyProvider.fetchRates,
                    icon: const Icon(Icons.refresh),
                    label: Text(l10n.retry),
                  ),
                ],
              ),
            )
          : const Center(child: CircularProgressIndicator());
    } else {
      list = _isEditing
          ? _buildEditableList(currencyProvider, settingsProvider)
          : _buildNormalList(currencyProvider, settingsProvider);
    }

    return Column(
      children: [
        // Header (the rates line sits under the title so it costs no list height)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      l10n.currencies,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    if (currencyProvider.updatedAt != null) _buildRatesStatus(currencyProvider, l10n),
                  ],
                ),
              ),
              if (currencyProvider.loadFailed && currencyProvider.rates.isNotEmpty)
                IconButton(
                  icon: const Icon(Icons.refresh),
                  tooltip: l10n.refreshRates,
                  onPressed: currencyProvider.isLoading ? null : currencyProvider.fetchRates,
                ),
              IconButton(
                icon: const Icon(Icons.add),
                tooltip: l10n.addCurrency,
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CurrencySelectionScreen()),
                  );
                  AdService().showAtTransition();
                },
              ),
              IconButton(
                icon: Icon(_isEditing ? Icons.check : Icons.edit),
                tooltip: l10n.editCurrencies,
                onPressed: () {
                  setState(() {
                    _isEditing = !_isEditing;
                  });
                },
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        // List
        Expanded(child: list),
      ],
    );
  }

  // Source, date and offline state of the rates. ExchangeRate-API's free plan
  // requires this attribution link.
  Widget _buildRatesStatus(CurrencyProvider currencyProvider, AppLocalizations l10n) {
    final date = DateFormat.yMMMd(Localizations.localeOf(context).toString())
        .format(currencyProvider.updatedAt!);
    final failed = currencyProvider.loadFailed;
    return InkWell(
      onTap: () => launchUrl(
        Uri.parse('https://www.exchangerate-api.com'),
        mode: LaunchMode.externalApplication,
      ),
      child: Text(
        failed ? l10n.ratesOffline(date) : l10n.ratesUpdated(date),
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: failed ? Theme.of(context).colorScheme.error : null,
            ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildEditableList(CurrencyProvider currencyProvider, SettingsProvider settingsProvider) {
    return ReorderableListView.builder(
      itemCount: currencyProvider.activeCurrencies.length,
      onReorder: (oldIndex, newIndex) {
        currencyProvider.reorderCurrency(oldIndex, newIndex);
      },
      itemBuilder: (context, index) {
        final currency = currencyProvider.activeCurrencies[index];
        return ListTile(
          key: ValueKey(currency),
          leading: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ReorderableDragStartListener(
                index: index,
                child: const Icon(Icons.drag_handle, color: Colors.grey),
              ),
              const SizedBox(width: 8),
              Text(
                getCurrencyFlag(currency),
                style: const TextStyle(fontSize: 24),
              ),
            ],
          ),
          title: Text(
            getCurrencyWithSymbol(currency),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            getCurrencyName(currency),
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).textTheme.bodySmall?.color,
            ),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              // The keypad must not keep typing into a row that is gone.
              if (_selectedCurrency == currency) {
                setState(() => _selectedCurrency = null);
              }
              currencyProvider.removeCurrency(currency);
            },
          ),
        );
      },
    );
  }

  Widget _buildNormalList(CurrencyProvider currencyProvider, SettingsProvider settingsProvider) {
    return ListView.builder(
      itemCount: currencyProvider.activeCurrencies.length,
      itemBuilder: (context, index) {
        final currency = currencyProvider.activeCurrencies[index];

        double value;
        if (currency == currencyProvider.baseCurrency) {
          value = currencyProvider.amount;
        } else {
          value = currencyProvider.convert(currency);
        }

        final isSelected = _selectedCurrency == currency;

        return Container(
          decoration: BoxDecoration(
            color: isSelected
                ? Theme.of(context).primaryColor.withValues(alpha: 0.1)
                : null,
            border: isSelected
                ? Border(
                    left: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 3,
                    ),
                  )
                : null,
          ),
          child: ListTile(
            leading: Text(
              getCurrencyFlag(currency),
              style: const TextStyle(fontSize: 24),
            ),
            title: Text(
              getCurrencyWithSymbol(currency),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: SizedBox(
              width: 150,
              child: TextField(
                controller: _getController(
                  currency,
                  _formatValue(value, settingsProvider.precision),
                ),
                // The app's own numpad is the keyboard; a hardware keyboard still works.
                keyboardType: TextInputType.none,
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: '0.00',
                  hintStyle: TextStyle(
                    color: Theme.of(context).disabledColor,
                  ),
                ),
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? Theme.of(context).primaryColor : null,
                ),
                onChanged: (val) {
                  _isUserEditing[currency] = true;
                  double? amount = double.tryParse(val);
                  if (amount != null) {
                    if (currency != currencyProvider.baseCurrency) {
                      currencyProvider.setBaseCurrency(currency);
                    }
                    currencyProvider.setAmount(amount);
                  } else if (val.isEmpty) {
                    currencyProvider.setAmount(0);
                  }
                },
                onTap: () {
                  setState(() {
                    // Reset editing flag for previously selected currency
                    if (_selectedCurrency != null && _selectedCurrency != currency) {
                      _isUserEditing[_selectedCurrency!] = false;
                    }
                    _selectedCurrency = currency;
                    _isUserEditing[currency] = true;
                  });
                  // Base first (keeps every row's value), then any new calculator result.
                  currencyProvider.setBaseCurrency(currency);

                  // Copy a new calculator result into this field, once per result
                  final calcResult = Provider.of<CalculatorProvider>(context, listen: false).result;
                  final calcValue = double.tryParse(calcResult);
                  if (calcValue != null && calcResult != '0' && calcResult != _lastImportedCalcResult) {
                    _lastImportedCalcResult = calcResult;
                    currencyProvider.setAmount(calcValue);
                    _controllers[currency]?.text = _formatValue(calcValue, settingsProvider.precision);
                  }

                  widget.onCurrencyFieldTapped?.call();

                  // Select the value after the tap has placed the cursor, so typing replaces it
                  WidgetsBinding.instance.addPostFrameCallback((_) => _selectAll(currency));
                },
                onEditingComplete: () {
                  _isUserEditing[currency] = false;
                  FocusScope.of(context).unfocus();
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
