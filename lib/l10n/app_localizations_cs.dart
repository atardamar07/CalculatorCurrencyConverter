// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Czech (`cs`).
class AppLocalizationsCs extends AppLocalizations {
  AppLocalizationsCs([String locale = 'cs']) : super(locale);

  @override
  String get appTitle => 'Kalkulačka a měny';

  @override
  String get history => 'Historie';

  @override
  String get scientificMode => 'Vědecký režim';

  @override
  String get error => 'Chyba';

  @override
  String get currencies => 'Měny';

  @override
  String get addCurrency => 'Přidat měnu';

  @override
  String get editCurrencies => 'Upravit seznam';

  @override
  String ratesUpdated(String date) {
    return 'Kurzy od ExchangeRate-API · $date';
  }

  @override
  String ratesOffline(String date) {
    return 'Offline · Kurzy ExchangeRate-API ze dne $date';
  }

  @override
  String get ratesLoadFailed => 'Kurzy se nepodařilo načíst';

  @override
  String get refreshRates => 'Obnovit kurzy';

  @override
  String get retry => 'Zkusit znovu';

  @override
  String get selectCurrency => 'Vyberte měnu';

  @override
  String get searchCurrency => 'Hledat měnu...';

  @override
  String get loadingCurrencies => 'Načítání měn...';

  @override
  String noCurrencyFound(String query) {
    return 'Pro „$query“ nebyly nalezeny žádné měny';
  }

  @override
  String get historyTitle => 'Historie výpočtů';

  @override
  String get clearHistory => 'Vymazat historii';

  @override
  String get clearHistoryConfirm => 'Opravdu chcete vymazat celou historii?';

  @override
  String get cancel => 'Zrušit';

  @override
  String get clear => 'Vymazat';

  @override
  String get clearAll => 'Vymazat vše';

  @override
  String get noHistory => 'Zatím žádné výpočty';

  @override
  String get noHistoryHint => 'Zde se zobrazí historie vašich výpočtů';

  @override
  String historyLoaded(String expression) {
    return 'Načteno: $expression';
  }

  @override
  String get settings => 'Nastavení';

  @override
  String get decimalPrecision => 'Přesnost desetinných míst';

  @override
  String decimalPlaces(int count) {
    return 'Počet desetinných míst: $count';
  }

  @override
  String version(String version) {
    return 'Verze $version';
  }

  @override
  String get darkMode => 'Tmavý režim';

  @override
  String get removeAds => 'Odstranit reklamy';

  @override
  String get oneTimePurchase => 'Jednorázový nákup';

  @override
  String oneTimePurchaseWithPrice(String price) {
    return '$price · jednorázový nákup';
  }

  @override
  String get adsRemoved => 'Reklamy odstraněny';

  @override
  String get thanksForSupport => 'Děkujeme za vaši podporu!';

  @override
  String get restorePurchases => 'Obnovit nákupy';

  @override
  String get restoringPurchases => 'Kontrolujeme vaše nákupy...';

  @override
  String get storeUnavailable =>
      'Obchod teď není dostupný. Zkuste to prosím později.';

  @override
  String get shareApp => 'Sdílet aplikaci';

  @override
  String get shareAppSubtitle => 'Řekněte o aplikaci přátelům';

  @override
  String shareMessage(String url) {
    return 'Vyzkoušej Calculator & Currency: kalkulačka a převodník měn v jedné aplikaci!\n\nStáhnout: $url';
  }

  @override
  String get privacyPolicy => 'Zásady ochrany osobních údajů';

  @override
  String get privacySettings => 'Nastavení soukromí';

  @override
  String get about => 'O aplikaci';

  @override
  String get aboutText => 'Kalkulačka a převodník měn v jedné aplikaci.';

  @override
  String get earnAdFreeDay => 'Získat den bez reklam';

  @override
  String adsWatchedProgress(int count, int total) {
    return 'Zhlédněte $total krátkých reklam · zhlédnuto $count/$total';
  }

  @override
  String adFreeUntil(String time) {
    return 'Bez reklam do $time';
  }

  @override
  String get noAdAvailable =>
      'Teď není k dispozici žádná reklama. Zkuste to za chvíli znovu.';
}
