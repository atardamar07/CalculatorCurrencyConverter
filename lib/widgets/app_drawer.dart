import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../providers/theme_provider.dart';
import '../screens/settings_screen.dart';
import '../services/purchase_service.dart';
import '../services/ad_service.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final purchaseService = PurchaseService();
    
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  'Calculator & Currency',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Version 1.0.3',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.brightness_6),
            title: const Text('Theme'),
            trailing: Switch(
              value: themeProvider.isDarkMode,
              onChanged: (value) {
                themeProvider.toggleTheme(value);
              },
            ),
          ),
          // Remove Ads Button
          FutureBuilder<bool>(
            future: _checkAdsRemoved(),
            builder: (context, snapshot) {
              final adsRemoved = snapshot.data ?? false;
              
              if (adsRemoved) {
                return ListTile(
                  leading: const Icon(Icons.check_circle, color: Colors.green),
                  title: const Text('Ads Removed'),
                  subtitle: const Text('Thank you for your support!'),
                );
              }
              
              return ListTile(
                leading: const Icon(Icons.remove_circle_outline, color: Colors.orange),
                title: const Text('Remove Ads'),
                subtitle: const Text('\$1.99 - One-time purchase'),
                onTap: () {
                  Navigator.pop(context);
                  _showPurchaseDialog(context);
                },
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.restore),
            title: const Text('Restore Purchases'),
            onTap: () async {
              Navigator.pop(context);
              final purchaseService = PurchaseService();
              await purchaseService.initialize();
              await purchaseService.restorePurchases();
              
              if (purchaseService.isPurchased) {
                AdService().setAdsRemoved(true);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Purchases restored successfully!')),
                  );
                }
              } else {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('No purchases to restore')),
                  );
                }
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.share),
            title: const Text('Share App'),
            subtitle: const Text('Tell your friends about this app'),
            onTap: () {
              Navigator.pop(context);
              Share.share(
                'Check out Calculator & Currency Converter - A powerful calculator and currency converter app!\n\n'
                'Download now: https://play.google.com/store/apps/details?id=com.minicoreapps.calculator',
                subject: 'Calculator & Currency Converter',
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('About'),
            onTap: () {
              Navigator.pop(context);
              showAboutDialog(
                context: context,
                applicationName: 'Calculator & Currency',
                applicationVersion: '1.0.3',
                applicationIcon: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/images/new_logo.png',
                    width: 64,
                    height: 64,
                  ),
                ),
                children: [
                  const Text('A powerful calculator and currency converter app.'),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Future<bool> _checkAdsRemoved() async {
    final purchaseService = PurchaseService();
    await purchaseService.initialize();
    return purchaseService.isPurchased;
  }

  void _showPurchaseDialog(BuildContext context) async {
    final purchaseService = PurchaseService();
    await purchaseService.initialize();
    
    if (!context.mounted) return;
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.remove_circle_outline, color: Colors.orange),
            SizedBox(width: 8),
            Text('Remove Ads'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enjoy an ad-free experience!',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text('• No more interruptions'),
            const Text('• One-time payment'),
            const Text('• Lifetime access'),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    purchaseService.products.isNotEmpty 
                        ? purchaseService.products.first.price 
                        : '\$1.99',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
            if (purchaseService.errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  purchaseService.errorMessage!,
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: purchaseService.isLoading 
                ? null 
                : () async {
                    await purchaseService.buyRemoveAds();
                    if (purchaseService.isPurchased) {
                      AdService().setAdsRemoved(true);
                      if (dialogContext.mounted) {
                        Navigator.pop(dialogContext);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Thank you! Ads have been removed.'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      }
                    }
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
            ),
            child: purchaseService.isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Text('Purchase'),
          ),
        ],
      ),
    );
  }
}
