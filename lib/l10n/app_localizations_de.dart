// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Rechner & Währungen';

  @override
  String get history => 'Verlauf';

  @override
  String get scientificMode => 'Wissenschaftlicher Modus';

  @override
  String get error => 'Fehler';

  @override
  String get currencies => 'Währungen';

  @override
  String get addCurrency => 'Währung hinzufügen';

  @override
  String get editCurrencies => 'Liste bearbeiten';

  @override
  String ratesUpdated(String date) {
    return 'Kurse von ExchangeRate-API · $date';
  }

  @override
  String ratesOffline(String date) {
    return 'Offline · ExchangeRate-API-Kurse vom $date';
  }

  @override
  String get ratesLoadFailed => 'Wechselkurse konnten nicht geladen werden';

  @override
  String get refreshRates => 'Kurse aktualisieren';

  @override
  String get retry => 'Erneut versuchen';

  @override
  String get selectCurrency => 'Währung auswählen';

  @override
  String get searchCurrency => 'Währung suchen...';

  @override
  String get loadingCurrencies => 'Währungen werden geladen...';

  @override
  String noCurrencyFound(String query) {
    return 'Keine Währungen für „$query“ gefunden';
  }

  @override
  String get historyTitle => 'Rechenverlauf';

  @override
  String get clearHistory => 'Verlauf löschen';

  @override
  String get clearHistoryConfirm =>
      'Möchtest du wirklich den gesamten Verlauf löschen?';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get clear => 'Löschen';

  @override
  String get clearAll => 'Alle löschen';

  @override
  String get noHistory => 'Noch keine Berechnungen';

  @override
  String get noHistoryHint => 'Hier erscheint dein Rechenverlauf';

  @override
  String historyLoaded(String expression) {
    return 'Geladen: $expression';
  }

  @override
  String get settings => 'Einstellungen';

  @override
  String get decimalPrecision => 'Dezimalgenauigkeit';

  @override
  String decimalPlaces(int count) {
    return 'Anzahl der Nachkommastellen: $count';
  }

  @override
  String version(String version) {
    return 'Version $version';
  }

  @override
  String get darkMode => 'Dunkler Modus';

  @override
  String get removeAds => 'Werbung entfernen';

  @override
  String get oneTimePurchase => 'Einmaliger Kauf';

  @override
  String oneTimePurchaseWithPrice(String price) {
    return '$price · einmaliger Kauf';
  }

  @override
  String get adsRemoved => 'Werbung entfernt';

  @override
  String get thanksForSupport => 'Danke für deine Unterstützung!';

  @override
  String get restorePurchases => 'Käufe wiederherstellen';

  @override
  String get restoringPurchases => 'Deine Käufe werden geprüft...';

  @override
  String get storeUnavailable =>
      'Der Store ist gerade nicht verfügbar. Bitte versuche es später erneut.';

  @override
  String get shareApp => 'App teilen';

  @override
  String get shareAppSubtitle => 'Empfiehl diese App deinen Freunden';

  @override
  String shareMessage(String url) {
    return 'Probier Calculator & Currency aus: Rechner und Währungsumrechner in einer App!\n\nDownload: $url';
  }

  @override
  String get privacyPolicy => 'Datenschutzerklärung';

  @override
  String get privacySettings => 'Datenschutzeinstellungen';

  @override
  String get about => 'Über die App';

  @override
  String get aboutText => 'Rechner und Währungsumrechner in einer App.';

  @override
  String get earnAdFreeDay => 'Werbefreien Tag freischalten';

  @override
  String adsWatchedProgress(int count, int total) {
    return 'Sieh dir $total kurze Werbevideos an · $count/$total angesehen';
  }

  @override
  String adFreeUntil(String time) {
    return 'Werbefrei bis $time';
  }

  @override
  String get noAdAvailable =>
      'Gerade ist keine Werbung verfügbar. Versuche es gleich noch einmal.';
}
