import 'package:flutter/foundation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/billing_client_wrappers.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ad_service.dart';

class PurchaseService extends ChangeNotifier {
  static final PurchaseService _instance = PurchaseService._internal();
  factory PurchaseService() => _instance;
  PurchaseService._internal();

  // Lazy, so building the widget tree never touches the store plugin.
  late final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  Future<void>? _initialization;

  // Product ID - This must match Google Play Console product ID
  static const String removeAdsProductId = 'remove_ads';

  bool _isAvailable = false;
  bool _isPurchased = false;
  bool _isLoading = false;
  List<ProductDetails> _products = [];

  bool get isPurchased => _isPurchased;
  bool get isLoading => _isLoading;
  List<ProductDetails> get products => _products;

  // Safe to call many times: every caller waits for the same single setup.
  Future<void> initialize() => _initialization ??= _initialize();

  Future<void> _initialize() async {
    // Load saved purchase state first
    await _loadPurchaseState();

    // Check if store is available (false on devices without Google Play)
    try {
      _isAvailable = await _inAppPurchase.isAvailable();
    } catch (e) {
      _isAvailable = false;
    }
    if (!_isAvailable) {
      notifyListeners();
      return;
    }

    // Listen to purchase updates for the whole app lifetime
    _inAppPurchase.purchaseStream.listen(_onPurchaseUpdate);

    // Load products
    await _loadProducts();

    // Purchases that finished while the app was closed (a delayed payment, or the
    // app killed during the purchase sheet) only arrive through this query. Google
    // refunds purchases that stay unacknowledged for 3 days.
    try {
      await _inAppPurchase.restorePurchases();
    } catch (e) {
      // Offline: the next start checks again.
    }
  }

  Future<void> _loadProducts() async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await _inAppPurchase.queryProductDetails({removeAdsProductId});
      _products = response.productDetails;
    } catch (e) {
      _products = [];
    }
    _isLoading = false;
    notifyListeners();
  }

  void _onPurchaseUpdate(List<PurchaseDetails> purchaseDetailsList) {
    for (final purchaseDetails in purchaseDetailsList) {
      // Google's restore also lists purchases that are not paid yet, as "restored".
      final unpaid = purchaseDetails.status == PurchaseStatus.restored &&
          purchaseDetails is GooglePlayPurchaseDetails &&
          purchaseDetails.billingClientPurchase.purchaseState != PurchaseStateWrapper.purchased;
      if (purchaseDetails.status == PurchaseStatus.pending || unpaid) {
        _isLoading = true;
        continue;
      }
      _isLoading = false;
      if (purchaseDetails.status == PurchaseStatus.purchased ||
          purchaseDetails.status == PurchaseStatus.restored) {
        _deliverPurchase(purchaseDetails);
      }
      // Complete purchase if needed (also errors and cancels)
      if (purchaseDetails.pendingCompletePurchase) {
        _inAppPurchase.completePurchase(purchaseDetails);
      }
    }
    notifyListeners();
  }

  // shortcut: purchases are trusted without server-side verification; fine for
  // "remove ads", add verification before selling anything more valuable.
  void _deliverPurchase(PurchaseDetails purchaseDetails) {
    if (purchaseDetails.productID != removeAdsProductId) return;
    _isPurchased = true;
    AdService().setAdsRemoved(true);
    _savePurchaseState();
  }

  // Opens Google Play's purchase sheet; the result arrives on the purchase stream.
  // Returns false when the store or the product is not available.
  Future<bool> buyRemoveAds() async {
    await initialize();
    // After an offline start the list is empty; fetch it again now.
    if (_products.isEmpty && _isAvailable) await _loadProducts();
    final matches = _products.where((p) => p.id == removeAdsProductId);
    if (matches.isEmpty) return false;
    try {
      // Non-consumable purchase (one-time)
      return await _inAppPurchase.buyNonConsumable(
        purchaseParam: PurchaseParam(productDetails: matches.first),
      );
    } catch (e) {
      return false;
    }
  }

  // Restored purchases arrive on the purchase stream like new ones.
  // Returns false when the store is not available.
  Future<bool> restorePurchases() async {
    await initialize();
    if (!_isAvailable) return false;
    try {
      await _inAppPurchase.restorePurchases();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> _loadPurchaseState() async {
    final prefs = await SharedPreferences.getInstance();
    _isPurchased = prefs.getBool('ads_removed') ?? false;
    AdService().setAdsRemoved(_isPurchased);
    notifyListeners();
  }

  Future<void> _savePurchaseState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('ads_removed', _isPurchased);
  }
}
