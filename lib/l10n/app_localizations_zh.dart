// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => '计算器与汇率';

  @override
  String get history => '历史记录';

  @override
  String get scientificMode => '科学模式';

  @override
  String get error => '错误';

  @override
  String get currencies => '货币';

  @override
  String get addCurrency => '添加货币';

  @override
  String get editCurrencies => '编辑列表';

  @override
  String ratesUpdated(String date) {
    return '汇率来源：ExchangeRate-API · $date';
  }

  @override
  String ratesOffline(String date) {
    return '离线 · ExchangeRate-API $date 的汇率';
  }

  @override
  String get ratesLoadFailed => '无法加载汇率';

  @override
  String get refreshRates => '刷新汇率';

  @override
  String get retry => '重试';

  @override
  String get selectCurrency => '选择货币';

  @override
  String get searchCurrency => '搜索货币...';

  @override
  String get loadingCurrencies => '正在加载货币...';

  @override
  String noCurrencyFound(String query) {
    return '未找到与“$query”匹配的货币';
  }

  @override
  String get historyTitle => '计算历史';

  @override
  String get clearHistory => '清除历史记录';

  @override
  String get clearHistoryConfirm => '确定要清除所有历史记录吗？';

  @override
  String get cancel => '取消';

  @override
  String get clear => '清除';

  @override
  String get clearAll => '全部清除';

  @override
  String get noHistory => '暂无计算记录';

  @override
  String get noHistoryHint => '你的计算历史将显示在这里';

  @override
  String historyLoaded(String expression) {
    return '已加载：$expression';
  }

  @override
  String get settings => '设置';

  @override
  String get decimalPrecision => '小数精度';

  @override
  String decimalPlaces(int count) {
    return '小数位数：$count';
  }

  @override
  String version(String version) {
    return '版本 $version';
  }

  @override
  String get darkMode => '深色模式';

  @override
  String get removeAds => '移除广告';

  @override
  String get oneTimePurchase => '一次性购买';

  @override
  String oneTimePurchaseWithPrice(String price) {
    return '$price · 一次性购买';
  }

  @override
  String get adsRemoved => '广告已移除';

  @override
  String get thanksForSupport => '感谢你的支持！';

  @override
  String get restorePurchases => '恢复购买';

  @override
  String get restoringPurchases => '正在检查你的购买记录...';

  @override
  String get storeUnavailable => '商店暂时不可用，请稍后再试。';

  @override
  String get shareApp => '分享应用';

  @override
  String get shareAppSubtitle => '把这款应用推荐给朋友';

  @override
  String shareMessage(String url) {
    return '试试 Calculator & Currency：计算器和货币换算二合一！\n\n下载：$url';
  }

  @override
  String get privacyPolicy => '隐私政策';

  @override
  String get privacySettings => '隐私设置';

  @override
  String get about => '关于';

  @override
  String get aboutText => '集计算器与货币换算于一体的应用。';

  @override
  String get earnAdFreeDay => '获得一天无广告';

  @override
  String adsWatchedProgress(int count, int total) {
    return '观看 $total 个短广告 · 已看 $count/$total';
  }

  @override
  String adFreeUntil(String time) {
    return '无广告至 $time';
  }

  @override
  String get noAdAvailable => '暂无可用广告，请稍后再试。';
}

/// The translations for Chinese, using the Han script (`zh_Hant`).
class AppLocalizationsZhHant extends AppLocalizationsZh {
  AppLocalizationsZhHant() : super('zh_Hant');

  @override
  String get appTitle => '計算機與匯率';

  @override
  String get history => '歷史記錄';

  @override
  String get scientificMode => '科學模式';

  @override
  String get error => '錯誤';

  @override
  String get currencies => '貨幣';

  @override
  String get addCurrency => '新增貨幣';

  @override
  String get editCurrencies => '編輯清單';

  @override
  String ratesUpdated(String date) {
    return '匯率來源：ExchangeRate-API · $date';
  }

  @override
  String ratesOffline(String date) {
    return '離線 · ExchangeRate-API $date 的匯率';
  }

  @override
  String get ratesLoadFailed => '無法載入匯率';

  @override
  String get refreshRates => '重新整理匯率';

  @override
  String get retry => '重試';

  @override
  String get selectCurrency => '選擇貨幣';

  @override
  String get searchCurrency => '搜尋貨幣...';

  @override
  String get loadingCurrencies => '正在載入貨幣...';

  @override
  String noCurrencyFound(String query) {
    return '找不到符合「$query」的貨幣';
  }

  @override
  String get historyTitle => '計算記錄';

  @override
  String get clearHistory => '清除記錄';

  @override
  String get clearHistoryConfirm => '確定要清除所有記錄嗎？';

  @override
  String get cancel => '取消';

  @override
  String get clear => '清除';

  @override
  String get clearAll => '全部清除';

  @override
  String get noHistory => '尚無計算記錄';

  @override
  String get noHistoryHint => '你的計算記錄會顯示在這裡';

  @override
  String historyLoaded(String expression) {
    return '已載入：$expression';
  }

  @override
  String get settings => '設定';

  @override
  String get decimalPrecision => '小數精確度';

  @override
  String decimalPlaces(int count) {
    return '小數位數：$count';
  }

  @override
  String version(String version) {
    return '版本 $version';
  }

  @override
  String get darkMode => '深色模式';

  @override
  String get removeAds => '移除廣告';

  @override
  String get oneTimePurchase => '一次性購買';

  @override
  String oneTimePurchaseWithPrice(String price) {
    return '$price · 一次性購買';
  }

  @override
  String get adsRemoved => '已移除廣告';

  @override
  String get thanksForSupport => '感謝你的支持！';

  @override
  String get restorePurchases => '恢復購買項目';

  @override
  String get restoringPurchases => '正在檢查你的購買項目...';

  @override
  String get storeUnavailable => '目前無法使用商店，請稍後再試。';

  @override
  String get shareApp => '分享應用程式';

  @override
  String get shareAppSubtitle => '推薦這款應用程式給朋友';

  @override
  String shareMessage(String url) {
    return '試試 Calculator & Currency：計算機和匯率換算二合一！\n\n下載：$url';
  }

  @override
  String get privacyPolicy => '隱私權政策';

  @override
  String get privacySettings => '隱私權設定';

  @override
  String get about => '關於';

  @override
  String get aboutText => '結合計算機與匯率換算的應用程式。';

  @override
  String get earnAdFreeDay => '獲得一天無廣告';

  @override
  String adsWatchedProgress(int count, int total) {
    return '觀看 $total 則短廣告 · 已看 $count/$total';
  }

  @override
  String adFreeUntil(String time) {
    return '無廣告至 $time';
  }

  @override
  String get noAdAvailable => '目前沒有可用的廣告，請稍後再試。';
}
