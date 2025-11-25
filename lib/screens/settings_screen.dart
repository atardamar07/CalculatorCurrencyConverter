import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/settings_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Decimal Precision'),
            subtitle: Text('Number of decimal places: ${settingsProvider.precision}'),
            trailing: DropdownButton<int>(
              value: settingsProvider.precision,
              items: [1, 2, 3, 4, 5, 6].map((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(value.toString()),
                );
              }).toList(),
              onChanged: (newValue) {
                if (newValue != null) {
                  settingsProvider.setPrecision(newValue);
                }
              },
            ),
          ),
          // Add Home Currency setting here if needed, or keep it in the main UI interactions
          const Divider(),
          ListTile(
            title: const Text('About'),
            subtitle: const Text('Calculator & Currency Converter v1.0.0'),
            leading: const Icon(Icons.info),
          ),
        ],
      ),
    );
  }
}
