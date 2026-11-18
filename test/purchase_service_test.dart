import 'dart:async';

import 'package:calculator_currency_converter/services/ad_service.dart';
import 'package:calculator_currency_converter/services/purchase_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:in_app_purchase_android/billing_client_wrappers.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:in_app_purchase_platform_interface/in_app_purchase_platform_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Google Play stand-in: offline until [online] is set. Its restore reports an
// unpaid (pending) purchase as "restored", like the real plugin does.
class FakeStore extends InAppPurchasePlatform {
  bool online = false;
  int restores = 0;
  int completed = 0;
  final _updates = StreamController<List<PurchaseDetails>>.broadcast();

  @override
  Stream<List<PurchaseDetails>> get purchaseStream => _updates.stream;

  @override
  Future<bool> isAvailable() async => true;

  @override
  Future<ProductDetailsResponse> queryProductDetails(
    Set<String> identifiers,
  ) async => ProductDetailsResponse(
    productDetails: [
      if (online)
        ProductDetails(
          id: PurchaseService.removeAdsProductId,
          title: '',
          description: '',
          price: '\$2.99',
          rawPrice: 2.99,
          currencyCode: 'USD',
        ),
    ],
    notFoundIDs: [if (!online) ...identifiers],
  );

  @override
  Future<void> restorePurchases({String? applicationUserName}) async {
    restores++;
    final unpaid = GooglePlayPurchaseDetails.fromPurchase(
      const PurchaseWrapper(
        orderId: '',
        packageName: '',
        purchaseTime: 0,
        purchaseToken: 'token',
        signature: '',
        products: [PurchaseService.removeAdsProductId],
        isAutoRenewing: false,
        originalJson: '',
        isAcknowledged: false,
        purchaseState: PurchaseStateWrapper.pending,
      ),
    );
    _updates.add([for (final p in unpaid) p..status = PurchaseStatus.restored]);
  }

  @override
  Future<bool> buyNonConsumable({required PurchaseParam purchaseParam}) async {
    _updates.add([
      PurchaseDetails(
        productID: purchaseParam.productDetails.id,
        verificationData: PurchaseVerificationData(
          localVerificationData: '',
          serverVerificationData: '',
          source: 'test',
        ),
        transactionDate: null,
        status: PurchaseStatus.purchased,
      )..pendingCompletePurchase = true,
    ]);
    return true;
  }

  @override
  Future<void> completePurchase(PurchaseDetails purchase) async => completed++;
}

void main() {
  test('start checks past purchases, unpaid ones are not delivered, '
      'products load again after an offline start', () async {
    SharedPreferences.setMockInitialValues({});
    debugDefaultTargetPlatformOverride =
        TargetPlatform.fuchsia; // keeps the real plugin out
    addTearDown(() => debugDefaultTargetPlatformOverride = null);
    final store = FakeStore();
    InAppPurchasePlatform.instance = store;

    final purchases = PurchaseService();
    await purchases.initialize(); // offline
    await pumpEventQueue();
    expect(store.restores, 1);
    expect(
      purchases.isPurchased,
      isFalse,
    ); // the restored purchase is not paid yet
    expect(purchases.products, isEmpty);

    store.online = true;
    expect(
      await purchases.buyRemoveAds(),
      isTrue,
    ); // the product list is fetched again
    await pumpEventQueue();
    expect(purchases.isPurchased, isTrue);
    expect(AdService().adsRemoved, isTrue);
    expect(store.completed, 1); // acknowledged, so Google does not refund it
  });
}
