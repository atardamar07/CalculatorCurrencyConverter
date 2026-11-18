import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../l10n/app_localizations.dart';
import '../providers/theme_provider.dart';
import '../screens/settings_screen.dart';
import '../services/ad_service.dart';
import '../services/purchase_service.dart';

const String appVersion = '1.1.0'; // keep in sync with the version in pubspec.yaml
const String privacyPolicyUrl =
    'https://atardamar07.github.io/CalculatorCurrencyConverter/privacy-policy';
const String playStoreUrl =
    'https://play.google.com/store/apps/details?id=com.minicoreapps.calculator';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final messenger = ScaffoldMessenger.of(context);

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
                Text(
                  l10n.appTitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.version(appVersion),
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.8),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: Text(l10n.settings),
            onTap: () async {
              Navigator.pop(context);
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
              AdService().showAtTransition();
            },
          ),
          ListTile(
            leading: const Icon(Icons.brightness_6),
            title: Text(l10n.darkMode),
            trailing: Switch(
              // The theme actually on screen, also while it follows the system setting
              value: Theme.of(context).brightness == Brightness.dark,
              onChanged: themeProvider.toggleTheme,
            ),
          ),
          // Remove Ads Button
          Consumer<PurchaseService>(
            builder: (context, purchases, child) {
              if (purchases.isPurchased) {
                return ListTile(
                  leading: const Icon(Icons.check_circle, color: Colors.green),
                  title: Text(l10n.adsRemoved),
                  subtitle: Text(l10n.thanksForSupport),
                );
              }
              final price = purchases.products.isEmpty ? null : purchases.products.first.price;
              return ListTile(
                leading: const Icon(Icons.remove_circle_outline, color: Colors.orange),
                title: Text(l10n.removeAds),
                subtitle: Text(price == null ? l10n.oneTimePurchase : l10n.oneTimePurchaseWithPrice(price)),
                enabled: !purchases.isLoading,
                onTap: () async {
                  Navigator.pop(context);
                  // Google Play shows its own confirmation sheet with the local price.
                  if (!await purchases.buyRemoveAds()) {
                    messenger.showSnackBar(SnackBar(content: Text(l10n.storeUnavailable)));
                  }
                },
              );
            },
          ),
          // Optional rewarded ads: every few watched ads give a day without interstitials
          Consumer2<PurchaseService, AdService>(
            builder: (context, purchases, ads, child) {
              if (purchases.isPurchased || !ads.rewardedAvailable) return const SizedBox.shrink();
              final until = ads.adFreeUntil;
              final locale = Localizations.localeOf(context).toString();
              return ListTile(
                leading: const Icon(Icons.ondemand_video, color: Colors.blue),
                title: Text(l10n.earnAdFreeDay),
                subtitle: Text(until != null
                    ? l10n.adFreeUntil(DateFormat.MMMd(locale).add_Hm().format(until))
                    : l10n.adsWatchedProgress(ads.rewardsWatched, AdService.rewardsForAdFreeDay)),
                enabled: until == null,
                onTap: () {
                  Navigator.pop(context);
                  if (!ads.showRewardedAd()) {
                    messenger.showSnackBar(SnackBar(content: Text(l10n.noAdAvailable)));
                  }
                },
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.restore),
            title: Text(l10n.restorePurchases),
            onTap: () async {
              Navigator.pop(context);
              // The result arrives on the purchase stream and updates the tile above.
              final started = await PurchaseService().restorePurchases();
              messenger.showSnackBar(SnackBar(
                content: Text(started ? l10n.restoringPurchases : l10n.storeUnavailable),
              ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.share),
            title: Text(l10n.shareApp),
            subtitle: Text(l10n.shareAppSubtitle),
            onTap: () {
              Navigator.pop(context);
              Share.share(l10n.shareMessage(playStoreUrl), subject: l10n.appTitle);
            },
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip_outlined),
            title: Text(l10n.privacyPolicy),
            onTap: () {
              Navigator.pop(context);
              launchUrl(Uri.parse(privacyPolicyUrl), mode: LaunchMode.externalApplication);
            },
          ),
          if (AdService().privacyOptionsRequired)
            ListTile(
              leading: const Icon(Icons.manage_accounts_outlined),
              title: Text(l10n.privacySettings),
              onTap: () {
                Navigator.pop(context);
                AdService().showPrivacyOptions();
              },
            ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: Text(l10n.about),
            onTap: () {
              Navigator.pop(context);
              showAboutDialog(
                context: context,
                applicationName: l10n.appTitle,
                applicationVersion: appVersion,
                applicationIcon: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/images/new_logo.png',
                    width: 64,
                    height: 64,
                  ),
                ),
                children: [
                  Text(l10n.aboutText),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
