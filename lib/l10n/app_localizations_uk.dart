// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get appTitle => 'Калькулятор і валюти';

  @override
  String get history => 'Історія';

  @override
  String get scientificMode => 'Інженерний режим';

  @override
  String get error => 'Помилка';

  @override
  String get currencies => 'Валюти';

  @override
  String get addCurrency => 'Додати валюту';

  @override
  String get editCurrencies => 'Змінити список';

  @override
  String ratesUpdated(String date) {
    return 'Курси від ExchangeRate-API · $date';
  }

  @override
  String ratesOffline(String date) {
    return 'Офлайн · курси ExchangeRate-API від $date';
  }

  @override
  String get ratesLoadFailed => 'Не вдалося завантажити курси валют';

  @override
  String get refreshRates => 'Оновити курси';

  @override
  String get retry => 'Повторити';

  @override
  String get selectCurrency => 'Вибір валюти';

  @override
  String get searchCurrency => 'Пошук валюти...';

  @override
  String get loadingCurrencies => 'Завантаження валют...';

  @override
  String noCurrencyFound(String query) {
    return 'За запитом «$query» нічого не знайдено';
  }

  @override
  String get historyTitle => 'Історія обчислень';

  @override
  String get clearHistory => 'Очистити історію';

  @override
  String get clearHistoryConfirm =>
      'Ви впевнені, що хочете очистити всю історію?';

  @override
  String get cancel => 'Скасувати';

  @override
  String get clear => 'Очистити';

  @override
  String get clearAll => 'Очистити все';

  @override
  String get noHistory => 'Обчислень ще немає';

  @override
  String get noHistoryHint => 'Тут з’явиться історія ваших обчислень';

  @override
  String historyLoaded(String expression) {
    return 'Завантажено: $expression';
  }

  @override
  String get settings => 'Налаштування';

  @override
  String get decimalPrecision => 'Десяткові знаки';

  @override
  String decimalPlaces(int count) {
    return 'Знаків після коми: $count';
  }

  @override
  String version(String version) {
    return 'Версія $version';
  }

  @override
  String get darkMode => 'Темна тема';

  @override
  String get removeAds => 'Вимкнути рекламу';

  @override
  String get oneTimePurchase => 'Разова покупка';

  @override
  String oneTimePurchaseWithPrice(String price) {
    return '$price · разова покупка';
  }

  @override
  String get adsRemoved => 'Рекламу вимкнено';

  @override
  String get thanksForSupport => 'Дякуємо за підтримку!';

  @override
  String get restorePurchases => 'Відновити покупки';

  @override
  String get restoringPurchases => 'Перевіряємо ваші покупки...';

  @override
  String get storeUnavailable =>
      'Магазин зараз недоступний. Спробуйте пізніше.';

  @override
  String get shareApp => 'Поділитися застосунком';

  @override
  String get shareAppSubtitle => 'Розкажіть друзям про цей застосунок';

  @override
  String shareMessage(String url) {
    return 'Спробуйте Calculator & Currency: калькулятор і конвертер валют в одному застосунку!\n\nЗавантажити: $url';
  }

  @override
  String get privacyPolicy => 'Політика конфіденційності';

  @override
  String get privacySettings => 'Налаштування конфіденційності';

  @override
  String get about => 'Про застосунок';

  @override
  String get aboutText => 'Калькулятор і конвертер валют в одному застосунку.';

  @override
  String get earnAdFreeDay => 'Отримати день без реклами';

  @override
  String adsWatchedProgress(int count, int total) {
    return 'Перегляньте коротку рекламу · переглянуто $count з $total';
  }

  @override
  String adFreeUntil(String time) {
    return 'Без реклами до $time';
  }

  @override
  String get noAdAvailable =>
      'Зараз немає доступної реклами. Спробуйте трохи згодом.';
}
