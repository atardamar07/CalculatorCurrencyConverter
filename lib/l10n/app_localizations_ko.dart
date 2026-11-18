// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => '계산기 & 환율';

  @override
  String get history => '기록';

  @override
  String get scientificMode => '공학용 모드';

  @override
  String get error => '오류';

  @override
  String get currencies => '통화';

  @override
  String get addCurrency => '통화 추가';

  @override
  String get editCurrencies => '목록 편집';

  @override
  String ratesUpdated(String date) {
    return '환율 제공: ExchangeRate-API · $date';
  }

  @override
  String ratesOffline(String date) {
    return '오프라인 · ExchangeRate-API $date 기준 환율';
  }

  @override
  String get ratesLoadFailed => '환율을 불러올 수 없습니다';

  @override
  String get refreshRates => '환율 새로고침';

  @override
  String get retry => '다시 시도';

  @override
  String get selectCurrency => '통화 선택';

  @override
  String get searchCurrency => '통화 검색...';

  @override
  String get loadingCurrencies => '통화 불러오는 중...';

  @override
  String noCurrencyFound(String query) {
    return '\"$query\"에 해당하는 통화가 없습니다';
  }

  @override
  String get historyTitle => '계산 기록';

  @override
  String get clearHistory => '기록 지우기';

  @override
  String get clearHistoryConfirm => '모든 기록을 지우시겠습니까?';

  @override
  String get cancel => '취소';

  @override
  String get clear => '지우기';

  @override
  String get clearAll => '모두 지우기';

  @override
  String get noHistory => '아직 계산 기록이 없습니다';

  @override
  String get noHistoryHint => '계산 기록이 여기에 표시됩니다';

  @override
  String historyLoaded(String expression) {
    return '불러옴: $expression';
  }

  @override
  String get settings => '설정';

  @override
  String get decimalPrecision => '소수점 정밀도';

  @override
  String decimalPlaces(int count) {
    return '소수점 자릿수: $count';
  }

  @override
  String version(String version) {
    return '버전 $version';
  }

  @override
  String get darkMode => '다크 모드';

  @override
  String get removeAds => '광고 제거';

  @override
  String get oneTimePurchase => '1회 구매';

  @override
  String oneTimePurchaseWithPrice(String price) {
    return '$price · 1회 구매';
  }

  @override
  String get adsRemoved => '광고 제거됨';

  @override
  String get thanksForSupport => '응원해 주셔서 감사합니다!';

  @override
  String get restorePurchases => '구매 복원';

  @override
  String get restoringPurchases => '구매 내역 확인 중...';

  @override
  String get storeUnavailable => '지금은 스토어를 사용할 수 없습니다. 나중에 다시 시도해 주세요.';

  @override
  String get shareApp => '앱 공유';

  @override
  String get shareAppSubtitle => '친구에게 이 앱을 알려 주세요';

  @override
  String shareMessage(String url) {
    return 'Calculator & Currency를 사용해 보세요: 계산기와 환율 변환기를 하나의 앱으로!\n\n다운로드: $url';
  }

  @override
  String get privacyPolicy => '개인정보처리방침';

  @override
  String get privacySettings => '개인정보 설정';

  @override
  String get about => '앱 정보';

  @override
  String get aboutText => '계산기와 환율 변환기를 하나로 담은 앱입니다.';

  @override
  String get earnAdFreeDay => '광고 없는 하루 받기';

  @override
  String adsWatchedProgress(int count, int total) {
    return '짧은 광고 $total개 시청 · $count/$total개 시청함';
  }

  @override
  String adFreeUntil(String time) {
    return '$time까지 광고 없음';
  }

  @override
  String get noAdAvailable => '지금은 볼 수 있는 광고가 없습니다. 잠시 후 다시 시도해 주세요.';
}
