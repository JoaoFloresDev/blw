import 'package:flutter/material.dart';
import '../models/food_log.dart';
import '../services/storage_service.dart';
import '../services/photo_service.dart';

class FoodLogProvider extends ChangeNotifier {
  List<FoodLog> _logs = [];
  bool _isLoading = true;

  List<FoodLog> get logs => List.unmodifiable(_logs);
  bool get isLoading => _isLoading;

  FoodLogProvider() {
    _loadLogs();
  }

  Future<void> _loadLogs() async {
    _isLoading = true;
    notifyListeners();

    _logs = await StorageService.loadLogs();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> _saveLogs() async {
    await StorageService.saveLogs(_logs);
  }

  List<FoodLog> get logsSortedByDate {
    final sorted = List<FoodLog>.from(_logs);
    sorted.sort((a, b) => b.date.compareTo(a.date));
    return sorted;
  }

  Set<String> get introducedFoodIds {
    return _logs.map((log) => log.foodId).toSet();
  }

  int get totalPhotosCount {
    return _logs.fold(0, (sum, log) => sum + log.photosPaths.length);
  }

  List<PhotoItem> get allPhotos {
    final List<PhotoItem> photos = [];
    for (final log in _logs) {
      for (final path in log.photosPaths) {
        if (PhotoService.photoExists(path)) {
          photos.add(PhotoItem(
            path: path,
            foodName: log.foodName,
            foodId: log.foodId,
            date: log.date,
            logId: log.id,
            acceptance: log.acceptance,
            reaction: log.reaction,
            notes: log.notes,
          ));
        }
      }
    }
    photos.sort((a, b) => b.date.compareTo(a.date));
    return photos;
  }

  bool isFirstTimeForFood(String foodId) {
    return !_logs.any((log) => log.foodId == foodId);
  }

  Future<bool> addLog(FoodLog log) async {
    final isFirstTime = isFirstTimeForFood(log.foodId);
    _logs.add(log);
    await _saveLogs();
    notifyListeners();
    return isFirstTime;
  }

  Future<void> removeLog(String id) async {
    final log = _logs.firstWhere((l) => l.id == id);
    // Delete associated photos
    for (final path in log.photosPaths) {
      await PhotoService.deletePhoto(path);
    }
    _logs.removeWhere((log) => log.id == id);
    await _saveLogs();
    notifyListeners();
  }

  Future<void> updateLog(FoodLog updatedLog) async {
    final index = _logs.indexWhere((log) => log.id == updatedLog.id);
    if (index != -1) {
      _logs[index] = updatedLog;
      await _saveLogs();
      notifyListeners();
    }
  }

  Future<void> addPhotoToLog(String logId, String photoPath) async {
    final index = _logs.indexWhere((log) => log.id == logId);
    if (index != -1) {
      final log = _logs[index];
      final updatedPhotos = [...log.photosPaths, photoPath];
      _logs[index] = log.copyWith(photosPaths: updatedPhotos);
      await _saveLogs();
      notifyListeners();
    }
  }

  Future<void> removePhotoFromLog(String logId, String photoPath) async {
    final index = _logs.indexWhere((log) => log.id == logId);
    if (index != -1) {
      final log = _logs[index];
      await PhotoService.deletePhoto(photoPath);
      final updatedPhotos =
          log.photosPaths.where((p) => p != photoPath).toList();
      _logs[index] = log.copyWith(photosPaths: updatedPhotos);
      await _saveLogs();
      notifyListeners();
    }
  }

  List<FoodLog> getLogsForFood(String foodId) {
    return _logs.where((log) => log.foodId == foodId).toList();
  }

  List<FoodLog> getLogsWithReaction() {
    return _logs.where((log) => log.reaction != Reaction.none).toList();
  }

  List<FoodLog> getLogsWithPhotos() {
    return _logs.where((log) => log.photosPaths.isNotEmpty).toList();
  }

  Map<String, int> getFoodFrequency() {
    final Map<String, int> frequency = {};
    for (final log in _logs) {
      frequency[log.foodName] = (frequency[log.foodName] ?? 0) + 1;
    }
    return frequency;
  }
}

class PhotoItem {
  final String path;
  final String foodName;
  final String foodId;
  final DateTime date;
  final String logId;
  final Acceptance acceptance;
  final Reaction reaction;
  final String? notes;

  PhotoItem({
    required this.path,
    required this.foodName,
    required this.foodId,
    required this.date,
    required this.logId,
    required this.acceptance,
    required this.reaction,
    this.notes,
  });
}
