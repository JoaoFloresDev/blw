import 'package:flutter/material.dart';

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
  // V1: App is entirely free - all features unlocked
  bool get isPremium => true;
  DateTime? get expiryDate => null;
  bool get isLoading => false;

  PremiumProvider();

  // All features are free in v1
  bool canAddMorePhotos(int currentPhotoCount) => true;
  bool canAddMoreLogs(int currentLogCount) => true;
}
