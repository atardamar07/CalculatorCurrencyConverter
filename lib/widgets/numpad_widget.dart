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
              child: Container(
                decoration: BoxDecoration(
                  gradient: key == 'C'
                      ? LinearGradient(
                          colors: [
                            Theme.of(context).colorScheme.error.withValues(alpha: 0.3),
                            Theme.of(context).colorScheme.error.withValues(alpha: 0.2),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      : null,
                  color: key == 'C' ? null : Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: key == 'C'
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
                    foregroundColor: key == 'C'
                        ? Theme.of(context).colorScheme.error
                        : Theme.of(context).textTheme.bodyLarge?.color,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: EdgeInsets.zero,
                  ),
                  onPressed: () => onKeyPressed(key),
                  child: Text(
                    key,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
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
