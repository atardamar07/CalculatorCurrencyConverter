// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Calculatrice & Devises';

  @override
  String get history => 'Historique';

  @override
  String get scientificMode => 'Mode scientifique';

  @override
  String get error => 'Erreur';

  @override
  String get currencies => 'Devises';

  @override
  String get addCurrency => 'Ajouter une devise';

  @override
  String get editCurrencies => 'Modifier la liste';

  @override
  String ratesUpdated(String date) {
    return 'Taux fournis par ExchangeRate-API · $date';
  }

  @override
  String ratesOffline(String date) {
    return 'Hors ligne · taux ExchangeRate-API du $date';
  }

  @override
  String get ratesLoadFailed => 'Impossible de charger les taux de change';

  @override
  String get refreshRates => 'Actualiser les taux';

  @override
  String get retry => 'Réessayer';

  @override
  String get selectCurrency => 'Choisir une devise';

  @override
  String get searchCurrency => 'Rechercher une devise...';

  @override
  String get loadingCurrencies => 'Chargement des devises...';

  @override
  String noCurrencyFound(String query) {
    return 'Aucune devise trouvée pour « $query »';
  }

  @override
  String get historyTitle => 'Historique des calculs';

  @override
  String get clearHistory => 'Effacer l\'historique';

  @override
  String get clearHistoryConfirm =>
      'Voulez-vous vraiment effacer tout l\'historique ?';

  @override
  String get cancel => 'Annuler';

  @override
  String get clear => 'Effacer';

  @override
  String get clearAll => 'Tout effacer';

  @override
  String get noHistory => 'Aucun calcul pour le moment';

  @override
  String get noHistoryHint => 'Votre historique de calculs s\'affichera ici';

  @override
  String historyLoaded(String expression) {
    return 'Chargé : $expression';
  }

  @override
  String get settings => 'Paramètres';

  @override
  String get decimalPrecision => 'Précision décimale';

  @override
  String decimalPlaces(int count) {
    return 'Nombre de décimales : $count';
  }

  @override
  String version(String version) {
    return 'Version $version';
  }

  @override
  String get darkMode => 'Mode sombre';

  @override
  String get removeAds => 'Supprimer les publicités';

  @override
  String get oneTimePurchase => 'Achat unique';

  @override
  String oneTimePurchaseWithPrice(String price) {
    return '$price · achat unique';
  }

  @override
  String get adsRemoved => 'Publicités supprimées';

  @override
  String get thanksForSupport => 'Merci pour votre soutien !';

  @override
  String get restorePurchases => 'Restaurer les achats';

  @override
  String get restoringPurchases => 'Vérification de vos achats...';

  @override
  String get storeUnavailable =>
      'La boutique n\'est pas disponible pour le moment. Veuillez réessayer plus tard.';

  @override
  String get shareApp => 'Partager l\'appli';

  @override
  String get shareAppSubtitle => 'Parlez de cette appli à vos amis';

  @override
  String shareMessage(String url) {
    return 'Découvrez Calculator & Currency : une calculatrice et un convertisseur de devises dans une seule appli !\n\nTélécharger : $url';
  }

  @override
  String get privacyPolicy => 'Politique de confidentialité';

  @override
  String get privacySettings => 'Paramètres de confidentialité';

  @override
  String get about => 'À propos';

  @override
  String get aboutText =>
      'Une calculatrice et un convertisseur de devises dans une seule appli.';

  @override
  String get earnAdFreeDay => 'Gagner une journée sans publicité';

  @override
  String adsWatchedProgress(int count, int total) {
    return 'Regardez $total courtes publicités · $count/$total vues';
  }

  @override
  String adFreeUntil(String time) {
    return 'Sans publicité jusqu\'à $time';
  }

  @override
  String get noAdAvailable =>
      'Aucune publicité disponible pour le moment. Réessayez dans un instant.';
}
