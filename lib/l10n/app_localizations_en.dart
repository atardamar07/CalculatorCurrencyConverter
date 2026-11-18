// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Calculator & Currency';

  @override
  String get history => 'History';

  @override
  String get scientificMode => 'Scientific Mode';

  @override
  String get error => 'Error';

  @override
  String get currencies => 'Currencies';

  @override
  String get addCurrency => 'Add currency';

  @override
  String get editCurrencies => 'Edit list';

  @override
  String ratesUpdated(String date) {
    return 'Rates by ExchangeRate-API · $date';
  }

  @override
  String ratesOffline(String date) {
    return 'Offline · ExchangeRate-API rates from $date';
  }

  @override
  String get ratesLoadFailed => 'Couldn\'t load exchange rates';

  @override
  String get refreshRates => 'Refresh rates';

  @override
  String get retry => 'Retry';

  @override
  String get selectCurrency => 'Select Currency';

  @override
  String get searchCurrency => 'Search currency...';

  @override
  String get loadingCurrencies => 'Loading currencies...';

  @override
  String noCurrencyFound(String query) {
    return 'No currencies found for \"$query\"';
  }

  @override
  String get historyTitle => 'Calculation History';

  @override
  String get clearHistory => 'Clear History';

  @override
  String get clearHistoryConfirm =>
      'Are you sure you want to clear all history?';

  @override
  String get cancel => 'Cancel';

  @override
  String get clear => 'Clear';

  @override
  String get clearAll => 'Clear All';

  @override
  String get noHistory => 'No calculations yet';

  @override
  String get noHistoryHint => 'Your calculation history will appear here';

  @override
  String historyLoaded(String expression) {
    return 'Loaded: $expression';
  }

  @override
  String get settings => 'Settings';

  @override
  String get decimalPrecision => 'Decimal Precision';

  @override
  String decimalPlaces(int count) {
    return 'Number of decimal places: $count';
  }

  @override
  String version(String version) {
    return 'Version $version';
  }

  @override
  String get darkMode => 'Dark mode';

  @override
  String get removeAds => 'Remove Ads';

  @override
  String get oneTimePurchase => 'One-time purchase';

  @override
  String oneTimePurchaseWithPrice(String price) {
    return '$price · one-time purchase';
  }

  @override
  String get adsRemoved => 'Ads Removed';

  @override
  String get thanksForSupport => 'Thank you for your support!';

  @override
  String get restorePurchases => 'Restore Purchases';

  @override
  String get restoringPurchases => 'Checking your purchases...';

  @override
  String get storeUnavailable =>
      'The store is not available right now. Please try again later.';

  @override
  String get shareApp => 'Share App';

  @override
  String get shareAppSubtitle => 'Tell your friends about this app';

  @override
  String shareMessage(String url) {
    return 'Check out Calculator & Currency: a calculator and currency converter in one app!\n\nDownload: $url';
  }

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get privacySettings => 'Privacy settings';

  @override
  String get about => 'About';

  @override
  String get aboutText => 'A calculator and currency converter in one app.';

  @override
  String get earnAdFreeDay => 'Earn an ad-free day';

  @override
  String adsWatchedProgress(int count, int total) {
    return 'Watch $total short ads · $count/$total watched';
  }

  @override
  String adFreeUntil(String time) {
    return 'Ad-free until $time';
  }

  @override
  String get noAdAvailable =>
      'No ad available right now. Try again in a moment.';
}
