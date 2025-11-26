import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/calculator_provider.dart';
import '../providers/settings_provider.dart';

class CalculatorWidget extends StatelessWidget {
  final bool isScientific;
  final bool isActive;

  const CalculatorWidget({
    super.key,
    required this.isScientific,
    this.isActive = false,
  });

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

    return Container(
      padding: const EdgeInsets.all(16),
      alignment: Alignment.bottomRight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Expression display
          if (calculatorProvider.expression.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                calculatorProvider.expression,
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).textTheme.bodyLarge?.color?.withValues(alpha: 0.6),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.right,
              ),
            ),
          // Result display - make it more readable
          Text(
            displayResult,
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.bodyLarge?.color,
              height: 1.2,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.right,
          ),
        ],
      ),
    );
  }

}
