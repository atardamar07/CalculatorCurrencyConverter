import 'package:flutter/material.dart';

// The app's one keypad, for calculations and for currency amounts.
class NumpadWidget extends StatelessWidget {
  final List<List<String>> rows;
  final ValueChanged<String> onKeyPressed;

  const NumpadWidget({
    super.key,
    required this.rows,
    required this.onKeyPressed,
  });

  static final _operators = '÷ × - + % ^ √ sin cos tan log ln ( )'
      .split(' ')
      .toSet();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final row in rows)
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (final key in row) Expanded(child: _buildKey(context, key)),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildKey(BuildContext context, String key) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    // Keys are tinted by role; digits stay plain.
    final (Color? tint, Color? textColor) = switch (key) {
      '=' => (scheme.primary, scheme.onPrimary),
      'C' => (scheme.error, scheme.error),
      '✓' => (Colors.green, Colors.green),
      _ when _operators.contains(key) => (scheme.secondary, null),
      _ => (null, null),
    };
    final solid = key == '=';

    return Padding(
      padding: const EdgeInsets.all(4),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: tint == null ? theme.cardColor : null,
          gradient: tint == null
              ? null
              : LinearGradient(
                  colors: solid
                      ? [tint, tint.withValues(alpha: 0.8)]
                      : [
                          tint.withValues(alpha: 0.3),
                          tint.withValues(alpha: 0.2),
                        ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: tint == null
                  ? Colors.black.withValues(alpha: 0.1)
                  : tint.withValues(alpha: solid ? 0.3 : 0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            foregroundColor: textColor ?? theme.textTheme.bodyLarge?.color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
          ),
          onPressed: () => onKeyPressed(key),
          // Long labels ("sin") shrink to fit small keys.
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              key,
              maxLines: 1,
              style: TextStyle(
                fontSize: 20,
                fontWeight: tint == null ? FontWeight.w600 : FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
