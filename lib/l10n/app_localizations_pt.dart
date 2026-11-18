// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Calculadora e Câmbio';

  @override
  String get history => 'Histórico';

  @override
  String get scientificMode => 'Modo científico';

  @override
  String get error => 'Erro';

  @override
  String get currencies => 'Moedas';

  @override
  String get addCurrency => 'Adicionar moeda';

  @override
  String get editCurrencies => 'Editar lista';

  @override
  String ratesUpdated(String date) {
    return 'Cotações da ExchangeRate-API · $date';
  }

  @override
  String ratesOffline(String date) {
    return 'Offline · cotações da ExchangeRate-API de $date';
  }

  @override
  String get ratesLoadFailed => 'Não foi possível carregar as cotações';

  @override
  String get refreshRates => 'Atualizar cotações';

  @override
  String get retry => 'Tentar novamente';

  @override
  String get selectCurrency => 'Selecionar moeda';

  @override
  String get searchCurrency => 'Buscar moeda...';

  @override
  String get loadingCurrencies => 'Carregando moedas...';

  @override
  String noCurrencyFound(String query) {
    return 'Nenhuma moeda encontrada para \"$query\"';
  }

  @override
  String get historyTitle => 'Histórico de cálculos';

  @override
  String get clearHistory => 'Limpar histórico';

  @override
  String get clearHistoryConfirm =>
      'Tem certeza de que deseja limpar todo o histórico?';

  @override
  String get cancel => 'Cancelar';

  @override
  String get clear => 'Limpar';

  @override
  String get clearAll => 'Limpar tudo';

  @override
  String get noHistory => 'Nenhum cálculo ainda';

  @override
  String get noHistoryHint => 'Seu histórico de cálculos aparecerá aqui';

  @override
  String historyLoaded(String expression) {
    return 'Carregado: $expression';
  }

  @override
  String get settings => 'Configurações';

  @override
  String get decimalPrecision => 'Precisão decimal';

  @override
  String decimalPlaces(int count) {
    return 'Número de casas decimais: $count';
  }

  @override
  String version(String version) {
    return 'Versão $version';
  }

  @override
  String get darkMode => 'Modo escuro';

  @override
  String get removeAds => 'Remover anúncios';

  @override
  String get oneTimePurchase => 'Compra única';

  @override
  String oneTimePurchaseWithPrice(String price) {
    return '$price · compra única';
  }

  @override
  String get adsRemoved => 'Anúncios removidos';

  @override
  String get thanksForSupport => 'Obrigado pelo seu apoio!';

  @override
  String get restorePurchases => 'Restaurar compras';

  @override
  String get restoringPurchases => 'Verificando suas compras...';

  @override
  String get storeUnavailable =>
      'A loja não está disponível no momento. Tente novamente mais tarde.';

  @override
  String get shareApp => 'Compartilhar app';

  @override
  String get shareAppSubtitle => 'Indique este app para seus amigos';

  @override
  String shareMessage(String url) {
    return 'Conheça o Calculator & Currency: calculadora e conversor de moedas em um só app!\n\nBaixe: $url';
  }

  @override
  String get privacyPolicy => 'Política de privacidade';

  @override
  String get privacySettings => 'Configurações de privacidade';

  @override
  String get about => 'Sobre';

  @override
  String get aboutText => 'Calculadora e conversor de moedas em um só app.';

  @override
  String get earnAdFreeDay => 'Ganhe um dia sem anúncios';

  @override
  String adsWatchedProgress(int count, int total) {
    return 'Assista a $total anúncios curtos · $count/$total assistidos';
  }

  @override
  String adFreeUntil(String time) {
    return 'Sem anúncios até $time';
  }

  @override
  String get noAdAvailable =>
      'Nenhum anúncio disponível agora. Tente novamente em instantes.';
}
