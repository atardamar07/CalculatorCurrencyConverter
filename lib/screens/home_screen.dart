import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/app_drawer.dart';
import '../widgets/calculator_widget.dart';
import '../widgets/currency_converter_widget.dart';
import '../widgets/numpad_widget.dart';
import '../providers/calculator_provider.dart';

enum ActiveMode { calculator, currency }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isScientific = false;
  ActiveMode _activeMode = ActiveMode.calculator;
  Function(String)? _currencyNumpadHandler;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator & Currency'),
      ),
      drawer: const AppDrawer(),
      body: Column(
        children: [
          // Scientific Mode Switch - moved here to prevent overflow
          SwitchListTile(
            title: const Text("Scientific Mode"),
            value: _isScientific,
            onChanged: (val) {
              setState(() {
                _isScientific = val;
              });
            },
            dense: true,
          ),
          const Divider(height: 1, thickness: 1),
          // Calculator Section - reduced size
          Expanded(
            flex: 3,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _activeMode = ActiveMode.calculator;
                });
              },
              child: Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: CalculatorWidget(
                  isScientific: _isScientific,
                  isActive: _activeMode == ActiveMode.calculator,
                ),
              ),
            ),
          ),
          const Divider(height: 1, thickness: 1),
          // Currency Converter Section
          Expanded(
            flex: 4,
            child: Container(
              color: Theme.of(context).cardColor,
              child: CurrencyConverterWidget(
                isActive: _activeMode == ActiveMode.currency,
                onCurrencyFieldTapped: () {
                  setState(() {
                    _activeMode = ActiveMode.currency;
                  });
                },
                onNumpadHandlerReady: (handler) {
                  setState(() {
                    _currencyNumpadHandler = handler;
                  });
                },
              ),
            ),
          ),
          const Divider(height: 1, thickness: 1),
          // Shared Numpad
          Container(
            height: _activeMode == ActiveMode.calculator ? 320 : 240,
            padding: const EdgeInsets.all(8),
            child: _activeMode == ActiveMode.calculator
                ? _buildCalculatorNumpad()
                : NumpadWidget(
                    onKeyPressed: (key) => _handleCurrencyKey(key),
                  ),
          ),
        ],
      ),
    );
  }

  void _handleCalculatorKey(String key) {
    final calculatorProvider = Provider.of<CalculatorProvider>(context, listen: false);
    if (key == 'C') {
      calculatorProvider.clear();
    } else if (key == '⌫') {
      calculatorProvider.delete();
    } else if (key == '=') {
      calculatorProvider.evaluate();
    } else {
      calculatorProvider.addToExpression(key);
    }
  }

  void _handleCurrencyKey(String key) {
    if (_currencyNumpadHandler != null) {
      _currencyNumpadHandler!(key);
    }
  }

  Widget _buildCalculatorNumpad() {
    return Consumer<CalculatorProvider>(
      builder: (context, calculatorProvider, child) {
        if (_isScientific) {
          return _buildScientificNumpad(calculatorProvider);
        } else {
          return _buildStandardNumpad(calculatorProvider);
        }
      },
    );
  }

  Widget _buildStandardNumpad(CalculatorProvider provider) {
    return Column(
      children: [
        Expanded(child: _buildCalculatorRow(['C', '⌫', '%', '÷'], provider)),
        Expanded(child: _buildCalculatorRow(['7', '8', '9', '×'], provider)),
        Expanded(child: _buildCalculatorRow(['4', '5', '6', '-'], provider)),
        Expanded(child: _buildCalculatorRow(['1', '2', '3', '+'], provider)),
        Expanded(child: _buildCalculatorRow(['00', '0', '.', '='], provider)),
      ],
    );
  }

  Widget _buildScientificNumpad(CalculatorProvider provider) {
    return Column(
      children: [
        Expanded(child: _buildCalculatorRow(['sin', 'cos', 'tan', 'log', 'ln'], provider)),
        Expanded(child: _buildCalculatorRow(['(', ')', '^', '√', '÷'], provider)),
        Expanded(child: _buildCalculatorRow(['7', '8', '9', 'C', '×'], provider)),
        Expanded(child: _buildCalculatorRow(['4', '5', '6', '⌫', '-'], provider)),
        Expanded(child: _buildCalculatorRow(['1', '2', '3', '%', '+'], provider)),
        Expanded(child: _buildCalculatorRow(['00', '0', '.', 'π', '='], provider)),
      ],
    );
  }

  Widget _buildCalculatorRow(List<String> keys, CalculatorProvider provider) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: keys.map((key) {
        final isOperator = ['÷', '×', '-', '+', '%', '^', '√', 'sin', 'cos', 'tan', 'log', 'ln', '(', ')'].contains(key);
        final isEqual = key == '=';
        final isClear = key == 'C';
        
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: isClear
                    ? Theme.of(context).colorScheme.error.withValues(alpha: 0.2)
                    : isOperator
                        ? Theme.of(context).colorScheme.secondary.withValues(alpha: 0.2)
                        : isEqual
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).cardColor,
                foregroundColor: isClear
                    ? Theme.of(context).colorScheme.error
                    : isEqual
                        ? Theme.of(context).colorScheme.onPrimary
                        : Theme.of(context).textTheme.bodyLarge?.color,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () => _handleCalculatorKey(key),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 4.0),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    key,
                    style: TextStyle(
                      fontSize: _isScientific && ['sin', 'cos', 'tan', 'log', 'ln'].contains(key) ? 10 : 16,
                      fontWeight: isOperator || isEqual ? FontWeight.bold : FontWeight.normal,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
