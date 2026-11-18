// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Romanian Moldavian Moldovan (`ro`).
class AppLocalizationsRo extends AppLocalizations {
  AppLocalizationsRo([String locale = 'ro']) : super(locale);

  @override
  String get appTitle => 'Calculator & Valută';

  @override
  String get history => 'Istoric';

  @override
  String get scientificMode => 'Mod științific';

  @override
  String get error => 'Eroare';

  @override
  String get currencies => 'Valute';

  @override
  String get addCurrency => 'Adaugă valută';

  @override
  String get editCurrencies => 'Editează lista';

  @override
  String ratesUpdated(String date) {
    return 'Cursuri de la ExchangeRate-API · $date';
  }

  @override
  String ratesOffline(String date) {
    return 'Offline · Cursuri ExchangeRate-API din $date';
  }

  @override
  String get ratesLoadFailed => 'Nu s-au putut încărca cursurile de schimb';

  @override
  String get refreshRates => 'Actualizează cursurile';

  @override
  String get retry => 'Reîncearcă';

  @override
  String get selectCurrency => 'Selectează valuta';

  @override
  String get searchCurrency => 'Caută valută...';

  @override
  String get loadingCurrencies => 'Se încarcă valutele...';

  @override
  String noCurrencyFound(String query) {
    return 'Nicio valută găsită pentru „$query”';
  }

  @override
  String get historyTitle => 'Istoricul calculelor';

  @override
  String get clearHistory => 'Șterge istoricul';

  @override
  String get clearHistoryConfirm => 'Sigur vrei să ștergi tot istoricul?';

  @override
  String get cancel => 'Anulează';

  @override
  String get clear => 'Șterge';

  @override
  String get clearAll => 'Șterge tot';

  @override
  String get noHistory => 'Niciun calcul încă';

  @override
  String get noHistoryHint => 'Istoricul calculelor tale va apărea aici';

  @override
  String historyLoaded(String expression) {
    return 'Încărcat: $expression';
  }

  @override
  String get settings => 'Setări';

  @override
  String get decimalPrecision => 'Precizie zecimală';

  @override
  String decimalPlaces(int count) {
    return 'Număr de zecimale: $count';
  }

  @override
  String version(String version) {
    return 'Versiunea $version';
  }

  @override
  String get darkMode => 'Mod întunecat';

  @override
  String get removeAds => 'Elimină reclamele';

  @override
  String get oneTimePurchase => 'Plată unică';

  @override
  String oneTimePurchaseWithPrice(String price) {
    return '$price · plată unică';
  }

  @override
  String get adsRemoved => 'Reclame eliminate';

  @override
  String get thanksForSupport => 'Îți mulțumim pentru sprijin!';

  @override
  String get restorePurchases => 'Restabilește achizițiile';

  @override
  String get restoringPurchases => 'Se verifică achizițiile tale...';

  @override
  String get storeUnavailable =>
      'Magazinul nu este disponibil momentan. Încearcă din nou mai târziu.';

  @override
  String get shareApp => 'Distribuie aplicația';

  @override
  String get shareAppSubtitle =>
      'Spune-le prietenilor despre această aplicație';

  @override
  String shareMessage(String url) {
    return 'Descoperă Calculator & Currency: calculator și convertor valutar într-o singură aplicație!\n\nDescarcă: $url';
  }

  @override
  String get privacyPolicy => 'Politica de confidențialitate';

  @override
  String get privacySettings => 'Setări de confidențialitate';

  @override
  String get about => 'Despre';

  @override
  String get aboutText =>
      'Calculator și convertor valutar într-o singură aplicație.';

  @override
  String get earnAdFreeDay => 'Câștigă o zi fără reclame';

  @override
  String adsWatchedProgress(int count, int total) {
    return 'Urmărește $total reclame scurte · $count/$total vizionate';
  }

  @override
  String adFreeUntil(String time) {
    return 'Fără reclame până la $time';
  }

  @override
  String get noAdAvailable =>
      'Nicio reclamă disponibilă acum. Încearcă din nou în câteva momente.';
}
