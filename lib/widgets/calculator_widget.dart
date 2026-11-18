import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../providers/calculator_provider.dart';
import '../providers/settings_provider.dart';

class CalculatorWidget extends StatelessWidget {
  final bool isScientific;

  const CalculatorWidget({
    super.key,
    required this.isScientific,
  });

  @override
  Widget build(BuildContext context) {
    final calculatorProvider = Provider.of<CalculatorProvider>(context);
    final settingsProvider = Provider.of<SettingsProvider>(context);

    // Whole numbers are shown as the provider formatted them (no int64 clamping);
    // other results use the precision setting.
    String displayResult = calculatorProvider.result;
    final resultValue = double.tryParse(calculatorProvider.result);
    if (calculatorProvider.result == 'Error') {
      displayResult = AppLocalizations.of(context).error;
    } else if (resultValue != null && resultValue != resultValue.roundToDouble()) {
      final fixed = resultValue.toStringAsFixed(settingsProvider.precision);
      // Too small for the chosen decimals (1÷1000 at 2 decimals): show it in full, not as 0.00.
      displayResult = double.parse(fixed) == 0 ? calculatorProvider.result : fixed;
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
            Flexible(
              child: Padding(
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
            ),
          // Result display: shrinks to fit instead of cutting digits off
          Flexible(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerRight,
              child: Text(
                displayResult,
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                  height: 1.2,
                ),
                maxLines: 1,
                textAlign: TextAlign.right,
              ),
            ),
          ),
        ],
      ),
    );
  }

}
