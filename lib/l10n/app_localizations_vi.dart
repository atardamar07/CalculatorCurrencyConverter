// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get appTitle => 'Máy tính & Tiền tệ';

  @override
  String get history => 'Lịch sử';

  @override
  String get scientificMode => 'Chế độ khoa học';

  @override
  String get error => 'Lỗi';

  @override
  String get currencies => 'Tiền tệ';

  @override
  String get addCurrency => 'Thêm tiền tệ';

  @override
  String get editCurrencies => 'Sửa danh sách';

  @override
  String ratesUpdated(String date) {
    return 'Tỷ giá từ ExchangeRate-API · $date';
  }

  @override
  String ratesOffline(String date) {
    return 'Ngoại tuyến · Tỷ giá ExchangeRate-API ngày $date';
  }

  @override
  String get ratesLoadFailed => 'Không thể tải tỷ giá';

  @override
  String get refreshRates => 'Làm mới tỷ giá';

  @override
  String get retry => 'Thử lại';

  @override
  String get selectCurrency => 'Chọn tiền tệ';

  @override
  String get searchCurrency => 'Tìm tiền tệ...';

  @override
  String get loadingCurrencies => 'Đang tải tiền tệ...';

  @override
  String noCurrencyFound(String query) {
    return 'Không tìm thấy tiền tệ nào cho \"$query\"';
  }

  @override
  String get historyTitle => 'Lịch sử tính toán';

  @override
  String get clearHistory => 'Xóa lịch sử';

  @override
  String get clearHistoryConfirm =>
      'Bạn có chắc muốn xóa toàn bộ lịch sử không?';

  @override
  String get cancel => 'Hủy';

  @override
  String get clear => 'Xóa';

  @override
  String get clearAll => 'Xóa tất cả';

  @override
  String get noHistory => 'Chưa có phép tính nào';

  @override
  String get noHistoryHint => 'Lịch sử tính toán của bạn sẽ hiển thị ở đây';

  @override
  String historyLoaded(String expression) {
    return 'Đã tải: $expression';
  }

  @override
  String get settings => 'Cài đặt';

  @override
  String get decimalPrecision => 'Độ chính xác thập phân';

  @override
  String decimalPlaces(int count) {
    return 'Số chữ số thập phân: $count';
  }

  @override
  String version(String version) {
    return 'Phiên bản $version';
  }

  @override
  String get darkMode => 'Chế độ tối';

  @override
  String get removeAds => 'Xóa quảng cáo';

  @override
  String get oneTimePurchase => 'Mua một lần';

  @override
  String oneTimePurchaseWithPrice(String price) {
    return '$price · mua một lần';
  }

  @override
  String get adsRemoved => 'Đã xóa quảng cáo';

  @override
  String get thanksForSupport => 'Cảm ơn bạn đã ủng hộ!';

  @override
  String get restorePurchases => 'Khôi phục giao dịch mua';

  @override
  String get restoringPurchases => 'Đang kiểm tra giao dịch mua của bạn...';

  @override
  String get storeUnavailable =>
      'Cửa hàng hiện không khả dụng. Vui lòng thử lại sau.';

  @override
  String get shareApp => 'Chia sẻ ứng dụng';

  @override
  String get shareAppSubtitle => 'Giới thiệu ứng dụng này cho bạn bè';

  @override
  String shareMessage(String url) {
    return 'Dùng thử Calculator & Currency: máy tính và công cụ chuyển đổi tiền tệ trong một ứng dụng!\n\nTải xuống: $url';
  }

  @override
  String get privacyPolicy => 'Chính sách quyền riêng tư';

  @override
  String get privacySettings => 'Cài đặt quyền riêng tư';

  @override
  String get about => 'Giới thiệu';

  @override
  String get aboutText =>
      'Máy tính và công cụ chuyển đổi tiền tệ trong một ứng dụng.';

  @override
  String get earnAdFreeDay => 'Nhận một ngày không quảng cáo';

  @override
  String adsWatchedProgress(int count, int total) {
    return 'Xem $total quảng cáo ngắn · Đã xem $count/$total';
  }

  @override
  String adFreeUntil(String time) {
    return 'Không quảng cáo đến $time';
  }

  @override
  String get noAdAvailable =>
      'Hiện chưa có quảng cáo. Vui lòng thử lại sau giây lát.';
}
