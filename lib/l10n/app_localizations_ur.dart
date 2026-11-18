// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Urdu (`ur`).
class AppLocalizationsUr extends AppLocalizations {
  AppLocalizationsUr([String locale = 'ur']) : super(locale);

  @override
  String get appTitle => 'کیلکولیٹر اور کرنسی';

  @override
  String get history => 'ہسٹری';

  @override
  String get scientificMode => 'سائنسی موڈ';

  @override
  String get error => 'خرابی';

  @override
  String get currencies => 'کرنسیاں';

  @override
  String get addCurrency => 'کرنسی شامل کریں';

  @override
  String get editCurrencies => 'فہرست میں ترمیم کریں';

  @override
  String ratesUpdated(String date) {
    return 'شرحیں بذریعہ ExchangeRate-API · $date';
  }

  @override
  String ratesOffline(String date) {
    return 'آف لائن · ExchangeRate-API کی $date کی شرحیں';
  }

  @override
  String get ratesLoadFailed => 'شرح مبادلہ لوڈ نہیں ہو سکیں';

  @override
  String get refreshRates => 'شرحیں ریفریش کریں';

  @override
  String get retry => 'دوبارہ کوشش کریں';

  @override
  String get selectCurrency => 'کرنسی منتخب کریں';

  @override
  String get searchCurrency => 'کرنسی تلاش کریں...';

  @override
  String get loadingCurrencies => 'کرنسیاں لوڈ ہو رہی ہیں...';

  @override
  String noCurrencyFound(String query) {
    return '\"$query\" کے لیے کوئی کرنسی نہیں ملی';
  }

  @override
  String get historyTitle => 'حسابات کی ہسٹری';

  @override
  String get clearHistory => 'ہسٹری صاف کریں';

  @override
  String get clearHistoryConfirm =>
      'کیا آپ واقعی پوری ہسٹری صاف کرنا چاہتے ہیں؟';

  @override
  String get cancel => 'منسوخ کریں';

  @override
  String get clear => 'صاف کریں';

  @override
  String get clearAll => 'سب صاف کریں';

  @override
  String get noHistory => 'ابھی تک کوئی حساب نہیں';

  @override
  String get noHistoryHint => 'آپ کے حسابات کی ہسٹری یہاں نظر آئے گی';

  @override
  String historyLoaded(String expression) {
    return 'لوڈ ہو گیا: $expression';
  }

  @override
  String get settings => 'ترتیبات';

  @override
  String get decimalPrecision => 'اعشاری درستگی';

  @override
  String decimalPlaces(int count) {
    return 'اعشاری مقامات کی تعداد: $count';
  }

  @override
  String version(String version) {
    return 'ورژن $version';
  }

  @override
  String get darkMode => 'ڈارک موڈ';

  @override
  String get removeAds => 'اشتہارات ہٹائیں';

  @override
  String get oneTimePurchase => 'ایک بار کی خریداری';

  @override
  String oneTimePurchaseWithPrice(String price) {
    return '$price · ایک بار کی خریداری';
  }

  @override
  String get adsRemoved => 'اشتہارات ہٹا دیے گئے';

  @override
  String get thanksForSupport => 'آپ کے تعاون کا شکریہ!';

  @override
  String get restorePurchases => 'خریداریاں بحال کریں';

  @override
  String get restoringPurchases => 'آپ کی خریداریاں چیک کی جا رہی ہیں...';

  @override
  String get storeUnavailable =>
      'اسٹور اس وقت دستیاب نہیں ہے۔ براہ کرم بعد میں دوبارہ کوشش کریں۔';

  @override
  String get shareApp => 'ایپ شیئر کریں';

  @override
  String get shareAppSubtitle => 'اپنے دوستوں کو اس ایپ کے بارے میں بتائیں';

  @override
  String shareMessage(String url) {
    return 'Calculator & Currency آزمائیں: ایک ہی ایپ میں کیلکولیٹر اور کرنسی کنورٹر!\n\nڈاؤن لوڈ کریں: $url';
  }

  @override
  String get privacyPolicy => 'رازداری کی پالیسی';

  @override
  String get privacySettings => 'رازداری کی ترتیبات';

  @override
  String get about => 'ایپ کے بارے میں';

  @override
  String get aboutText => 'ایک ہی ایپ میں کیلکولیٹر اور کرنسی کنورٹر۔';

  @override
  String get earnAdFreeDay => 'اشتہارات کے بغیر ایک دن حاصل کریں';

  @override
  String adsWatchedProgress(int count, int total) {
    return '$total مختصر اشتہارات دیکھیں · $count/$total دیکھے گئے';
  }

  @override
  String adFreeUntil(String time) {
    return '$time تک اشتہارات سے پاک';
  }

  @override
  String get noAdAvailable =>
      'ابھی کوئی اشتہار دستیاب نہیں۔ تھوڑی دیر بعد دوبارہ کوشش کریں۔';
}
