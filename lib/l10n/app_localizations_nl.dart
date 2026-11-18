// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class AppLocalizationsNl extends AppLocalizations {
  AppLocalizationsNl([String locale = 'nl']) : super(locale);

  @override
  String get appTitle => 'Rekenmachine & Valuta';

  @override
  String get history => 'Geschiedenis';

  @override
  String get scientificMode => 'Wetenschappelijke modus';

  @override
  String get error => 'Fout';

  @override
  String get currencies => 'Valuta\'s';

  @override
  String get addCurrency => 'Valuta toevoegen';

  @override
  String get editCurrencies => 'Lijst bewerken';

  @override
  String ratesUpdated(String date) {
    return 'Koersen van ExchangeRate-API · $date';
  }

  @override
  String ratesOffline(String date) {
    return 'Offline · ExchangeRate-API-koersen van $date';
  }

  @override
  String get ratesLoadFailed => 'Kan wisselkoersen niet laden';

  @override
  String get refreshRates => 'Koersen vernieuwen';

  @override
  String get retry => 'Opnieuw proberen';

  @override
  String get selectCurrency => 'Valuta selecteren';

  @override
  String get searchCurrency => 'Valuta zoeken...';

  @override
  String get loadingCurrencies => 'Valuta\'s laden...';

  @override
  String noCurrencyFound(String query) {
    return 'Geen valuta\'s gevonden voor \"$query\"';
  }

  @override
  String get historyTitle => 'Rekengeschiedenis';

  @override
  String get clearHistory => 'Geschiedenis wissen';

  @override
  String get clearHistoryConfirm =>
      'Weet je zeker dat je de hele geschiedenis wilt wissen?';

  @override
  String get cancel => 'Annuleren';

  @override
  String get clear => 'Wissen';

  @override
  String get clearAll => 'Alles wissen';

  @override
  String get noHistory => 'Nog geen berekeningen';

  @override
  String get noHistoryHint => 'Je rekengeschiedenis verschijnt hier';

  @override
  String historyLoaded(String expression) {
    return 'Geladen: $expression';
  }

  @override
  String get settings => 'Instellingen';

  @override
  String get decimalPrecision => 'Decimale precisie';

  @override
  String decimalPlaces(int count) {
    return 'Aantal decimalen: $count';
  }

  @override
  String version(String version) {
    return 'Versie $version';
  }

  @override
  String get darkMode => 'Donkere modus';

  @override
  String get removeAds => 'Advertenties verwijderen';

  @override
  String get oneTimePurchase => 'Eenmalige aankoop';

  @override
  String oneTimePurchaseWithPrice(String price) {
    return '$price · eenmalige aankoop';
  }

  @override
  String get adsRemoved => 'Advertenties verwijderd';

  @override
  String get thanksForSupport => 'Bedankt voor je steun!';

  @override
  String get restorePurchases => 'Aankopen herstellen';

  @override
  String get restoringPurchases => 'Je aankopen worden gecontroleerd...';

  @override
  String get storeUnavailable =>
      'De store is nu niet beschikbaar. Probeer het later opnieuw.';

  @override
  String get shareApp => 'App delen';

  @override
  String get shareAppSubtitle => 'Vertel je vrienden over deze app';

  @override
  String shareMessage(String url) {
    return 'Probeer Calculator & Currency: een rekenmachine en valutaomrekener in één app!\n\nDownload: $url';
  }

  @override
  String get privacyPolicy => 'Privacybeleid';

  @override
  String get privacySettings => 'Privacy-instellingen';

  @override
  String get about => 'Over';

  @override
  String get aboutText => 'Een rekenmachine en valutaomrekener in één app.';

  @override
  String get earnAdFreeDay => 'Verdien een advertentievrije dag';

  @override
  String adsWatchedProgress(int count, int total) {
    return 'Bekijk $total korte advertenties · $count/$total bekeken';
  }

  @override
  String adFreeUntil(String time) {
    return 'Advertentievrij tot $time';
  }

  @override
  String get noAdAvailable =>
      'Er is nu geen advertentie beschikbaar. Probeer het zo opnieuw.';
}
