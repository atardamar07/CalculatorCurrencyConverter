// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get appTitle => 'Kalkulator i waluty';

  @override
  String get history => 'Historia';

  @override
  String get scientificMode => 'Tryb naukowy';

  @override
  String get error => 'Błąd';

  @override
  String get currencies => 'Waluty';

  @override
  String get addCurrency => 'Dodaj walutę';

  @override
  String get editCurrencies => 'Edytuj listę';

  @override
  String ratesUpdated(String date) {
    return 'Kursy z ExchangeRate-API · $date';
  }

  @override
  String ratesOffline(String date) {
    return 'Offline · kursy ExchangeRate-API z $date';
  }

  @override
  String get ratesLoadFailed => 'Nie udało się wczytać kursów walut';

  @override
  String get refreshRates => 'Odśwież kursy';

  @override
  String get retry => 'Spróbuj ponownie';

  @override
  String get selectCurrency => 'Wybierz walutę';

  @override
  String get searchCurrency => 'Szukaj waluty...';

  @override
  String get loadingCurrencies => 'Wczytywanie walut...';

  @override
  String noCurrencyFound(String query) {
    return 'Nie znaleziono walut dla „$query”';
  }

  @override
  String get historyTitle => 'Historia obliczeń';

  @override
  String get clearHistory => 'Wyczyść historię';

  @override
  String get clearHistoryConfirm =>
      'Czy na pewno chcesz wyczyścić całą historię?';

  @override
  String get cancel => 'Anuluj';

  @override
  String get clear => 'Wyczyść';

  @override
  String get clearAll => 'Wyczyść wszystko';

  @override
  String get noHistory => 'Brak obliczeń';

  @override
  String get noHistoryHint => 'Tutaj pojawi się historia Twoich obliczeń';

  @override
  String historyLoaded(String expression) {
    return 'Wczytano: $expression';
  }

  @override
  String get settings => 'Ustawienia';

  @override
  String get decimalPrecision => 'Precyzja dziesiętna';

  @override
  String decimalPlaces(int count) {
    return 'Liczba miejsc po przecinku: $count';
  }

  @override
  String version(String version) {
    return 'Wersja $version';
  }

  @override
  String get darkMode => 'Tryb ciemny';

  @override
  String get removeAds => 'Usuń reklamy';

  @override
  String get oneTimePurchase => 'Jednorazowy zakup';

  @override
  String oneTimePurchaseWithPrice(String price) {
    return '$price · jednorazowy zakup';
  }

  @override
  String get adsRemoved => 'Reklamy usunięte';

  @override
  String get thanksForSupport => 'Dziękujemy za wsparcie!';

  @override
  String get restorePurchases => 'Przywróć zakupy';

  @override
  String get restoringPurchases => 'Sprawdzanie zakupów...';

  @override
  String get storeUnavailable =>
      'Sklep jest teraz niedostępny. Spróbuj ponownie później.';

  @override
  String get shareApp => 'Udostępnij aplikację';

  @override
  String get shareAppSubtitle => 'Poleć tę aplikację znajomym';

  @override
  String shareMessage(String url) {
    return 'Wypróbuj Calculator & Currency: kalkulator i przelicznik walut w jednej aplikacji!\n\nPobierz: $url';
  }

  @override
  String get privacyPolicy => 'Polityka prywatności';

  @override
  String get privacySettings => 'Ustawienia prywatności';

  @override
  String get about => 'O aplikacji';

  @override
  String get aboutText => 'Kalkulator i przelicznik walut w jednej aplikacji.';

  @override
  String get earnAdFreeDay => 'Zdobądź dzień bez reklam';

  @override
  String adsWatchedProgress(int count, int total) {
    return 'Obejrzyj krótkie reklamy · obejrzano $count/$total';
  }

  @override
  String adFreeUntil(String time) {
    return 'Bez reklam do $time';
  }

  @override
  String get noAdAvailable =>
      'Brak dostępnych reklam. Spróbuj ponownie za chwilę.';
}
