import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../providers/settings_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final settingsProvider = Provider.of<SettingsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(l10n.decimalPrecision),
            subtitle: Text(l10n.decimalPlaces(settingsProvider.precision)),
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
        ],
      ),
    );
  }
}
