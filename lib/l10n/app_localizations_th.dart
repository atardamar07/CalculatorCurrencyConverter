// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Thai (`th`).
class AppLocalizationsTh extends AppLocalizations {
  AppLocalizationsTh([String locale = 'th']) : super(locale);

  @override
  String get appTitle => 'เครื่องคิดเลขและสกุลเงิน';

  @override
  String get history => 'ประวัติ';

  @override
  String get scientificMode => 'โหมดวิทยาศาสตร์';

  @override
  String get error => 'ข้อผิดพลาด';

  @override
  String get currencies => 'สกุลเงิน';

  @override
  String get addCurrency => 'เพิ่มสกุลเงิน';

  @override
  String get editCurrencies => 'แก้ไขรายการ';

  @override
  String ratesUpdated(String date) {
    return 'อัตราจาก ExchangeRate-API · $date';
  }

  @override
  String ratesOffline(String date) {
    return 'ออฟไลน์ · อัตรา ExchangeRate-API ณ $date';
  }

  @override
  String get ratesLoadFailed => 'โหลดอัตราแลกเปลี่ยนไม่ได้';

  @override
  String get refreshRates => 'รีเฟรชอัตรา';

  @override
  String get retry => 'ลองอีกครั้ง';

  @override
  String get selectCurrency => 'เลือกสกุลเงิน';

  @override
  String get searchCurrency => 'ค้นหาสกุลเงิน...';

  @override
  String get loadingCurrencies => 'กำลังโหลดสกุลเงิน...';

  @override
  String noCurrencyFound(String query) {
    return 'ไม่พบสกุลเงินสำหรับ \"$query\"';
  }

  @override
  String get historyTitle => 'ประวัติการคำนวณ';

  @override
  String get clearHistory => 'ล้างประวัติ';

  @override
  String get clearHistoryConfirm => 'ต้องการล้างประวัติทั้งหมดใช่หรือไม่';

  @override
  String get cancel => 'ยกเลิก';

  @override
  String get clear => 'ล้าง';

  @override
  String get clearAll => 'ล้างทั้งหมด';

  @override
  String get noHistory => 'ยังไม่มีการคำนวณ';

  @override
  String get noHistoryHint => 'ประวัติการคำนวณของคุณจะแสดงที่นี่';

  @override
  String historyLoaded(String expression) {
    return 'โหลดแล้ว: $expression';
  }

  @override
  String get settings => 'การตั้งค่า';

  @override
  String get decimalPrecision => 'ความละเอียดทศนิยม';

  @override
  String decimalPlaces(int count) {
    return 'จำนวนตำแหน่งทศนิยม: $count';
  }

  @override
  String version(String version) {
    return 'เวอร์ชัน $version';
  }

  @override
  String get darkMode => 'โหมดมืด';

  @override
  String get removeAds => 'ลบโฆษณา';

  @override
  String get oneTimePurchase => 'ซื้อครั้งเดียว';

  @override
  String oneTimePurchaseWithPrice(String price) {
    return '$price · ซื้อครั้งเดียว';
  }

  @override
  String get adsRemoved => 'ลบโฆษณาแล้ว';

  @override
  String get thanksForSupport => 'ขอบคุณสำหรับการสนับสนุน!';

  @override
  String get restorePurchases => 'กู้คืนการซื้อ';

  @override
  String get restoringPurchases => 'กำลังตรวจสอบการซื้อของคุณ...';

  @override
  String get storeUnavailable =>
      'ร้านค้าไม่พร้อมใช้งานในขณะนี้ โปรดลองอีกครั้งในภายหลัง';

  @override
  String get shareApp => 'แชร์แอป';

  @override
  String get shareAppSubtitle => 'แนะนำแอปนี้ให้เพื่อนๆ';

  @override
  String shareMessage(String url) {
    return 'ลองใช้ Calculator & Currency: เครื่องคิดเลขและตัวแปลงสกุลเงินในแอปเดียว!\n\nดาวน์โหลด: $url';
  }

  @override
  String get privacyPolicy => 'นโยบายความเป็นส่วนตัว';

  @override
  String get privacySettings => 'การตั้งค่าความเป็นส่วนตัว';

  @override
  String get about => 'เกี่ยวกับ';

  @override
  String get aboutText => 'เครื่องคิดเลขและตัวแปลงสกุลเงินในแอปเดียว';

  @override
  String get earnAdFreeDay => 'รับ 1 วันปลอดโฆษณา';

  @override
  String adsWatchedProgress(int count, int total) {
    return 'ดูโฆษณาสั้น $total รายการ · ดูแล้ว $count/$total';
  }

  @override
  String adFreeUntil(String time) {
    return 'ปลอดโฆษณาจนถึง $time';
  }

  @override
  String get noAdAvailable =>
      'ยังไม่มีโฆษณาในขณะนี้ โปรดลองอีกครั้งในอีกสักครู่';
}
