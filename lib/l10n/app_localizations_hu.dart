// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hungarian (`hu`).
class AppLocalizationsHu extends AppLocalizations {
  AppLocalizationsHu([String locale = 'hu']) : super(locale);

  @override
  String get appTitle => 'Számológép és valuta';

  @override
  String get history => 'Előzmények';

  @override
  String get scientificMode => 'Tudományos mód';

  @override
  String get error => 'Hiba';

  @override
  String get currencies => 'Pénznemek';

  @override
  String get addCurrency => 'Pénznem hozzáadása';

  @override
  String get editCurrencies => 'Lista szerkesztése';

  @override
  String ratesUpdated(String date) {
    return 'Árfolyamok: ExchangeRate-API · $date';
  }

  @override
  String ratesOffline(String date) {
    return 'Offline · ExchangeRate-API árfolyamok ($date)';
  }

  @override
  String get ratesLoadFailed => 'Nem sikerült betölteni az árfolyamokat';

  @override
  String get refreshRates => 'Árfolyamok frissítése';

  @override
  String get retry => 'Újra';

  @override
  String get selectCurrency => 'Pénznem kiválasztása';

  @override
  String get searchCurrency => 'Pénznem keresése...';

  @override
  String get loadingCurrencies => 'Pénznemek betöltése...';

  @override
  String noCurrencyFound(String query) {
    return 'Nincs találat erre: „$query”';
  }

  @override
  String get historyTitle => 'Számítási előzmények';

  @override
  String get clearHistory => 'Előzmények törlése';

  @override
  String get clearHistoryConfirm => 'Biztosan törli az összes előzményt?';

  @override
  String get cancel => 'Mégse';

  @override
  String get clear => 'Törlés';

  @override
  String get clearAll => 'Összes törlése';

  @override
  String get noHistory => 'Még nincsenek számítások';

  @override
  String get noHistoryHint => 'A számítási előzmények itt jelennek meg';

  @override
  String historyLoaded(String expression) {
    return 'Betöltve: $expression';
  }

  @override
  String get settings => 'Beállítások';

  @override
  String get decimalPrecision => 'Tizedes pontosság';

  @override
  String decimalPlaces(int count) {
    return 'Tizedesjegyek száma: $count';
  }

  @override
  String version(String version) {
    return 'Verzió: $version';
  }

  @override
  String get darkMode => 'Sötét mód';

  @override
  String get removeAds => 'Hirdetések eltávolítása';

  @override
  String get oneTimePurchase => 'Egyszeri vásárlás';

  @override
  String oneTimePurchaseWithPrice(String price) {
    return '$price · egyszeri vásárlás';
  }

  @override
  String get adsRemoved => 'Hirdetések eltávolítva';

  @override
  String get thanksForSupport => 'Köszönjük a támogatást!';

  @override
  String get restorePurchases => 'Vásárlások visszaállítása';

  @override
  String get restoringPurchases => 'Vásárlások ellenőrzése...';

  @override
  String get storeUnavailable =>
      'Az áruház jelenleg nem érhető el. Próbálja újra később.';

  @override
  String get shareApp => 'Alkalmazás megosztása';

  @override
  String get shareAppSubtitle => 'Ajánlja az alkalmazást ismerőseinek';

  @override
  String shareMessage(String url) {
    return 'Próbáld ki a Calculator & Currency alkalmazást: számológép és valutaváltó egyben!\n\nLetöltés: $url';
  }

  @override
  String get privacyPolicy => 'Adatvédelmi irányelvek';

  @override
  String get privacySettings => 'Adatvédelmi beállítások';

  @override
  String get about => 'Névjegy';

  @override
  String get aboutText => 'Számológép és valutaváltó egy alkalmazásban.';

  @override
  String get earnAdFreeDay => 'Reklámmentes nap szerzése';

  @override
  String adsWatchedProgress(int count, int total) {
    return 'Nézzen meg $total rövid hirdetést · $count/$total megtekintve';
  }

  @override
  String adFreeUntil(String time) {
    return 'Reklámmentes eddig: $time';
  }

  @override
  String get noAdAvailable =>
      'Jelenleg nincs elérhető hirdetés. Próbálja újra kicsit később.';
}
