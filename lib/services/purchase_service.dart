import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PurchaseService extends ChangeNotifier {
  static final PurchaseService _instance = PurchaseService._internal();
  factory PurchaseService() => _instance;
  PurchaseService._internal();

  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  StreamSubscription<List<PurchaseDetails>>? _subscription;
  
  // Product ID - This must match Google Play Console product ID
  static const String removeAdsProductId = 'remove_ads';
  
  bool _isAvailable = false;
  bool _isPurchased = false;
  bool _isLoading = false;
  List<ProductDetails> _products = [];
  String? _errorMessage;
  
  bool get isAvailable => _isAvailable;
  bool get isPurchased => _isPurchased;
  bool get isLoading => _isLoading;
  List<ProductDetails> get products => _products;
  String? get errorMessage => _errorMessage;

  Future<void> initialize() async {
    // Load saved purchase state first
    await _loadPurchaseState();
    
    // Check if store is available
    _isAvailable = await _inAppPurchase.isAvailable();
    if (!_isAvailable) {
      _errorMessage = 'Store not available';
      notifyListeners();
      return;
    }

    // Listen to purchase updates
    _subscription = _inAppPurchase.purchaseStream.listen(
      _onPurchaseUpdate,
      onDone: () {
        _subscription?.cancel();
      },
      onError: (error) {
        _errorMessage = error.toString();
        notifyListeners();
      },
    );

    // Load products
    await _loadProducts();
  }

  Future<void> _loadProducts() async {
    _isLoading = true;
    notifyListeners();

    try {
      const Set<String> productIds = {removeAdsProductId};
      final ProductDetailsResponse response = 
          await _inAppPurchase.queryProductDetails(productIds);
      
      if (response.error != null) {
        _errorMessage = response.error!.message;
      }
      
      if (response.notFoundIDs.isNotEmpty) {
        _errorMessage = 'Product not found: ${response.notFoundIDs.join(', ')}';
      }
      
      _products = response.productDetails;
    } catch (e) {
      _errorMessage = e.toString();
    }
    
    _isLoading = false;
    notifyListeners();
  }

  void _onPurchaseUpdate(List<PurchaseDetails> purchaseDetailsList) {
    for (var purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        // Show loading
        _isLoading = true;
        notifyListeners();
      } else {
        _isLoading = false;
        
        if (purchaseDetails.status == PurchaseStatus.error) {
          _errorMessage = purchaseDetails.error?.message ?? 'Purchase failed';
          notifyListeners();
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
                   purchaseDetails.status == PurchaseStatus.restored) {
          // Verify and deliver purchase
          _deliverPurchase(purchaseDetails);
        }
        
        // Complete purchase if needed
        if (purchaseDetails.pendingCompletePurchase) {
          _inAppPurchase.completePurchase(purchaseDetails);
        }
      }
    }
  }

  void _deliverPurchase(PurchaseDetails purchaseDetails) async {
    if (purchaseDetails.productID == removeAdsProductId) {
      _isPurchased = true;
      await _savePurchaseState();
      notifyListeners();
    }
  }

  Future<void> buyRemoveAds() async {
    if (_products.isEmpty) {
      _errorMessage = 'Product not available';
      notifyListeners();
      return;
    }

    // Find remove ads product
    ProductDetails? product;
    try {
      product = _products.firstWhere((p) => p.id == removeAdsProductId);
    } catch (e) {
      _errorMessage = 'Product not found';
      notifyListeners();
      return;
    }

    // Create purchase param
    final PurchaseParam purchaseParam = PurchaseParam(
      productDetails: product,
    );

    try {
      // Non-consumable purchase (one-time)
      await _inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> restorePurchases() async {
    _isLoading = true;
    notifyListeners();
    
    try {
      await _inAppPurchase.restorePurchases();
    } catch (e) {
      _errorMessage = e.toString();
    }
    
    _isLoading = false;
    notifyListeners();
  }

  Future<void> _loadPurchaseState() async {
    final prefs = await SharedPreferences.getInstance();
    _isPurchased = prefs.getBool('ads_removed') ?? false;
    notifyListeners();
  }

  Future<void> _savePurchaseState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('ads_removed', _isPurchased);
  }

  void dispose() {
    _subscription?.cancel();
  }
}
