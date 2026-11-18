// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'Hesap Makinesi & Döviz';

  @override
  String get history => 'Geçmiş';

  @override
  String get scientificMode => 'Bilimsel Mod';

  @override
  String get error => 'Hata';

  @override
  String get currencies => 'Para Birimleri';

  @override
  String get addCurrency => 'Para birimi ekle';

  @override
  String get editCurrencies => 'Listeyi düzenle';

  @override
  String ratesUpdated(String date) {
    return 'Kurlar: ExchangeRate-API · $date';
  }

  @override
  String ratesOffline(String date) {
    return 'Çevrimdışı · ExchangeRate-API, $date kurları';
  }

  @override
  String get ratesLoadFailed => 'Kurlar yüklenemedi';

  @override
  String get refreshRates => 'Kurları yenile';

  @override
  String get retry => 'Tekrar dene';

  @override
  String get selectCurrency => 'Para Birimi Seç';

  @override
  String get searchCurrency => 'Para birimi ara...';

  @override
  String get loadingCurrencies => 'Para birimleri yükleniyor...';

  @override
  String noCurrencyFound(String query) {
    return '\"$query\" için sonuç bulunamadı';
  }

  @override
  String get historyTitle => 'Hesaplama Geçmişi';

  @override
  String get clearHistory => 'Geçmişi Temizle';

  @override
  String get clearHistoryConfirm => 'Tüm geçmiş silinsin mi?';

  @override
  String get cancel => 'İptal';

  @override
  String get clear => 'Temizle';

  @override
  String get clearAll => 'Tümünü Temizle';

  @override
  String get noHistory => 'Henüz hesaplama yok';

  @override
  String get noHistoryHint => 'Hesaplama geçmişin burada görünecek';

  @override
  String historyLoaded(String expression) {
    return 'Yüklendi: $expression';
  }

  @override
  String get settings => 'Ayarlar';

  @override
  String get decimalPrecision => 'Ondalık Hassasiyet';

  @override
  String decimalPlaces(int count) {
    return 'Ondalık basamak sayısı: $count';
  }

  @override
  String version(String version) {
    return 'Sürüm $version';
  }

  @override
  String get darkMode => 'Koyu mod';

  @override
  String get removeAds => 'Reklamları Kaldır';

  @override
  String get oneTimePurchase => 'Tek seferlik ödeme';

  @override
  String oneTimePurchaseWithPrice(String price) {
    return '$price · tek seferlik ödeme';
  }

  @override
  String get adsRemoved => 'Reklamlar Kaldırıldı';

  @override
  String get thanksForSupport => 'Desteğin için teşekkürler!';

  @override
  String get restorePurchases => 'Satın Alımları Geri Yükle';

  @override
  String get restoringPurchases => 'Satın alımların kontrol ediliyor...';

  @override
  String get storeUnavailable =>
      'Mağaza şu anda kullanılamıyor. Lütfen daha sonra tekrar dene.';

  @override
  String get shareApp => 'Uygulamayı Paylaş';

  @override
  String get shareAppSubtitle => 'Arkadaşlarına öner';

  @override
  String shareMessage(String url) {
    return 'Calculator & Currency\'ye göz at: hesap makinesi ve döviz çevirici tek uygulamada!\n\nİndir: $url';
  }

  @override
  String get privacyPolicy => 'Gizlilik Politikası';

  @override
  String get privacySettings => 'Gizlilik ayarları';

  @override
  String get about => 'Hakkında';

  @override
  String get aboutText => 'Hesap makinesi ve döviz çevirici tek uygulamada.';

  @override
  String get earnAdFreeDay => 'Reklamsız gün kazan';

  @override
  String adsWatchedProgress(int count, int total) {
    return '$total kısa reklam izle · $count/$total izlendi';
  }

  @override
  String adFreeUntil(String time) {
    return 'Reklamsız · bitiş: $time';
  }

  @override
  String get noAdAvailable => 'Şu an reklam yok. Biraz sonra tekrar dene.';
}
