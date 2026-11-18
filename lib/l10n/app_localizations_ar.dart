// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'الحاسبة والعملات';

  @override
  String get history => 'السجل';

  @override
  String get scientificMode => 'الوضع العلمي';

  @override
  String get error => 'خطأ';

  @override
  String get currencies => 'العملات';

  @override
  String get addCurrency => 'إضافة عملة';

  @override
  String get editCurrencies => 'تعديل القائمة';

  @override
  String ratesUpdated(String date) {
    return 'الأسعار من ExchangeRate-API · $date';
  }

  @override
  String ratesOffline(String date) {
    return 'غير متصل · أسعار ExchangeRate-API بتاريخ $date';
  }

  @override
  String get ratesLoadFailed => 'تعذّر تحميل أسعار الصرف';

  @override
  String get refreshRates => 'تحديث الأسعار';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get selectCurrency => 'اختيار العملة';

  @override
  String get searchCurrency => 'البحث عن عملة...';

  @override
  String get loadingCurrencies => 'جارٍ تحميل العملات...';

  @override
  String noCurrencyFound(String query) {
    return 'لم يتم العثور على عملات تطابق \"$query\"';
  }

  @override
  String get historyTitle => 'سجل العمليات الحسابية';

  @override
  String get clearHistory => 'مسح السجل';

  @override
  String get clearHistoryConfirm => 'هل تريد بالتأكيد مسح السجل بالكامل؟';

  @override
  String get cancel => 'إلغاء';

  @override
  String get clear => 'مسح';

  @override
  String get clearAll => 'مسح الكل';

  @override
  String get noHistory => 'لا توجد عمليات حسابية بعد';

  @override
  String get noHistoryHint => 'سيظهر سجل عملياتك الحسابية هنا';

  @override
  String historyLoaded(String expression) {
    return 'تم التحميل: $expression';
  }

  @override
  String get settings => 'الإعدادات';

  @override
  String get decimalPrecision => 'الدقة العشرية';

  @override
  String decimalPlaces(int count) {
    return 'عدد المنازل العشرية: $count';
  }

  @override
  String version(String version) {
    return 'الإصدار $version';
  }

  @override
  String get darkMode => 'الوضع الداكن';

  @override
  String get removeAds => 'إزالة الإعلانات';

  @override
  String get oneTimePurchase => 'شراء لمرة واحدة';

  @override
  String oneTimePurchaseWithPrice(String price) {
    return '$price · شراء لمرة واحدة';
  }

  @override
  String get adsRemoved => 'تمت إزالة الإعلانات';

  @override
  String get thanksForSupport => 'شكرًا لدعمك!';

  @override
  String get restorePurchases => 'استعادة المشتريات';

  @override
  String get restoringPurchases => 'جارٍ التحقق من مشترياتك...';

  @override
  String get storeUnavailable =>
      'المتجر غير متاح حاليًا. يُرجى المحاولة مرة أخرى لاحقًا.';

  @override
  String get shareApp => 'مشاركة التطبيق';

  @override
  String get shareAppSubtitle => 'أخبر أصدقاءك عن هذا التطبيق';

  @override
  String shareMessage(String url) {
    return 'جرّب Calculator & Currency: حاسبة ومحوّل عملات في تطبيق واحد!\n\nحمّله من هنا: $url';
  }

  @override
  String get privacyPolicy => 'سياسة الخصوصية';

  @override
  String get privacySettings => 'إعدادات الخصوصية';

  @override
  String get about => 'حول التطبيق';

  @override
  String get aboutText => 'حاسبة ومحوّل عملات في تطبيق واحد.';

  @override
  String get earnAdFreeDay => 'احصل على يوم بلا إعلانات';

  @override
  String adsWatchedProgress(int count, int total) {
    return 'شاهد إعلانات قصيرة · تمت مشاهدة $count من $total';
  }

  @override
  String adFreeUntil(String time) {
    return 'بلا إعلانات حتى $time';
  }

  @override
  String get noAdAvailable => 'لا يتوفر إعلان حاليًا. حاول مرة أخرى بعد قليل.';
}
