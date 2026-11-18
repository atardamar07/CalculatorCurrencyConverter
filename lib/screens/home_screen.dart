import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../services/ad_service.dart';
import '../widgets/app_drawer.dart';
import '../widgets/calculator_widget.dart';
import '../widgets/currency_converter_widget.dart';
import '../utils/currency_flags.dart';
import '../widgets/numpad_widget.dart';
import '../providers/calculator_provider.dart';
import '../providers/currency_provider.dart';
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
  String? _currencyNamesLocale;
  late final AppLifecycleListener _lifecycle;

  static const _standardKeys = [
    ['C', '⌫', '%', '÷'],
    ['7', '8', '9', '×'],
    ['4', '5', '6', '-'],
    ['1', '2', '3', '+'],
    ['00', '0', '.', '='],
  ];
  static const _scientificKeys = [
    ['sin', 'cos', 'tan', 'log', 'ln'],
    ['(', ')', '^', '√', '÷'],
    ['7', '8', '9', 'C', '×'],
    ['4', '5', '6', '⌫', '-'],
    ['1', '2', '3', '%', '+'],
    ['00', '0', '.', 'π', '='],
  ];
  static const _currencyKeys = [
    ['7', '8', '9', 'C'],
    ['4', '5', '6', '⌫'],
    ['1', '2', '3', '00'],
    ['.', '0', '✓'],
  ];

  @override
  void initState() {
    super.initState();
    // Rates can be days old when the app comes back from the background.
    _lifecycle = AppLifecycleListener(
      onResume: () => context.read<CurrencyProvider>().refreshIfStale(),
    );
  }

  @override
  void dispose() {
    _lifecycle.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Currency names follow the app language (loaded from Android once per language).
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (locale != _currencyNamesLocale) {
      _currencyNamesLocale = locale;
      loadLocalCurrencyNames(locale).then((_) {
        if (mounted) setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final calculatorSection = GestureDetector(
      onTap: () {
        setState(() {
          _activeMode = ActiveMode.calculator;
        });
      },
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        // Numbers and keys keep calculator order in right-to-left languages.
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: CalculatorWidget(isScientific: _isScientific),
        ),
      ),
    );
    final currencySection = GestureDetector(
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
          // Only stored for key presses; nothing on screen depends on it.
          onNumpadHandlerReady: (handler) => _currencyNumpadHandler = handler,
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        // Long translations shrink instead of being cut off.
        title: FittedBox(fit: BoxFit.scaleDown, child: Text(l10n.appTitle)),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            tooltip: l10n.history,
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HistoryScreen()),
              );
              AdService().showAtTransition();
            },
          ),
        ],
      ),
      drawer: const AppDrawer(),
      // Keeps the bottom keypad row above the system navigation bar (edge-to-edge on Android 15+).
      body: SafeArea(
        top: false,
        child: Column(
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
                title: Text(
                  l10n.scientificMode,
                  style: const TextStyle(fontWeight: FontWeight.w600),
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
            // Calculator and currency share the space above the keypad; while
            // amounts are typed the calculator shrinks so more currencies fit.
            Expanded(
              child: TweenAnimationBuilder<double>(
                tween: Tween(
                  end: _activeMode == ActiveMode.calculator ? 3 / 7 : 1 / 4,
                ),
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                builder: (context, calculatorShare, _) => Column(
                  children: [
                    Expanded(
                      flex: (calculatorShare * 1000).round(),
                      child: calculatorSection,
                    ),
                    const Divider(height: 1, thickness: 1),
                    Expanded(
                      flex: ((1 - calculatorShare) * 1000).round(),
                      child: currencySection,
                    ),
                  ],
                ),
              ),
            ),
            const Divider(height: 1, thickness: 1),
            // Shared Numpad with animation
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              // Short screens give part of the keypad's height to the currency list.
              height: math.min(
                _activeMode == ActiveMode.calculator ? 320.0 : 240.0,
                MediaQuery.sizeOf(context).height * 0.42,
              ),
              padding: const EdgeInsets.all(8),
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
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
                  // The keys never change, so typing does not rebuild them.
                  child: _activeMode == ActiveMode.calculator
                      ? NumpadWidget(
                          key: ValueKey('calculator_numpad_$_isScientific'),
                          rows: _isScientific ? _scientificKeys : _standardKeys,
                          onKeyPressed: _handleCalculatorKey,
                        )
                      : NumpadWidget(
                          key: const ValueKey('currency_numpad'),
                          rows: _currencyKeys,
                          onKeyPressed: _handleCurrencyKey,
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleCalculatorKey(String key) {
    final calculatorProvider = Provider.of<CalculatorProvider>(
      context,
      listen: false,
    );
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
}
