// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Malay (`ms`).
class AppLocalizationsMs extends AppLocalizations {
  AppLocalizationsMs([String locale = 'ms']) : super(locale);

  @override
  String get appTitle => 'Kalkulator & Mata Wang';

  @override
  String get history => 'Sejarah';

  @override
  String get scientificMode => 'Mod Saintifik';

  @override
  String get error => 'Ralat';

  @override
  String get currencies => 'Mata Wang';

  @override
  String get addCurrency => 'Tambah mata wang';

  @override
  String get editCurrencies => 'Edit senarai';

  @override
  String ratesUpdated(String date) {
    return 'Kadar daripada ExchangeRate-API · $date';
  }

  @override
  String ratesOffline(String date) {
    return 'Luar talian · Kadar ExchangeRate-API pada $date';
  }

  @override
  String get ratesLoadFailed => 'Tidak dapat memuatkan kadar pertukaran';

  @override
  String get refreshRates => 'Muat semula kadar';

  @override
  String get retry => 'Cuba lagi';

  @override
  String get selectCurrency => 'Pilih Mata Wang';

  @override
  String get searchCurrency => 'Cari mata wang...';

  @override
  String get loadingCurrencies => 'Memuatkan mata wang...';

  @override
  String noCurrencyFound(String query) {
    return 'Tiada mata wang ditemui untuk \"$query\"';
  }

  @override
  String get historyTitle => 'Sejarah Pengiraan';

  @override
  String get clearHistory => 'Kosongkan Sejarah';

  @override
  String get clearHistoryConfirm =>
      'Adakah anda pasti mahu mengosongkan semua sejarah?';

  @override
  String get cancel => 'Batal';

  @override
  String get clear => 'Kosongkan';

  @override
  String get clearAll => 'Kosongkan Semua';

  @override
  String get noHistory => 'Belum ada pengiraan';

  @override
  String get noHistoryHint => 'Sejarah pengiraan anda akan dipaparkan di sini';

  @override
  String historyLoaded(String expression) {
    return 'Dimuatkan: $expression';
  }

  @override
  String get settings => 'Tetapan';

  @override
  String get decimalPrecision => 'Ketepatan Perpuluhan';

  @override
  String decimalPlaces(int count) {
    return 'Bilangan tempat perpuluhan: $count';
  }

  @override
  String version(String version) {
    return 'Versi $version';
  }

  @override
  String get darkMode => 'Mod gelap';

  @override
  String get removeAds => 'Buang Iklan';

  @override
  String get oneTimePurchase => 'Pembelian sekali sahaja';

  @override
  String oneTimePurchaseWithPrice(String price) {
    return '$price · pembelian sekali sahaja';
  }

  @override
  String get adsRemoved => 'Iklan Dibuang';

  @override
  String get thanksForSupport => 'Terima kasih atas sokongan anda!';

  @override
  String get restorePurchases => 'Pulihkan Pembelian';

  @override
  String get restoringPurchases => 'Menyemak pembelian anda...';

  @override
  String get storeUnavailable =>
      'Kedai tidak tersedia buat masa ini. Sila cuba lagi kemudian.';

  @override
  String get shareApp => 'Kongsi Apl';

  @override
  String get shareAppSubtitle => 'Beritahu rakan anda tentang apl ini';

  @override
  String shareMessage(String url) {
    return 'Cuba Calculator & Currency: kalkulator dan penukar mata wang dalam satu apl!\n\nMuat turun: $url';
  }

  @override
  String get privacyPolicy => 'Dasar Privasi';

  @override
  String get privacySettings => 'Tetapan privasi';

  @override
  String get about => 'Perihal';

  @override
  String get aboutText => 'Kalkulator dan penukar mata wang dalam satu apl.';

  @override
  String get earnAdFreeDay => 'Dapatkan sehari tanpa iklan';

  @override
  String adsWatchedProgress(int count, int total) {
    return 'Tonton $total iklan pendek · $count/$total ditonton';
  }

  @override
  String adFreeUntil(String time) {
    return 'Bebas iklan hingga $time';
  }

  @override
  String get noAdAvailable =>
      'Tiada iklan tersedia sekarang. Cuba lagi sebentar lagi.';
}
