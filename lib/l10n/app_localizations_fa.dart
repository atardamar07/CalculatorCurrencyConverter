// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Persian (`fa`).
class AppLocalizationsFa extends AppLocalizations {
  AppLocalizationsFa([String locale = 'fa']) : super(locale);

  @override
  String get appTitle => 'ماشین‌حساب و ارز';

  @override
  String get history => 'تاریخچه';

  @override
  String get scientificMode => 'حالت علمی';

  @override
  String get error => 'خطا';

  @override
  String get currencies => 'ارزها';

  @override
  String get addCurrency => 'افزودن ارز';

  @override
  String get editCurrencies => 'ویرایش فهرست';

  @override
  String ratesUpdated(String date) {
    return 'نرخ‌ها از ExchangeRate-API · $date';
  }

  @override
  String ratesOffline(String date) {
    return 'آفلاین · نرخ‌های ExchangeRate-API مربوط به $date';
  }

  @override
  String get ratesLoadFailed => 'بارگیری نرخ‌های ارز ممکن نشد';

  @override
  String get refreshRates => 'به‌روزرسانی نرخ‌ها';

  @override
  String get retry => 'تلاش دوباره';

  @override
  String get selectCurrency => 'انتخاب ارز';

  @override
  String get searchCurrency => 'جستجوی ارز...';

  @override
  String get loadingCurrencies => 'در حال بارگیری ارزها...';

  @override
  String noCurrencyFound(String query) {
    return 'ارزی برای «$query» پیدا نشد';
  }

  @override
  String get historyTitle => 'تاریخچه محاسبات';

  @override
  String get clearHistory => 'پاک کردن تاریخچه';

  @override
  String get clearHistoryConfirm =>
      'آیا مطمئنید می‌خواهید کل تاریخچه را پاک کنید؟';

  @override
  String get cancel => 'لغو';

  @override
  String get clear => 'پاک کردن';

  @override
  String get clearAll => 'پاک کردن همه';

  @override
  String get noHistory => 'هنوز محاسبه‌ای انجام نشده';

  @override
  String get noHistoryHint => 'تاریخچه محاسبات شما اینجا نمایش داده می‌شود';

  @override
  String historyLoaded(String expression) {
    return 'بارگیری شد: $expression';
  }

  @override
  String get settings => 'تنظیمات';

  @override
  String get decimalPrecision => 'دقت اعشار';

  @override
  String decimalPlaces(int count) {
    return 'تعداد ارقام اعشار: $count';
  }

  @override
  String version(String version) {
    return 'نسخه $version';
  }

  @override
  String get darkMode => 'حالت تیره';

  @override
  String get removeAds => 'حذف تبلیغات';

  @override
  String get oneTimePurchase => 'خرید یک‌باره';

  @override
  String oneTimePurchaseWithPrice(String price) {
    return '$price · خرید یک‌باره';
  }

  @override
  String get adsRemoved => 'تبلیغات حذف شد';

  @override
  String get thanksForSupport => 'از حمایت شما سپاسگزاریم!';

  @override
  String get restorePurchases => 'بازیابی خریدها';

  @override
  String get restoringPurchases => 'در حال بررسی خریدهای شما...';

  @override
  String get storeUnavailable =>
      'فروشگاه در حال حاضر در دسترس نیست. لطفاً بعداً دوباره تلاش کنید.';

  @override
  String get shareApp => 'اشتراک‌گذاری برنامه';

  @override
  String get shareAppSubtitle => 'این برنامه را به دوستانتان معرفی کنید';

  @override
  String shareMessage(String url) {
    return 'Calculator & Currency را امتحان کنید: ماشین‌حساب و مبدل ارز در یک برنامه!\n\nدانلود: $url';
  }

  @override
  String get privacyPolicy => 'سیاست حفظ حریم خصوصی';

  @override
  String get privacySettings => 'تنظیمات حریم خصوصی';

  @override
  String get about => 'درباره برنامه';

  @override
  String get aboutText => 'ماشین‌حساب و مبدل ارز در یک برنامه.';

  @override
  String get earnAdFreeDay => 'یک روز بدون تبلیغ بگیرید';

  @override
  String adsWatchedProgress(int count, int total) {
    return '$total تبلیغ کوتاه ببینید · $count/$total دیده شده';
  }

  @override
  String adFreeUntil(String time) {
    return 'بدون تبلیغ تا $time';
  }

  @override
  String get noAdAvailable =>
      'در حال حاضر تبلیغی موجود نیست. کمی بعد دوباره تلاش کنید.';
}
