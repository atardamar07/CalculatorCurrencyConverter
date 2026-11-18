// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Калькулятор и валюты';

  @override
  String get history => 'История';

  @override
  String get scientificMode => 'Инженерный режим';

  @override
  String get error => 'Ошибка';

  @override
  String get currencies => 'Валюты';

  @override
  String get addCurrency => 'Добавить валюту';

  @override
  String get editCurrencies => 'Изменить список';

  @override
  String ratesUpdated(String date) {
    return 'Курсы от ExchangeRate-API · $date';
  }

  @override
  String ratesOffline(String date) {
    return 'Офлайн · курсы ExchangeRate-API от $date';
  }

  @override
  String get ratesLoadFailed => 'Не удалось загрузить курсы валют';

  @override
  String get refreshRates => 'Обновить курсы';

  @override
  String get retry => 'Повторить';

  @override
  String get selectCurrency => 'Выбор валюты';

  @override
  String get searchCurrency => 'Поиск валюты...';

  @override
  String get loadingCurrencies => 'Загрузка валют...';

  @override
  String noCurrencyFound(String query) {
    return 'По запросу «$query» ничего не найдено';
  }

  @override
  String get historyTitle => 'История вычислений';

  @override
  String get clearHistory => 'Очистить историю';

  @override
  String get clearHistoryConfirm =>
      'Вы уверены, что хотите очистить всю историю?';

  @override
  String get cancel => 'Отмена';

  @override
  String get clear => 'Очистить';

  @override
  String get clearAll => 'Очистить всё';

  @override
  String get noHistory => 'Вычислений пока нет';

  @override
  String get noHistoryHint => 'Здесь появится история ваших вычислений';

  @override
  String historyLoaded(String expression) {
    return 'Загружено: $expression';
  }

  @override
  String get settings => 'Настройки';

  @override
  String get decimalPrecision => 'Десятичные знаки';

  @override
  String decimalPlaces(int count) {
    return 'Знаков после запятой: $count';
  }

  @override
  String version(String version) {
    return 'Версия $version';
  }

  @override
  String get darkMode => 'Тёмная тема';

  @override
  String get removeAds => 'Отключить рекламу';

  @override
  String get oneTimePurchase => 'Разовая покупка';

  @override
  String oneTimePurchaseWithPrice(String price) {
    return '$price · разовая покупка';
  }

  @override
  String get adsRemoved => 'Реклама отключена';

  @override
  String get thanksForSupport => 'Спасибо за поддержку!';

  @override
  String get restorePurchases => 'Восстановить покупки';

  @override
  String get restoringPurchases => 'Проверяем ваши покупки...';

  @override
  String get storeUnavailable =>
      'Магазин сейчас недоступен. Повторите попытку позже.';

  @override
  String get shareApp => 'Поделиться приложением';

  @override
  String get shareAppSubtitle => 'Расскажите друзьям об этом приложении';

  @override
  String shareMessage(String url) {
    return 'Попробуйте Calculator & Currency: калькулятор и конвертер валют в одном приложении!\n\nСкачать: $url';
  }

  @override
  String get privacyPolicy => 'Политика конфиденциальности';

  @override
  String get privacySettings => 'Настройки конфиденциальности';

  @override
  String get about => 'О приложении';

  @override
  String get aboutText => 'Калькулятор и конвертер валют в одном приложении.';

  @override
  String get earnAdFreeDay => 'Получить день без рекламы';

  @override
  String adsWatchedProgress(int count, int total) {
    return 'Посмотрите короткую рекламу · просмотрено $count из $total';
  }

  @override
  String adFreeUntil(String time) {
    return 'Без рекламы до $time';
  }

  @override
  String get noAdAvailable =>
      'Сейчас нет доступной рекламы. Попробуйте чуть позже.';
}
