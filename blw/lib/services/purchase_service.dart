import 'package:in_app_purchase/in_app_purchase.dart';

/// Low-level wrapper around the native StoreKit / in_app_purchase plugin.
/// Handles product loading, buying, restoring and completing transactions.
/// Entitlement state is owned by [PremiumProvider], not here.
class PurchaseService {
  // MARK: - Singleton
  static final PurchaseService instance = PurchaseService._();
  PurchaseService._();

  // MARK: - Product IDs (must match App Store Connect)
  static const String weeklyId = 'com.bemestar.poc.pro.weekly';
  static const String yearlyId = 'com.bemestar.poc.pro.yearly';

  static Set<String> get productIds => {weeklyId, yearlyId};

  // MARK: - Properties
  final InAppPurchase _iap = InAppPurchase.instance;

  // MARK: - Public Methods
  Future<bool> isAvailable() => _iap.isAvailable();

  Stream<List<PurchaseDetails>> get purchaseStream => _iap.purchaseStream;

  Future<List<ProductDetails>> loadProducts() async {
    final response = await _iap.queryProductDetails(productIds);
    final products = response.productDetails;
    // Cheapest first so weekly renders before yearly.
    products.sort((a, b) => a.rawPrice.compareTo(b.rawPrice));
    return products;
  }

  Future<void> buy(ProductDetails product) async {
    final param = PurchaseParam(productDetails: product);
    // Subscriptions are non-consumable for entitlement purposes.
    await _iap.buyNonConsumable(purchaseParam: param);
  }

  Future<void> restore() => _iap.restorePurchases();

  Future<void> complete(PurchaseDetails purchase) async {
    if (purchase.pendingCompletePurchase) {
      await _iap.completePurchase(purchase);
    }
  }
}
