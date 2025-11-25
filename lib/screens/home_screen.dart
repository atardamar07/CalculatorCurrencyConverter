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
          // Calculator Section
          Expanded(
            flex: 5,
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
            height: 240,
            padding: const EdgeInsets.all(8),
            child: NumpadWidget(
              onKeyPressed: (key) {
                if (_activeMode == ActiveMode.calculator) {
                  _handleCalculatorKey(key);
                } else {
                  _handleCurrencyKey(key);
                }
              },
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
    } else {
      calculatorProvider.addToExpression(key);
    }
  }

  void _handleCurrencyKey(String key) {
    if (_currencyNumpadHandler != null) {
      _currencyNumpadHandler!(key);
    }
  }
}
