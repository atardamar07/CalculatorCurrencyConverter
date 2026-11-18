// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => '電卓&通貨換算';

  @override
  String get history => '履歴';

  @override
  String get scientificMode => '関数電卓モード';

  @override
  String get error => 'エラー';

  @override
  String get currencies => '通貨';

  @override
  String get addCurrency => '通貨を追加';

  @override
  String get editCurrencies => 'リストを編集';

  @override
  String ratesUpdated(String date) {
    return 'レート提供: ExchangeRate-API · $date';
  }

  @override
  String ratesOffline(String date) {
    return 'オフライン · ExchangeRate-API の $date 時点のレート';
  }

  @override
  String get ratesLoadFailed => '為替レートを読み込めませんでした';

  @override
  String get refreshRates => 'レートを更新';

  @override
  String get retry => '再試行';

  @override
  String get selectCurrency => '通貨を選択';

  @override
  String get searchCurrency => '通貨を検索...';

  @override
  String get loadingCurrencies => '通貨を読み込み中...';

  @override
  String noCurrencyFound(String query) {
    return '「$query」に一致する通貨はありません';
  }

  @override
  String get historyTitle => '計算履歴';

  @override
  String get clearHistory => '履歴を消去';

  @override
  String get clearHistoryConfirm => 'すべての履歴を消去しますか？';

  @override
  String get cancel => 'キャンセル';

  @override
  String get clear => '消去';

  @override
  String get clearAll => 'すべて消去';

  @override
  String get noHistory => 'まだ計算履歴はありません';

  @override
  String get noHistoryHint => 'ここに計算履歴が表示されます';

  @override
  String historyLoaded(String expression) {
    return '読み込みました: $expression';
  }

  @override
  String get settings => '設定';

  @override
  String get decimalPrecision => '小数の精度';

  @override
  String decimalPlaces(int count) {
    return '小数点以下の桁数: $count';
  }

  @override
  String version(String version) {
    return 'バージョン $version';
  }

  @override
  String get darkMode => 'ダークモード';

  @override
  String get removeAds => '広告を削除';

  @override
  String get oneTimePurchase => '買い切り';

  @override
  String oneTimePurchaseWithPrice(String price) {
    return '$price · 買い切り';
  }

  @override
  String get adsRemoved => '広告削除済み';

  @override
  String get thanksForSupport => 'ご支援ありがとうございます！';

  @override
  String get restorePurchases => '購入を復元';

  @override
  String get restoringPurchases => '購入を確認しています...';

  @override
  String get storeUnavailable => '現在ストアを利用できません。しばらくしてからもう一度お試しください。';

  @override
  String get shareApp => 'アプリを共有';

  @override
  String get shareAppSubtitle => '友達にこのアプリを紹介';

  @override
  String shareMessage(String url) {
    return 'Calculator & Currency を試してみて！電卓と通貨換算がひとつになったアプリです。\n\nダウンロード: $url';
  }

  @override
  String get privacyPolicy => 'プライバシーポリシー';

  @override
  String get privacySettings => 'プライバシー設定';

  @override
  String get about => 'このアプリについて';

  @override
  String get aboutText => '電卓と通貨換算がひとつになったアプリです。';

  @override
  String get earnAdFreeDay => '広告なしの1日を獲得';

  @override
  String adsWatchedProgress(int count, int total) {
    return '短い広告を$total本視聴 · $count/$total本視聴済み';
  }

  @override
  String adFreeUntil(String time) {
    return '$timeまで広告なし';
  }

  @override
  String get noAdAvailable => '現在表示できる広告がありません。少し経ってからもう一度お試しください。';
}
