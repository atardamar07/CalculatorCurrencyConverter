// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get appTitle => 'Kalkulator & Mata Uang';

  @override
  String get history => 'Riwayat';

  @override
  String get scientificMode => 'Mode Ilmiah';

  @override
  String get error => 'Kesalahan';

  @override
  String get currencies => 'Mata Uang';

  @override
  String get addCurrency => 'Tambah mata uang';

  @override
  String get editCurrencies => 'Edit daftar';

  @override
  String ratesUpdated(String date) {
    return 'Kurs dari ExchangeRate-API · $date';
  }

  @override
  String ratesOffline(String date) {
    return 'Offline · Kurs ExchangeRate-API per $date';
  }

  @override
  String get ratesLoadFailed => 'Gagal memuat kurs';

  @override
  String get refreshRates => 'Perbarui kurs';

  @override
  String get retry => 'Coba lagi';

  @override
  String get selectCurrency => 'Pilih Mata Uang';

  @override
  String get searchCurrency => 'Cari mata uang...';

  @override
  String get loadingCurrencies => 'Memuat mata uang...';

  @override
  String noCurrencyFound(String query) {
    return 'Tidak ada mata uang untuk \"$query\"';
  }

  @override
  String get historyTitle => 'Riwayat Perhitungan';

  @override
  String get clearHistory => 'Hapus Riwayat';

  @override
  String get clearHistoryConfirm => 'Yakin ingin menghapus semua riwayat?';

  @override
  String get cancel => 'Batal';

  @override
  String get clear => 'Hapus';

  @override
  String get clearAll => 'Hapus Semua';

  @override
  String get noHistory => 'Belum ada perhitungan';

  @override
  String get noHistoryHint => 'Riwayat perhitungan Anda akan muncul di sini';

  @override
  String historyLoaded(String expression) {
    return 'Dimuat: $expression';
  }

  @override
  String get settings => 'Pengaturan';

  @override
  String get decimalPrecision => 'Presisi Desimal';

  @override
  String decimalPlaces(int count) {
    return 'Jumlah angka desimal: $count';
  }

  @override
  String version(String version) {
    return 'Versi $version';
  }

  @override
  String get darkMode => 'Mode gelap';

  @override
  String get removeAds => 'Hapus Iklan';

  @override
  String get oneTimePurchase => 'Pembelian satu kali';

  @override
  String oneTimePurchaseWithPrice(String price) {
    return '$price · pembelian satu kali';
  }

  @override
  String get adsRemoved => 'Iklan Dihapus';

  @override
  String get thanksForSupport => 'Terima kasih atas dukungan Anda!';

  @override
  String get restorePurchases => 'Pulihkan Pembelian';

  @override
  String get restoringPurchases => 'Memeriksa pembelian Anda...';

  @override
  String get storeUnavailable =>
      'Toko sedang tidak tersedia. Silakan coba lagi nanti.';

  @override
  String get shareApp => 'Bagikan Aplikasi';

  @override
  String get shareAppSubtitle => 'Beri tahu teman tentang aplikasi ini';

  @override
  String shareMessage(String url) {
    return 'Coba Calculator & Currency: kalkulator dan konverter mata uang dalam satu aplikasi!\n\nUnduh: $url';
  }

  @override
  String get privacyPolicy => 'Kebijakan Privasi';

  @override
  String get privacySettings => 'Pengaturan privasi';

  @override
  String get about => 'Tentang';

  @override
  String get aboutText =>
      'Kalkulator dan konverter mata uang dalam satu aplikasi.';

  @override
  String get earnAdFreeDay => 'Dapatkan sehari tanpa iklan';

  @override
  String adsWatchedProgress(int count, int total) {
    return 'Tonton $total iklan singkat · $count/$total ditonton';
  }

  @override
  String adFreeUntil(String time) {
    return 'Bebas iklan hingga $time';
  }

  @override
  String get noAdAvailable =>
      'Belum ada iklan tersedia. Coba lagi sebentar lagi.';
}
