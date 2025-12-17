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
          _buildRow(context, ['7', '8', '9', 'C']),
          _buildRow(context, ['4', '5', '6', '⌫']),
          _buildRow(context, ['1', '2', '3', '00']),
          _buildRow(context, ['.', '0', '✓']),
        ],
      ),
    );
  }

  Widget _buildRow(BuildContext context, List<String> keys) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: keys.map((key) {
          final isClear = key == 'C';
          final isDone = key == '✓';
          
          Color? bgColor;
          Color? fgColor;
          
          if (isClear) {
            bgColor = Theme.of(context).colorScheme.error.withOpacity(0.2);
            fgColor = Theme.of(context).colorScheme.error;
          } else if (isDone) {
            bgColor = Colors.green.withOpacity(0.3);
            fgColor = Colors.green;
          } else {
            bgColor = Theme.of(context).cardColor;
            fgColor = Theme.of(context).textTheme.bodyLarge?.color;
          }
          
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Container(
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    foregroundColor: fgColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: EdgeInsets.zero,
                  ),
                  onPressed: () => onKeyPressed(key),
                  child: Text(
                    key,
                    style: const TextStyle(
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
