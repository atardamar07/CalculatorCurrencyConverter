import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/currency_provider.dart';
import '../providers/calculator_provider.dart';
import '../providers/settings_provider.dart';
import '../screens/currency_selection_screen.dart';
import '../utils/currency_flags.dart';

class CurrencyConverterWidget extends StatefulWidget {
  final bool isActive;
  final Function(String)? onNumpadKey;
  final VoidCallback? onCurrencyFieldTapped;
  final Function(Function(String))? onNumpadHandlerReady;

  const CurrencyConverterWidget({
    super.key,
    this.isActive = false,
    this.onNumpadKey,
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

  @override
  void initState() {
    super.initState();
    // Register numpad handler with parent
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.onNumpadHandlerReady != null) {
        widget.onNumpadHandlerReady!(handleNumpadKey);
      }
    });
  }

  @override
  void didUpdateWidget(CurrencyConverterWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Re-register if handler changed
    if (widget.onNumpadHandlerReady != null && oldWidget.onNumpadHandlerReady != widget.onNumpadHandlerReady) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.onNumpadHandlerReady!(handleNumpadKey);
      });
    }
    
    // Auto-select first currency when widget becomes active
    if (widget.isActive && !oldWidget.isActive) {
      _autoSelectFirstCurrency();
    }
  }

  void _autoSelectFirstCurrency() {
    final currencyProvider = Provider.of<CurrencyProvider>(context, listen: false);
    if (currencyProvider.activeCurrencies.isNotEmpty && _selectedCurrency == null) {
      setState(() {
        _selectedCurrency = currencyProvider.activeCurrencies[0];
        _isUserEditing[_selectedCurrency!] = true;
      });
      // Set base currency to first one
      if (_selectedCurrency != currencyProvider.baseCurrency) {
        currencyProvider.setBaseCurrency(_selectedCurrency!);
      }
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
    if (value == value.truncateToDouble()) {
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
    final settingsProvider = Provider.of<SettingsProvider>(context, listen: false);
    
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
    } else if (key == '⌫') {
      // Backspace
      final text = controller.text;
      final selection = controller.selection;
      if (selection.start > 0) {
        final newText = text.replaceRange(
          selection.start - 1,
          selection.start,
          '',
        );
        controller.text = newText;
        controller.selection = TextSelection.fromPosition(
          TextPosition(offset: selection.start - 1),
        );
        
        double? amount = double.tryParse(newText);
        if (amount != null) {
          currencyProvider.setAmount(amount);
        } else if (newText.isEmpty || newText == '0' || newText == '0.') {
          currencyProvider.setAmount(0);
          controller.text = '0';
          controller.selection = TextSelection.fromPosition(
            TextPosition(offset: 1),
          );
        }
      }
    } else if (key == '.') {
      // Decimal point - check if already exists
      final text = controller.text;
      final selection = controller.selection;
      
      // If text is empty or just "0", replace with "0."
      if (text.isEmpty || text == '0' || _isZeroValue(text)) {
        controller.text = '0.';
        controller.selection = TextSelection.fromPosition(
          TextPosition(offset: 2),
        );
        currencyProvider.setAmount(0);
      } else if (!text.contains('.')) {
        // Insert decimal point if it doesn't exist
        final newText = text.replaceRange(
          selection.start,
          selection.end,
          '.',
        );
        controller.text = newText;
        controller.selection = TextSelection.fromPosition(
          TextPosition(offset: selection.start + 1),
        );
        
        double? amount = double.tryParse(newText);
        if (amount != null) {
          currencyProvider.setAmount(amount);
        }
      }
      _isUserEditing[_selectedCurrency!] = true;
    } else {
      // Number input
      final text = controller.text;
      
      // If current value is empty, 0, or 0.00 format, replace with the new digit
      if (text.isEmpty || text == '0' || _isZeroValue(text)) {
        controller.text = key;
        controller.selection = TextSelection.fromPosition(
          TextPosition(offset: key.length),
        );
        
        double? amount = double.tryParse(key);
        if (amount != null) {
          if (_selectedCurrency != currencyProvider.baseCurrency) {
            currencyProvider.setBaseCurrency(_selectedCurrency!);
          }
          currencyProvider.setAmount(amount);
        }
      } else {
        // Append number to existing text
        final selection = controller.selection;
        final newText = text.replaceRange(
          selection.start,
          selection.end,
          key,
        );
        controller.text = newText;
        final newCursorPos = selection.start + 1;
        controller.selection = TextSelection.fromPosition(
          TextPosition(offset: newCursorPos),
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
      _isUserEditing[_selectedCurrency!] = true;
    }
  }

  // Check if text represents zero value (0, 0.0, 0.00, etc.)
  bool _isZeroValue(String text) {
    if (text.isEmpty) return false;
    // Remove any formatting and check if it's zero
    final cleanedText = text.replaceAll(RegExp(r'[^\d.]'), '');
    final value = double.tryParse(cleanedText);
    if (value == null) return false;
    return value == 0.0;
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
              : _isEditing
                  ? _buildEditableList(currencyProvider, settingsProvider)
                  : _buildNormalList(currencyProvider, settingsProvider),
        ),
      ],
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
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
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
                readOnly: false, // Allow keyboard input
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
                  
                  // Check if calculator has a valid result and use it
                  final calculatorProvider = Provider.of<CalculatorProvider>(context, listen: false);
                  final calcResult = calculatorProvider.result;
                  final calcValue = double.tryParse(calcResult);
                  
                  if (calcValue != null && calcResult != 'Error' && calcResult != '0') {
                    // Use calculator result as the amount
                    currencyProvider.setAmount(calcValue);
                    final controller = _controllers[currency];
                    if (controller != null) {
                      final settingsProvider = Provider.of<SettingsProvider>(context, listen: false);
                      controller.text = calcValue.toStringAsFixed(settingsProvider.precision);
                    }
                  }
                  
                  if (currency != currencyProvider.baseCurrency) {
                    currencyProvider.setBaseCurrency(currency);
                  }
                  if (widget.onCurrencyFieldTapped != null) {
                    widget.onCurrencyFieldTapped!();
                  }
                  
                  // Select all text so user can start typing immediately
                  final controller = _controllers[currency];
                  if (controller != null && controller.text.isNotEmpty) {
                    // Use addPostFrameCallback to ensure selection happens after focus
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      controller.selection = TextSelection(
                        baseOffset: 0,
                        extentOffset: controller.text.length,
                      );
                    });
                  }
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
