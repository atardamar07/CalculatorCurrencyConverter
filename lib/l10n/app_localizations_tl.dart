// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Tagalog (`tl`).
class AppLocalizationsTl extends AppLocalizations {
  AppLocalizationsTl([String locale = 'tl']) : super(locale);

  @override
  String get appTitle => 'Calculator at Pera';

  @override
  String get history => 'Kasaysayan';

  @override
  String get scientificMode => 'Scientific Mode';

  @override
  String get error => 'Error';

  @override
  String get currencies => 'Mga Currency';

  @override
  String get addCurrency => 'Magdagdag ng currency';

  @override
  String get editCurrencies => 'I-edit ang listahan';

  @override
  String ratesUpdated(String date) {
    return 'Mga rate mula sa ExchangeRate-API · $date';
  }

  @override
  String ratesOffline(String date) {
    return 'Offline · Mga rate ng ExchangeRate-API noong $date';
  }

  @override
  String get ratesLoadFailed => 'Hindi ma-load ang mga exchange rate';

  @override
  String get refreshRates => 'I-refresh ang mga rate';

  @override
  String get retry => 'Subukang muli';

  @override
  String get selectCurrency => 'Pumili ng Currency';

  @override
  String get searchCurrency => 'Maghanap ng currency...';

  @override
  String get loadingCurrencies => 'Nilo-load ang mga currency...';

  @override
  String noCurrencyFound(String query) {
    return 'Walang nahanap na currency para sa \"$query\"';
  }

  @override
  String get historyTitle => 'Kasaysayan ng Kalkulasyon';

  @override
  String get clearHistory => 'I-clear ang Kasaysayan';

  @override
  String get clearHistoryConfirm =>
      'Sigurado ka bang gusto mong i-clear ang buong kasaysayan?';

  @override
  String get cancel => 'Kanselahin';

  @override
  String get clear => 'I-clear';

  @override
  String get clearAll => 'I-clear Lahat';

  @override
  String get noHistory => 'Wala pang kalkulasyon';

  @override
  String get noHistoryHint =>
      'Lalabas dito ang kasaysayan ng iyong mga kalkulasyon';

  @override
  String historyLoaded(String expression) {
    return 'Na-load: $expression';
  }

  @override
  String get settings => 'Mga Setting';

  @override
  String get decimalPrecision => 'Katumpakan ng Decimal';

  @override
  String decimalPlaces(int count) {
    return 'Bilang ng decimal place: $count';
  }

  @override
  String version(String version) {
    return 'Bersyon $version';
  }

  @override
  String get darkMode => 'Dark mode';

  @override
  String get removeAds => 'Alisin ang Mga Ad';

  @override
  String get oneTimePurchase => 'Isang beses na pagbili';

  @override
  String oneTimePurchaseWithPrice(String price) {
    return '$price · isang beses na pagbili';
  }

  @override
  String get adsRemoved => 'Naalis na ang Mga Ad';

  @override
  String get thanksForSupport => 'Salamat sa iyong suporta!';

  @override
  String get restorePurchases => 'I-restore ang Mga Binili';

  @override
  String get restoringPurchases => 'Sinusuri ang iyong mga binili...';

  @override
  String get storeUnavailable =>
      'Hindi available ang store sa ngayon. Pakisubukang muli mamaya.';

  @override
  String get shareApp => 'Ibahagi ang App';

  @override
  String get shareAppSubtitle => 'Ipaalam sa iyong mga kaibigan ang app na ito';

  @override
  String shareMessage(String url) {
    return 'Subukan ang Calculator & Currency: calculator at currency converter sa iisang app!\n\nI-download: $url';
  }

  @override
  String get privacyPolicy => 'Patakaran sa Privacy';

  @override
  String get privacySettings => 'Mga setting ng privacy';

  @override
  String get about => 'Tungkol dito';

  @override
  String get aboutText => 'Calculator at currency converter sa iisang app.';

  @override
  String get earnAdFreeDay => 'Makakuha ng isang araw na walang ad';

  @override
  String adsWatchedProgress(int count, int total) {
    return 'Manood ng $total maiikling ad · $count/$total napanood';
  }

  @override
  String adFreeUntil(String time) {
    return 'Walang ad hanggang $time';
  }

  @override
  String get noAdAvailable =>
      'Walang available na ad sa ngayon. Subukang muli mamaya-maya.';
}
