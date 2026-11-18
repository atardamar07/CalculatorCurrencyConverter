// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'Calcolatrice e Valute';

  @override
  String get history => 'Cronologia';

  @override
  String get scientificMode => 'Modalità scientifica';

  @override
  String get error => 'Errore';

  @override
  String get currencies => 'Valute';

  @override
  String get addCurrency => 'Aggiungi valuta';

  @override
  String get editCurrencies => 'Modifica elenco';

  @override
  String ratesUpdated(String date) {
    return 'Tassi forniti da ExchangeRate-API · $date';
  }

  @override
  String ratesOffline(String date) {
    return 'Offline · tassi ExchangeRate-API del $date';
  }

  @override
  String get ratesLoadFailed => 'Impossibile caricare i tassi di cambio';

  @override
  String get refreshRates => 'Aggiorna tassi';

  @override
  String get retry => 'Riprova';

  @override
  String get selectCurrency => 'Seleziona valuta';

  @override
  String get searchCurrency => 'Cerca valuta...';

  @override
  String get loadingCurrencies => 'Caricamento valute...';

  @override
  String noCurrencyFound(String query) {
    return 'Nessuna valuta trovata per \"$query\"';
  }

  @override
  String get historyTitle => 'Cronologia calcoli';

  @override
  String get clearHistory => 'Cancella cronologia';

  @override
  String get clearHistoryConfirm =>
      'Vuoi davvero cancellare tutta la cronologia?';

  @override
  String get cancel => 'Annulla';

  @override
  String get clear => 'Cancella';

  @override
  String get clearAll => 'Cancella tutto';

  @override
  String get noHistory => 'Ancora nessun calcolo';

  @override
  String get noHistoryHint => 'La cronologia dei calcoli apparirà qui';

  @override
  String historyLoaded(String expression) {
    return 'Caricato: $expression';
  }

  @override
  String get settings => 'Impostazioni';

  @override
  String get decimalPrecision => 'Precisione decimale';

  @override
  String decimalPlaces(int count) {
    return 'Numero di decimali: $count';
  }

  @override
  String version(String version) {
    return 'Versione $version';
  }

  @override
  String get darkMode => 'Modalità scura';

  @override
  String get removeAds => 'Rimuovi pubblicità';

  @override
  String get oneTimePurchase => 'Acquisto una tantum';

  @override
  String oneTimePurchaseWithPrice(String price) {
    return '$price · acquisto una tantum';
  }

  @override
  String get adsRemoved => 'Pubblicità rimossa';

  @override
  String get thanksForSupport => 'Grazie per il tuo supporto!';

  @override
  String get restorePurchases => 'Ripristina acquisti';

  @override
  String get restoringPurchases => 'Verifica degli acquisti in corso...';

  @override
  String get storeUnavailable =>
      'Lo store non è disponibile al momento. Riprova più tardi.';

  @override
  String get shareApp => 'Condividi app';

  @override
  String get shareAppSubtitle => 'Consiglia questa app ai tuoi amici';

  @override
  String shareMessage(String url) {
    return 'Prova Calculator & Currency: calcolatrice e convertitore di valute in un\'unica app!\n\nScaricala: $url';
  }

  @override
  String get privacyPolicy => 'Informativa sulla privacy';

  @override
  String get privacySettings => 'Impostazioni privacy';

  @override
  String get about => 'Informazioni';

  @override
  String get aboutText =>
      'Calcolatrice e convertitore di valute in un\'unica app.';

  @override
  String get earnAdFreeDay => 'Ottieni un giorno senza pubblicità';

  @override
  String adsWatchedProgress(int count, int total) {
    return 'Guarda $total brevi annunci · $count/$total visti';
  }

  @override
  String adFreeUntil(String time) {
    return 'Senza pubblicità fino a $time';
  }

  @override
  String get noAdAvailable =>
      'Nessun annuncio disponibile al momento. Riprova tra poco.';
}
