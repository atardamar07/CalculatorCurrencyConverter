import 'package:flutter/material.dart';

class NumpadWidget extends StatelessWidget {
  final Function(String) onKeyPressed;
  final bool showDecimal;
  
  const NumpadWidget({
    super.key,
    required this.onKeyPressed,
    this.showDecimal = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          _buildRow(context, ['7', '8', '9']),
          _buildRow(context, ['4', '5', '6']),
          _buildRow(context, ['1', '2', '3']),
          _buildRow(context, ['C', '0', if (showDecimal) '.', '⌫']),
        ],
      ),
    );
  }

  Widget _buildRow(BuildContext context, List<String> keys) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: keys.map((key) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: key == 'C'
                      ? Theme.of(context).colorScheme.error.withValues(alpha: 0.2)
                      : Theme.of(context).cardColor,
                  foregroundColor: key == 'C'
                      ? Theme.of(context).colorScheme.error
                      : Theme.of(context).textTheme.bodyLarge?.color,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () => onKeyPressed(key),
                child: Text(
                  key,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
