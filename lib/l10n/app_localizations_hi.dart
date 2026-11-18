// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'कैलकुलेटर और मुद्रा';

  @override
  String get history => 'इतिहास';

  @override
  String get scientificMode => 'वैज्ञानिक मोड';

  @override
  String get error => 'त्रुटि';

  @override
  String get currencies => 'मुद्राएं';

  @override
  String get addCurrency => 'मुद्रा जोड़ें';

  @override
  String get editCurrencies => 'सूची संपादित करें';

  @override
  String ratesUpdated(String date) {
    return 'ExchangeRate-API की दरें · $date';
  }

  @override
  String ratesOffline(String date) {
    return 'ऑफ़लाइन · $date की ExchangeRate-API दरें';
  }

  @override
  String get ratesLoadFailed => 'विनिमय दरें लोड नहीं हो सकीं';

  @override
  String get refreshRates => 'दरें रीफ़्रेश करें';

  @override
  String get retry => 'फिर से कोशिश करें';

  @override
  String get selectCurrency => 'मुद्रा चुनें';

  @override
  String get searchCurrency => 'मुद्रा खोजें...';

  @override
  String get loadingCurrencies => 'मुद्राएं लोड हो रही हैं...';

  @override
  String noCurrencyFound(String query) {
    return '\"$query\" के लिए कोई मुद्रा नहीं मिली';
  }

  @override
  String get historyTitle => 'गणना इतिहास';

  @override
  String get clearHistory => 'इतिहास साफ़ करें';

  @override
  String get clearHistoryConfirm =>
      'क्या आप वाकई पूरा इतिहास साफ़ करना चाहते हैं?';

  @override
  String get cancel => 'रद्द करें';

  @override
  String get clear => 'साफ़ करें';

  @override
  String get clearAll => 'सब साफ़ करें';

  @override
  String get noHistory => 'अभी तक कोई गणना नहीं';

  @override
  String get noHistoryHint => 'आपका गणना इतिहास यहां दिखाई देगा';

  @override
  String historyLoaded(String expression) {
    return 'लोड किया गया: $expression';
  }

  @override
  String get settings => 'सेटिंग';

  @override
  String get decimalPrecision => 'दशमलव सटीकता';

  @override
  String decimalPlaces(int count) {
    return 'दशमलव स्थानों की संख्या: $count';
  }

  @override
  String version(String version) {
    return 'वर्शन $version';
  }

  @override
  String get darkMode => 'डार्क मोड';

  @override
  String get removeAds => 'विज्ञापन हटाएं';

  @override
  String get oneTimePurchase => 'एक बार की खरीदारी';

  @override
  String oneTimePurchaseWithPrice(String price) {
    return '$price · एक बार की खरीदारी';
  }

  @override
  String get adsRemoved => 'विज्ञापन हटा दिए गए';

  @override
  String get thanksForSupport => 'आपके सहयोग के लिए धन्यवाद!';

  @override
  String get restorePurchases => 'खरीदारी बहाल करें';

  @override
  String get restoringPurchases => 'आपकी खरीदारी जांची जा रही है...';

  @override
  String get storeUnavailable =>
      'स्टोर अभी उपलब्ध नहीं है। कृपया बाद में फिर से कोशिश करें।';

  @override
  String get shareApp => 'ऐप शेयर करें';

  @override
  String get shareAppSubtitle => 'अपने दोस्तों को इस ऐप के बारे में बताएं';

  @override
  String shareMessage(String url) {
    return 'Calculator & Currency आज़माएं: एक ही ऐप में कैलकुलेटर और मुद्रा परिवर्तक!\n\nडाउनलोड करें: $url';
  }

  @override
  String get privacyPolicy => 'निजता नीति';

  @override
  String get privacySettings => 'निजता सेटिंग';

  @override
  String get about => 'ऐप के बारे में';

  @override
  String get aboutText => 'एक ही ऐप में कैलकुलेटर और मुद्रा परिवर्तक।';

  @override
  String get earnAdFreeDay => 'विज्ञापन-मुक्त दिन पाएं';

  @override
  String adsWatchedProgress(int count, int total) {
    return '$total छोटे विज्ञापन देखें · $count/$total देखे गए';
  }

  @override
  String adFreeUntil(String time) {
    return '$time तक विज्ञापन-मुक्त';
  }

  @override
  String get noAdAvailable =>
      'अभी कोई विज्ञापन उपलब्ध नहीं है। थोड़ी देर में फिर से कोशिश करें।';
}
