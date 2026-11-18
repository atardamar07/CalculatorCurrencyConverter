// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swahili (`sw`).
class AppLocalizationsSw extends AppLocalizations {
  AppLocalizationsSw([String locale = 'sw']) : super(locale);

  @override
  String get appTitle => 'Kikokotoo na Sarafu';

  @override
  String get history => 'Historia';

  @override
  String get scientificMode => 'Hali ya Kisayansi';

  @override
  String get error => 'Hitilafu';

  @override
  String get currencies => 'Sarafu';

  @override
  String get addCurrency => 'Ongeza sarafu';

  @override
  String get editCurrencies => 'Hariri orodha';

  @override
  String ratesUpdated(String date) {
    return 'Viwango kutoka ExchangeRate-API · $date';
  }

  @override
  String ratesOffline(String date) {
    return 'Nje ya mtandao · Viwango vya ExchangeRate-API vya $date';
  }

  @override
  String get ratesLoadFailed => 'Imeshindwa kupakia viwango vya ubadilishaji';

  @override
  String get refreshRates => 'Onyesha viwango upya';

  @override
  String get retry => 'Jaribu tena';

  @override
  String get selectCurrency => 'Chagua Sarafu';

  @override
  String get searchCurrency => 'Tafuta sarafu...';

  @override
  String get loadingCurrencies => 'Inapakia sarafu...';

  @override
  String noCurrencyFound(String query) {
    return 'Hakuna sarafu iliyopatikana kwa \"$query\"';
  }

  @override
  String get historyTitle => 'Historia ya Hesabu';

  @override
  String get clearHistory => 'Futa Historia';

  @override
  String get clearHistoryConfirm => 'Una uhakika unataka kufuta historia yote?';

  @override
  String get cancel => 'Ghairi';

  @override
  String get clear => 'Futa';

  @override
  String get clearAll => 'Futa Zote';

  @override
  String get noHistory => 'Bado hakuna hesabu';

  @override
  String get noHistoryHint => 'Historia ya hesabu zako itaonekana hapa';

  @override
  String historyLoaded(String expression) {
    return 'Imepakiwa: $expression';
  }

  @override
  String get settings => 'Mipangilio';

  @override
  String get decimalPrecision => 'Usahihi wa Desimali';

  @override
  String decimalPlaces(int count) {
    return 'Idadi ya nafasi za desimali: $count';
  }

  @override
  String version(String version) {
    return 'Toleo $version';
  }

  @override
  String get darkMode => 'Hali nyeusi';

  @override
  String get removeAds => 'Ondoa Matangazo';

  @override
  String get oneTimePurchase => 'Ununuzi wa mara moja';

  @override
  String oneTimePurchaseWithPrice(String price) {
    return '$price · ununuzi wa mara moja';
  }

  @override
  String get adsRemoved => 'Matangazo Yameondolewa';

  @override
  String get thanksForSupport => 'Asante kwa msaada wako!';

  @override
  String get restorePurchases => 'Rejesha Ununuzi';

  @override
  String get restoringPurchases => 'Inakagua ununuzi wako...';

  @override
  String get storeUnavailable =>
      'Duka halipatikani kwa sasa. Tafadhali jaribu tena baadaye.';

  @override
  String get shareApp => 'Shiriki Programu';

  @override
  String get shareAppSubtitle => 'Waambie marafiki zako kuhusu programu hii';

  @override
  String shareMessage(String url) {
    return 'Jaribu Calculator & Currency: kikokotoo na kibadilisha sarafu katika programu moja!\n\nPakua: $url';
  }

  @override
  String get privacyPolicy => 'Sera ya Faragha';

  @override
  String get privacySettings => 'Mipangilio ya faragha';

  @override
  String get about => 'Kuhusu';

  @override
  String get aboutText =>
      'Kikokotoo na kibadilisha sarafu katika programu moja.';

  @override
  String get earnAdFreeDay => 'Pata siku moja bila matangazo';

  @override
  String adsWatchedProgress(int count, int total) {
    return 'Tazama matangazo mafupi $total · $count/$total yametazamwa';
  }

  @override
  String adFreeUntil(String time) {
    return 'Bila matangazo hadi $time';
  }

  @override
  String get noAdAvailable =>
      'Hakuna tangazo kwa sasa. Jaribu tena baada ya muda mfupi.';
}
