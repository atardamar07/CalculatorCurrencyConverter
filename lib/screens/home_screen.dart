import 'package:flutter/material.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator & Currency'),
      ),
      drawer: const AppDrawer(),
      body: Column(
        children: [
          // Scientific Mode Switch - moved here to prevent overflow
          SwitchListTile(
            title: const Text("Scientific Mode"),
            value: _isScientific,
            onChanged: (val) {
              setState(() {
                _isScientific = val;
              });
            },
            dense: true,
          ),
          const Divider(height: 1, thickness: 1),
          // Calculator Section
          Expanded(
            flex: 5,
            child: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: CalculatorWidget(isScientific: _isScientific),
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
