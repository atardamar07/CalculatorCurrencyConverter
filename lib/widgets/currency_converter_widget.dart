import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/currency_provider.dart';
import '../providers/settings_provider.dart';
import '../screens/currency_selection_screen.dart';

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
  }

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
      _isUserEditing[currency] = false;
    } else {
      // Only update text if value changed AND user is not actively editing
      if (!_isUserEditing[currency]! && _controllers[currency]!.text != value) {
        final selection = _controllers[currency]!.selection;
        _controllers[currency]!.text = value;
        // Restore cursor position if valid
        if (selection.start <= value.length) {
          _controllers[currency]!.selection = selection;
        } else {
          // If cursor position is invalid, place at end
          _controllers[currency]!.selection = TextSelection.fromPosition(
            TextPosition(offset: value.length),
          );
        }
      }
    }
    return _controllers[currency]!;
  }

  // Public method to be called from parent
  void handleNumpadKey(String key) {
    if (!widget.isActive || _selectedCurrency == null) return;
    
    final controller = _controllers[_selectedCurrency];
    if (controller == null) return;
    
    final currencyProvider = Provider.of<CurrencyProvider>(context, listen: false);
    final settingsProvider = Provider.of<SettingsProvider>(context, listen: false);
    
    if (key == 'C') {
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
      final selection = controller.selection;
      
      // If current value is 0 or 0.00 format, clear it first
      String currentText = text;
      if (_isZeroValue(text)) {
        currentText = '';
        controller.text = '';
        controller.selection = TextSelection.fromPosition(
          TextPosition(offset: 0),
        );
      }
      
      // Insert number at cursor position
      final newText = currentText.replaceRange(
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
              : ListView.builder(
                  itemCount: currencyProvider.activeCurrencies.length,
                  itemBuilder: (context, index) {
                    final currency = currencyProvider.activeCurrencies[index];
                    
                    double value;
                    if (currency == currencyProvider.baseCurrency) {
                      value = currencyProvider.amount;
                    } else {
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
                                readOnly: true, // Make read-only to use numpad only
                                onChanged: (val) {
                                  // This won't be called since readOnly is true
                                  // But we keep it for safety
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
                                  if (currency != currencyProvider.baseCurrency) {
                                    currencyProvider.setBaseCurrency(currency);
                                  }
                                  if (widget.onCurrencyFieldTapped != null) {
                                    widget.onCurrencyFieldTapped!();
                                  }
                                  // Move cursor to end when tapped and prepare for input
                                  final controller = _controllers[currency];
                                  if (controller != null) {
                                    // If the value is zero, prepare to clear it on first input
                                    if (_isZeroValue(controller.text)) {
                                      // Keep the text but mark that we'll clear on first number input
                                      controller.selection = TextSelection.fromPosition(
                                        TextPosition(offset: controller.text.length),
                                      );
                                    } else {
                                      controller.selection = TextSelection.fromPosition(
                                        TextPosition(offset: controller.text.length),
                                      );
                                    }
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
