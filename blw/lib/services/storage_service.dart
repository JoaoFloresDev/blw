import 'package:shared_preferences/shared_preferences.dart';
import '../models/food_log.dart';

class StorageService {
  static const String _logsKey = 'food_logs';
  static const String _isPremiumKey = 'is_premium';
  static const String _premiumExpiryKey = 'premium_expiry';
  static const String _onboardingCompleteKey = 'onboarding_complete';

  static Future<void> saveLogs(List<FoodLog> logs) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = FoodLog.encodeList(logs);
    await prefs.setString(_logsKey, jsonString);
  }

  static Future<List<FoodLog>> loadLogs() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_logsKey);
    if (jsonString == null || jsonString.isEmpty) {
      return [];
    }
    try {
      return FoodLog.decodeList(jsonString);
    } catch (e) {
      return [];
    }
  }

  static Future<void> setPremiumStatus(bool isPremium, {DateTime? expiry}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isPremiumKey, isPremium);
    if (expiry != null) {
      await prefs.setString(_premiumExpiryKey, expiry.toIso8601String());
    }
  }

  static Future<bool> isPremium() async {
    final prefs = await SharedPreferences.getInstance();
    final isPremium = prefs.getBool(_isPremiumKey) ?? false;

    if (!isPremium) return false;

    final expiryString = prefs.getString(_premiumExpiryKey);
    if (expiryString != null) {
      final expiry = DateTime.parse(expiryString);
      if (DateTime.now().isAfter(expiry)) {
        await prefs.setBool(_isPremiumKey, false);
        return false;
      }
    }

    return true;
  }

  static Future<DateTime?> getPremiumExpiry() async {
    final prefs = await SharedPreferences.getInstance();
    final expiryString = prefs.getString(_premiumExpiryKey);
    if (expiryString == null) return null;
    return DateTime.parse(expiryString);
  }

  static Future<void> setOnboardingComplete() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingCompleteKey, true);
  }

  static Future<bool> isOnboardingComplete() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_onboardingCompleteKey) ?? false;
  }
}
