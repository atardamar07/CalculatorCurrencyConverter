// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Calculadora y Divisas';

  @override
  String get history => 'Historial';

  @override
  String get scientificMode => 'Modo científico';

  @override
  String get error => 'Error';

  @override
  String get currencies => 'Divisas';

  @override
  String get addCurrency => 'Añadir divisa';

  @override
  String get editCurrencies => 'Editar lista';

  @override
  String ratesUpdated(String date) {
    return 'Cotizaciones de ExchangeRate-API · $date';
  }

  @override
  String ratesOffline(String date) {
    return 'Sin conexión · cotizaciones de ExchangeRate-API del $date';
  }

  @override
  String get ratesLoadFailed => 'No se pudieron cargar las cotizaciones';

  @override
  String get refreshRates => 'Actualizar cotizaciones';

  @override
  String get retry => 'Reintentar';

  @override
  String get selectCurrency => 'Seleccionar divisa';

  @override
  String get searchCurrency => 'Buscar divisa...';

  @override
  String get loadingCurrencies => 'Cargando divisas...';

  @override
  String noCurrencyFound(String query) {
    return 'No se encontraron divisas para \"$query\"';
  }

  @override
  String get historyTitle => 'Historial de cálculos';

  @override
  String get clearHistory => 'Borrar historial';

  @override
  String get clearHistoryConfirm =>
      '¿Seguro que quieres borrar todo el historial?';

  @override
  String get cancel => 'Cancelar';

  @override
  String get clear => 'Borrar';

  @override
  String get clearAll => 'Borrar todo';

  @override
  String get noHistory => 'Aún no hay cálculos';

  @override
  String get noHistoryHint => 'Tu historial de cálculos aparecerá aquí';

  @override
  String historyLoaded(String expression) {
    return 'Cargado: $expression';
  }

  @override
  String get settings => 'Ajustes';

  @override
  String get decimalPrecision => 'Precisión decimal';

  @override
  String decimalPlaces(int count) {
    return 'Número de decimales: $count';
  }

  @override
  String version(String version) {
    return 'Versión $version';
  }

  @override
  String get darkMode => 'Modo oscuro';

  @override
  String get removeAds => 'Quitar anuncios';

  @override
  String get oneTimePurchase => 'Pago único';

  @override
  String oneTimePurchaseWithPrice(String price) {
    return '$price · pago único';
  }

  @override
  String get adsRemoved => 'Anuncios eliminados';

  @override
  String get thanksForSupport => '¡Gracias por tu apoyo!';

  @override
  String get restorePurchases => 'Restaurar compras';

  @override
  String get restoringPurchases => 'Comprobando tus compras...';

  @override
  String get storeUnavailable =>
      'La tienda no está disponible en este momento. Inténtalo de nuevo más tarde.';

  @override
  String get shareApp => 'Compartir app';

  @override
  String get shareAppSubtitle => 'Recomienda esta app a tus amigos';

  @override
  String shareMessage(String url) {
    return 'Prueba Calculator & Currency: ¡calculadora y conversor de divisas en una sola app!\n\nDescárgala: $url';
  }

  @override
  String get privacyPolicy => 'Política de privacidad';

  @override
  String get privacySettings => 'Ajustes de privacidad';

  @override
  String get about => 'Acerca de';

  @override
  String get aboutText => 'Calculadora y conversor de divisas en una sola app.';

  @override
  String get earnAdFreeDay => 'Consigue un día sin anuncios';

  @override
  String adsWatchedProgress(int count, int total) {
    return 'Mira $total anuncios cortos · $count/$total vistos';
  }

  @override
  String adFreeUntil(String time) {
    return 'Sin anuncios hasta $time';
  }

  @override
  String get noAdAvailable =>
      'No hay anuncios disponibles ahora. Vuelve a intentarlo en un momento.';
}
