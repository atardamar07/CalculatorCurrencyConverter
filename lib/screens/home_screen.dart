import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/app_drawer.dart';
import '../widgets/calculator_widget.dart';
import '../widgets/currency_converter_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isScientific = false;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator & Currency'),
        actions: [
          // Theme Switch in AppBar as requested
          Row(
            children: [
              Icon(themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode),
              Switch(
                value: themeProvider.isDarkMode,
                onChanged: (value) {
                  themeProvider.toggleTheme(value);
                },
                activeThumbColor: Theme.of(context).colorScheme.secondary,
              ),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),
      drawer: const AppDrawer(),
      body: Column(
        children: [
          // Calculator Section
          Expanded(
            flex: 5, // Adjust flex to give more space to calculator if needed
            child: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: CalculatorWidget(isScientific: _isScientific)),
                    SwitchListTile(
                      title: const Text("Scientific Mode"),
                      value: _isScientific,
                      onChanged: (val) {
                        setState(() {
                          _isScientific = val;
                        });
                      },
                      dense: true,
                    )
                  ],
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
              child: const CurrencyConverterWidget(),
            ),
          ),
        ],
      ),
    );
  }
}
