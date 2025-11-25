import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/calculator_provider.dart';
import '../providers/settings_provider.dart';

class CalculatorWidget extends StatelessWidget {
  final bool isScientific;

  const CalculatorWidget({super.key, required this.isScientific});

  @override
  Widget build(BuildContext context) {
    final calculatorProvider = Provider.of<CalculatorProvider>(context);
    final settingsProvider = Provider.of<SettingsProvider>(context);

    // Format result based on precision if it's a number
    String displayResult = calculatorProvider.result;
    double? resultValue = double.tryParse(calculatorProvider.result);
    if (resultValue != null && calculatorProvider.result != 'Error') {
      // Check if integer
      if (resultValue % 1 == 0) {
        displayResult = resultValue.toInt().toString();
      } else {
        displayResult = resultValue.toStringAsFixed(settingsProvider.precision);
        // Remove trailing zeros if needed, or keep fixed? User asked for precision, usually implies fixed.
        // But standard calculators usually trim trailing zeros.
        // Let's respect the precision setting strictly for now as requested.
      }
    }

    return Column(
      children: [
        // Display Area
        Expanded(
          flex: 2,
          child: Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.bottomRight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  calculatorProvider.expression,
                  style: TextStyle(
                    fontSize: 24,
                    color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.7),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  displayResult,
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
        const Divider(height: 1),
        // Keypad Area
        Expanded(
          flex: 4,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return isScientific
                  ? _buildScientificLayout(context, calculatorProvider)
                  : _buildStandardLayout(context, calculatorProvider);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildStandardLayout(BuildContext context, CalculatorProvider provider) {
    return Column(
      children: [
        Expanded(child: _buildRow(context, provider, ["C", "⌫", "%", "÷"])),
        Expanded(child: _buildRow(context, provider, ["7", "8", "9", "×"])),
        Expanded(child: _buildRow(context, provider, ["4", "5", "6", "-"])),
        Expanded(child: _buildRow(context, provider, ["1", "2", "3", "+"])),
        Expanded(child: _buildRow(context, provider, ["00", "0", ".", "="])),
      ],
    );
  }

  Widget _buildScientificLayout(BuildContext context, CalculatorProvider provider) {
    // Scientific layout adds more functions. We can use a 5x5 grid or similar.
    // Or just add a row of scientific keys on top.
    // Let's do a 5-column layout for scientific.
    return Column(
      children: [
        Expanded(child: _buildRow(context, provider, ["sin", "cos", "tan", "log", "ln"])),
        Expanded(child: _buildRow(context, provider, ["(", ")", "^", "√", "÷"])),
        Expanded(child: _buildRow(context, provider, ["7", "8", "9", "C", "×"])),
        Expanded(child: _buildRow(context, provider, ["4", "5", "6", "⌫", "-"])),
        Expanded(child: _buildRow(context, provider, ["1", "2", "3", "%", "+"])),
        Expanded(child: _buildRow(context, provider, ["00", "0", ".", "π", "="])),
      ],
    );
  }

  Widget _buildRow(BuildContext context, CalculatorProvider provider, List<String> keys) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: keys.map((key) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: _isOperator(key)
                    ? Theme.of(context).colorScheme.secondary.withOpacity(0.2)
                    : _isEqual(key)
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).cardColor,
                foregroundColor: _isEqual(key)
                    ? Theme.of(context).colorScheme.onPrimary
                    : Theme.of(context).textTheme.bodyLarge?.color,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                padding: EdgeInsets.zero,
              ),
              onPressed: () => _onKeyPressed(key, provider),
              child: Text(
                key,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: _isOperator(key) || _isEqual(key) ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  bool _isOperator(String key) {
    return ["÷", "×", "-", "+", "%", "^", "√", "sin", "cos", "tan", "log", "ln", "(", ")"].contains(key);
  }

  bool _isEqual(String key) {
    return key == "=";
  }

  void _onKeyPressed(String key, CalculatorProvider provider) {
    if (key == "C") {
      provider.clear();
    } else if (key == "⌫") {
      provider.delete();
    } else if (key == "=") {
      provider.evaluate();
    } else {
      provider.addToExpression(key);
    }
  }
}
