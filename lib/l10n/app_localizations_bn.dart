// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bengali Bangla (`bn`).
class AppLocalizationsBn extends AppLocalizations {
  AppLocalizationsBn([String locale = 'bn']) : super(locale);

  @override
  String get appTitle => 'ক্যালকুলেটর ও মুদ্রা';

  @override
  String get history => 'ইতিহাস';

  @override
  String get scientificMode => 'বৈজ্ঞানিক মোড';

  @override
  String get error => 'ত্রুটি';

  @override
  String get currencies => 'মুদ্রা';

  @override
  String get addCurrency => 'মুদ্রা যোগ করুন';

  @override
  String get editCurrencies => 'তালিকা সম্পাদনা করুন';

  @override
  String ratesUpdated(String date) {
    return 'ExchangeRate-API-এর বিনিময় হার · $date';
  }

  @override
  String ratesOffline(String date) {
    return 'অফলাইন · $date তারিখের ExchangeRate-API হার';
  }

  @override
  String get ratesLoadFailed => 'বিনিময় হার লোড করা যায়নি';

  @override
  String get refreshRates => 'হার রিফ্রেশ করুন';

  @override
  String get retry => 'আবার চেষ্টা করুন';

  @override
  String get selectCurrency => 'মুদ্রা বেছে নিন';

  @override
  String get searchCurrency => 'মুদ্রা খুঁজুন...';

  @override
  String get loadingCurrencies => 'মুদ্রা লোড হচ্ছে...';

  @override
  String noCurrencyFound(String query) {
    return '\"$query\"-এর জন্য কোনো মুদ্রা পাওয়া যায়নি';
  }

  @override
  String get historyTitle => 'হিসাবের ইতিহাস';

  @override
  String get clearHistory => 'ইতিহাস মুছুন';

  @override
  String get clearHistoryConfirm =>
      'আপনি কি নিশ্চিত যে সম্পূর্ণ ইতিহাস মুছতে চান?';

  @override
  String get cancel => 'বাতিল';

  @override
  String get clear => 'মুছুন';

  @override
  String get clearAll => 'সব মুছুন';

  @override
  String get noHistory => 'এখনও কোনো হিসাব নেই';

  @override
  String get noHistoryHint => 'আপনার হিসাবের ইতিহাস এখানে দেখা যাবে';

  @override
  String historyLoaded(String expression) {
    return 'লোড হয়েছে: $expression';
  }

  @override
  String get settings => 'সেটিংস';

  @override
  String get decimalPrecision => 'দশমিক নির্ভুলতা';

  @override
  String decimalPlaces(int count) {
    return 'দশমিক স্থানের সংখ্যা: $count';
  }

  @override
  String version(String version) {
    return 'সংস্করণ $version';
  }

  @override
  String get darkMode => 'ডার্ক মোড';

  @override
  String get removeAds => 'বিজ্ঞাপন সরান';

  @override
  String get oneTimePurchase => 'এককালীন কেনাকাটা';

  @override
  String oneTimePurchaseWithPrice(String price) {
    return '$price · এককালীন কেনাকাটা';
  }

  @override
  String get adsRemoved => 'বিজ্ঞাপন সরানো হয়েছে';

  @override
  String get thanksForSupport => 'আপনার সমর্থনের জন্য ধন্যবাদ!';

  @override
  String get restorePurchases => 'কেনাকাটা পুনরুদ্ধার করুন';

  @override
  String get restoringPurchases => 'আপনার কেনাকাটা যাচাই করা হচ্ছে...';

  @override
  String get storeUnavailable =>
      'স্টোর এখন উপলভ্য নয়। অনুগ্রহ করে পরে আবার চেষ্টা করুন।';

  @override
  String get shareApp => 'অ্যাপ শেয়ার করুন';

  @override
  String get shareAppSubtitle => 'বন্ধুদের এই অ্যাপের কথা জানান';

  @override
  String shareMessage(String url) {
    return 'Calculator & Currency ব্যবহার করে দেখুন: একটি অ্যাপেই ক্যালকুলেটর ও মুদ্রা রূপান্তরকারী!\n\nডাউনলোড করুন: $url';
  }

  @override
  String get privacyPolicy => 'গোপনীয়তা নীতি';

  @override
  String get privacySettings => 'গোপনীয়তা সেটিংস';

  @override
  String get about => 'অ্যাপ সম্পর্কে';

  @override
  String get aboutText => 'একটি অ্যাপেই ক্যালকুলেটর ও মুদ্রা রূপান্তরকারী।';

  @override
  String get earnAdFreeDay => 'একটি বিজ্ঞাপনমুক্ত দিন পান';

  @override
  String adsWatchedProgress(int count, int total) {
    return '$totalটি ছোট বিজ্ঞাপন দেখুন · $count/$totalটি দেখা হয়েছে';
  }

  @override
  String adFreeUntil(String time) {
    return '$time পর্যন্ত বিজ্ঞাপনমুক্ত';
  }

  @override
  String get noAdAvailable =>
      'এখন কোনো বিজ্ঞাপন উপলভ্য নেই। একটু পরে আবার চেষ্টা করুন।';
}
