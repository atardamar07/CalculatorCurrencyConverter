import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/app_drawer.dart';
import '../widgets/calculator_widget.dart';
import '../widgets/currency_converter_widget.dart';
import '../widgets/numpad_widget.dart';
import '../providers/calculator_provider.dart';
import 'history_screen.dart';

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
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            tooltip: 'History',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HistoryScreen()),
              );
            },
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: Column(
        children: [
          // Scientific Mode Switch - moved here to prevent overflow
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: SwitchListTile(
              title: const Text(
                "Scientific Mode",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              value: _isScientific,
              onChanged: (val) {
                setState(() {
                  _isScientific = val;
                  // Switch to calculator mode when scientific mode is enabled
                  if (val) {
                    _activeMode = ActiveMode.calculator;
                  }
                });
              },
              dense: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
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
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _activeMode = ActiveMode.currency;
                });
              },
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
          ),
          const Divider(height: 1, thickness: 1),
          // Shared Numpad with animation
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            height: _activeMode == ActiveMode.calculator ? 320 : 240,
            padding: const EdgeInsets.all(8),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0.0, 0.1),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  ),
                );
              },
              child: _activeMode == ActiveMode.calculator
                  ? Container(
                      key: ValueKey('calculator_numpad_$_isScientific'),
                      child: _buildCalculatorNumpad(),
                    )
                  : NumpadWidget(
                      key: const ValueKey('currency_numpad'),
                      onKeyPressed: (key) => _handleCurrencyKey(key),
                    ),
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
    return Container(
      key: const ValueKey('standard_calculator_numpad'),
      child: Column(
        children: [
          Expanded(child: _buildCalculatorRow(['C', '⌫', '%', '÷'], provider)),
          Expanded(child: _buildCalculatorRow(['7', '8', '9', '×'], provider)),
          Expanded(child: _buildCalculatorRow(['4', '5', '6', '-'], provider)),
          Expanded(child: _buildCalculatorRow(['1', '2', '3', '+'], provider)),
          Expanded(child: _buildCalculatorRow(['00', '0', '.', '='], provider)),
        ],
      ),
    );
  }

  Widget _buildScientificNumpad(CalculatorProvider provider) {
    return Container(
      key: const ValueKey('scientific_calculator_numpad'),
      child: Column(
        children: [
          Expanded(child: _buildCalculatorRow(['sin', 'cos', 'tan', 'log', 'ln'], provider)),
          Expanded(child: _buildCalculatorRow(['(', ')', '^', '√', '÷'], provider)),
          Expanded(child: _buildCalculatorRow(['7', '8', '9', 'C', '×'], provider)),
          Expanded(child: _buildCalculatorRow(['4', '5', '6', '⌫', '-'], provider)),
          Expanded(child: _buildCalculatorRow(['1', '2', '3', '%', '+'], provider)),
          Expanded(child: _buildCalculatorRow(['00', '0', '.', 'π', '='], provider)),
        ],
      ),
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
            child: Container(
              decoration: BoxDecoration(
                gradient: isEqual
                    ? LinearGradient(
                        colors: [
                          Theme.of(context).colorScheme.primary,
                          Theme.of(context).colorScheme.primary.withValues(alpha: 0.8),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : isOperator
                        ? LinearGradient(
                            colors: [
                              Theme.of(context).colorScheme.secondary.withValues(alpha: 0.3),
                              Theme.of(context).colorScheme.secondary.withValues(alpha: 0.2),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                        : isClear
                            ? LinearGradient(
                                colors: [
                                  Theme.of(context).colorScheme.error.withValues(alpha: 0.3),
                                  Theme.of(context).colorScheme.error.withValues(alpha: 0.2),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              )
                            : null,
                color: isEqual || isOperator || isClear
                    ? null
                    : Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: isEqual
                        ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.3)
                        : isOperator
                            ? Theme.of(context).colorScheme.secondary.withValues(alpha: 0.2)
                            : isClear
                                ? Theme.of(context).colorScheme.error.withValues(alpha: 0.2)
                                : Colors.black.withValues(alpha: 0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  foregroundColor: isClear
                      ? Theme.of(context).colorScheme.error
                      : isEqual
                          ? Theme.of(context).colorScheme.onPrimary
                          : Theme.of(context).textTheme.bodyLarge?.color,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: EdgeInsets.zero,
                ),
                onPressed: () => _handleCalculatorKey(key),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 4.0),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      key,
                      style: TextStyle(
                        fontSize: _isScientific && ['sin', 'cos', 'tan', 'log', 'ln'].contains(key) ? 10 : 18,
                        fontWeight: isOperator || isEqual ? FontWeight.bold : FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                    ),
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
