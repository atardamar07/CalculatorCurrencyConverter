// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Modern Greek (`el`).
class AppLocalizationsEl extends AppLocalizations {
  AppLocalizationsEl([String locale = 'el']) : super(locale);

  @override
  String get appTitle => 'Αριθμομηχανή & Νομίσματα';

  @override
  String get history => 'Ιστορικό';

  @override
  String get scientificMode => 'Επιστημονική λειτουργία';

  @override
  String get error => 'Σφάλμα';

  @override
  String get currencies => 'Νομίσματα';

  @override
  String get addCurrency => 'Προσθήκη νομίσματος';

  @override
  String get editCurrencies => 'Επεξεργασία λίστας';

  @override
  String ratesUpdated(String date) {
    return 'Ισοτιμίες από ExchangeRate-API · $date';
  }

  @override
  String ratesOffline(String date) {
    return 'Εκτός σύνδεσης · Ισοτιμίες ExchangeRate-API της $date';
  }

  @override
  String get ratesLoadFailed => 'Δεν ήταν δυνατή η φόρτωση των ισοτιμιών';

  @override
  String get refreshRates => 'Ανανέωση ισοτιμιών';

  @override
  String get retry => 'Επανάληψη';

  @override
  String get selectCurrency => 'Επιλογή νομίσματος';

  @override
  String get searchCurrency => 'Αναζήτηση νομίσματος...';

  @override
  String get loadingCurrencies => 'Φόρτωση νομισμάτων...';

  @override
  String noCurrencyFound(String query) {
    return 'Δεν βρέθηκαν νομίσματα για «$query»';
  }

  @override
  String get historyTitle => 'Ιστορικό υπολογισμών';

  @override
  String get clearHistory => 'Εκκαθάριση ιστορικού';

  @override
  String get clearHistoryConfirm =>
      'Θέλετε σίγουρα να διαγράψετε όλο το ιστορικό;';

  @override
  String get cancel => 'Ακύρωση';

  @override
  String get clear => 'Εκκαθάριση';

  @override
  String get clearAll => 'Εκκαθάριση όλων';

  @override
  String get noHistory => 'Δεν υπάρχουν ακόμα υπολογισμοί';

  @override
  String get noHistoryHint => 'Το ιστορικό υπολογισμών σας θα εμφανίζεται εδώ';

  @override
  String historyLoaded(String expression) {
    return 'Φορτώθηκε: $expression';
  }

  @override
  String get settings => 'Ρυθμίσεις';

  @override
  String get decimalPrecision => 'Ακρίβεια δεκαδικών';

  @override
  String decimalPlaces(int count) {
    return 'Αριθμός δεκαδικών ψηφίων: $count';
  }

  @override
  String version(String version) {
    return 'Έκδοση $version';
  }

  @override
  String get darkMode => 'Σκούρο θέμα';

  @override
  String get removeAds => 'Κατάργηση διαφημίσεων';

  @override
  String get oneTimePurchase => 'Εφάπαξ αγορά';

  @override
  String oneTimePurchaseWithPrice(String price) {
    return '$price · εφάπαξ αγορά';
  }

  @override
  String get adsRemoved => 'Οι διαφημίσεις καταργήθηκαν';

  @override
  String get thanksForSupport => 'Σας ευχαριστούμε για την υποστήριξη!';

  @override
  String get restorePurchases => 'Επαναφορά αγορών';

  @override
  String get restoringPurchases => 'Έλεγχος των αγορών σας...';

  @override
  String get storeUnavailable =>
      'Το κατάστημα δεν είναι διαθέσιμο αυτήν τη στιγμή. Δοκιμάστε ξανά αργότερα.';

  @override
  String get shareApp => 'Κοινοποίηση εφαρμογής';

  @override
  String get shareAppSubtitle =>
      'Πείτε στους φίλους σας για αυτήν την εφαρμογή';

  @override
  String shareMessage(String url) {
    return 'Δοκίμασε το Calculator & Currency: αριθμομηχανή και μετατροπέας νομισμάτων σε μία εφαρμογή!\n\nΛήψη: $url';
  }

  @override
  String get privacyPolicy => 'Πολιτική απορρήτου';

  @override
  String get privacySettings => 'Ρυθμίσεις απορρήτου';

  @override
  String get about => 'Σχετικά';

  @override
  String get aboutText =>
      'Αριθμομηχανή και μετατροπέας νομισμάτων σε μία εφαρμογή.';

  @override
  String get earnAdFreeDay => 'Κερδίστε μια μέρα χωρίς διαφημίσεις';

  @override
  String adsWatchedProgress(int count, int total) {
    return 'Δείτε $total σύντομες διαφημίσεις · $count/$total προβλήθηκαν';
  }

  @override
  String adFreeUntil(String time) {
    return 'Χωρίς διαφημίσεις έως $time';
  }

  @override
  String get noAdAvailable =>
      'Δεν υπάρχει διαθέσιμη διαφήμιση αυτήν τη στιγμή. Δοκιμάστε ξανά σε λίγο.';
}
