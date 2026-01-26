import 'package:flutter/material.dart';
import '../services/storage_service.dart';

enum PremiumPlan {
  monthly,
  yearly,
  lifetime,
}

extension PremiumPlanExtension on PremiumPlan {
  double get price {
    switch (this) {
      case PremiumPlan.monthly:
        return 4.99;
      case PremiumPlan.yearly:
        return 29.99;
      case PremiumPlan.lifetime:
        return 49.99;
    }
  }

  Duration? get duration {
    switch (this) {
      case PremiumPlan.monthly:
        return const Duration(days: 30);
      case PremiumPlan.yearly:
        return const Duration(days: 365);
      case PremiumPlan.lifetime:
        return null;
    }
  }
}

class PremiumProvider extends ChangeNotifier {
  bool _isPremium = false;
  DateTime? _expiryDate;
  bool _isLoading = true;

  bool get isPremium => _isPremium;
  DateTime? get expiryDate => _expiryDate;
  bool get isLoading => _isLoading;

  // Free tier limits
  static const int freePhotoLimit = 3;
  static const int freeLogLimit = 10;

  PremiumProvider() {
    _loadPremiumStatus();
  }

  Future<void> _loadPremiumStatus() async {
    _isLoading = true;
    notifyListeners();

    _isPremium = await StorageService.isPremium();
    _expiryDate = await StorageService.getPremiumExpiry();

    _isLoading = false;
    notifyListeners();
  }

  Future<bool> purchasePremium(PremiumPlan plan) async {
    // Simulates purchase - in production, integrate with in-app purchases
    try {
      DateTime? expiry;
      if (plan.duration != null) {
        expiry = DateTime.now().add(plan.duration!);
      } else {
        // Lifetime - set expiry far in the future
        expiry = DateTime.now().add(const Duration(days: 36500)); // ~100 years
      }

      await StorageService.setPremiumStatus(true, expiry: expiry);
      _isPremium = true;
      _expiryDate = expiry;
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> restorePurchases() async {
    // In production, implement restore purchases logic
    await _loadPremiumStatus();
  }

  bool canAddMorePhotos(int currentPhotoCount) {
    if (_isPremium) return true;
    return currentPhotoCount < freePhotoLimit;
  }

  bool canAddMoreLogs(int currentLogCount) {
    if (_isPremium) return true;
    return currentLogCount < freeLogLimit;
  }

  int get remainingFreePhotos => freePhotoLimit;
  int get remainingFreeLogs => freeLogLimit;
}
