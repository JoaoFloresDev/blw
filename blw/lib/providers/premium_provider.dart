import 'dart:async';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import '../services/purchase_service.dart';
import '../services/storage_service.dart';

/// Owns the premium entitlement state for the whole app.
/// Backed by [PurchaseService] (native StoreKit). Persists the unlocked
/// flag locally so the gate resolves instantly on next launch while a
/// silent restore re-validates the subscription in the background.
class PremiumProvider extends ChangeNotifier {
  // MARK: - Constants
  /// Free users can attach this many photos per food record.
  static const int freePhotosPerLog = 1;

  // MARK: - Properties
  final PurchaseService _service = PurchaseService.instance;
  StreamSubscription<List<PurchaseDetails>>? _subscription;

  // MARK: - State
  bool _isPremium = false;
  bool _isLoading = true;
  bool _purchasePending = false;
  List<ProductDetails> _products = [];

  // MARK: - Computed Properties
  bool get isPremium => _isPremium;
  bool get isLoading => _isLoading;
  bool get purchasePending => _purchasePending;
  List<ProductDetails> get products => _products;
  bool get hasProducts => _products.isNotEmpty;

  ProductDetails? get weeklyProduct => _productById(PurchaseService.weeklyId);
  ProductDetails? get yearlyProduct => _productById(PurchaseService.yearlyId);

  // MARK: - Lifecycle
  PremiumProvider() {
    _init();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  // MARK: - Public Methods
  /// Returns true when the user is allowed to attach one more photo.
  bool canAddPhoto(int currentPhotoCount) {
    return _isPremium || currentPhotoCount < freePhotosPerLog;
  }

  Future<void> buy(ProductDetails product) async {
    _purchasePending = true;
    notifyListeners();
    try {
      await _service.buy(product);
    } catch (_) {
      _purchasePending = false;
      notifyListeners();
    }
  }

  Future<void> restore() async {
    await _service.restore();
  }

  // MARK: - Private Methods
  Future<void> _init() async {
    // Resolve cached entitlement immediately for a snappy gate.
    _isPremium = await StorageService.isPremium();

    _subscription = _service.purchaseStream.listen(
      _onPurchasesUpdated,
      onDone: () => _subscription?.cancel(),
      onError: (_) {},
    );

    final available = await _service.isAvailable();
    if (available) {
      try {
        _products = await _service.loadProducts();
      } catch (_) {}
      // Silent restore refreshes the entitlement on every launch.
      await _service.restore();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> _onPurchasesUpdated(List<PurchaseDetails> purchases) async {
    for (final purchase in purchases) {
      switch (purchase.status) {
        case PurchaseStatus.pending:
          _purchasePending = true;
          break;
        case PurchaseStatus.purchased:
        case PurchaseStatus.restored:
          await _unlock();
          _purchasePending = false;
          await _service.complete(purchase);
          break;
        case PurchaseStatus.error:
        case PurchaseStatus.canceled:
          _purchasePending = false;
          await _service.complete(purchase);
          break;
      }
    }
    notifyListeners();
  }

  Future<void> _unlock() async {
    _isPremium = true;
    await StorageService.setPremiumStatus(true);
  }

  ProductDetails? _productById(String id) {
    for (final product in _products) {
      if (product.id == id) return product;
    }
    return null;
  }
}
