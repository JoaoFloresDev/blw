import 'dart:convert';

enum Reaction {
  none,
  mild,
  moderate,
  severe,
}

extension ReactionExtension on Reaction {
  String get displayName {
    switch (this) {
      case Reaction.none:
        return 'Sem reacao';
      case Reaction.mild:
        return 'Leve';
      case Reaction.moderate:
        return 'Moderada';
      case Reaction.severe:
        return 'Severa';
    }
  }

  String get icon {
    switch (this) {
      case Reaction.none:
        return '✅';
      case Reaction.mild:
        return '⚠️';
      case Reaction.moderate:
        return '🟠';
      case Reaction.severe:
        return '🔴';
    }
  }
}

enum Acceptance {
  loved,
  liked,
  neutral,
  disliked,
  refused,
}

extension AcceptanceExtension on Acceptance {
  String get displayName {
    switch (this) {
      case Acceptance.loved:
        return 'Amou';
      case Acceptance.liked:
        return 'Gostou';
      case Acceptance.neutral:
        return 'Neutro';
      case Acceptance.disliked:
        return 'Nao gostou';
      case Acceptance.refused:
        return 'Recusou';
    }
  }

  String get icon {
    switch (this) {
      case Acceptance.loved:
        return '😍';
      case Acceptance.liked:
        return '😊';
      case Acceptance.neutral:
        return '😐';
      case Acceptance.disliked:
        return '😕';
      case Acceptance.refused:
        return '🙅';
    }
  }
}

class FoodLog {
  final String id;
  final String foodId;
  final String foodName;
  final DateTime date;
  final Acceptance acceptance;
  final Reaction reaction;
  final String? notes;
  final List<String> photosPaths;

  FoodLog({
    required this.id,
    required this.foodId,
    required this.foodName,
    required this.date,
    required this.acceptance,
    required this.reaction,
    this.notes,
    this.photosPaths = const [],
  });

  FoodLog copyWith({
    String? id,
    String? foodId,
    String? foodName,
    DateTime? date,
    Acceptance? acceptance,
    Reaction? reaction,
    String? notes,
    List<String>? photosPaths,
  }) {
    return FoodLog(
      id: id ?? this.id,
      foodId: foodId ?? this.foodId,
      foodName: foodName ?? this.foodName,
      date: date ?? this.date,
      acceptance: acceptance ?? this.acceptance,
      reaction: reaction ?? this.reaction,
      notes: notes ?? this.notes,
      photosPaths: photosPaths ?? this.photosPaths,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'foodId': foodId,
      'foodName': foodName,
      'date': date.toIso8601String(),
      'acceptance': acceptance.index,
      'reaction': reaction.index,
      'notes': notes,
      'photosPaths': photosPaths,
    };
  }

  factory FoodLog.fromJson(Map<String, dynamic> json) {
    return FoodLog(
      id: json['id'] as String,
      foodId: json['foodId'] as String,
      foodName: json['foodName'] as String,
      date: DateTime.parse(json['date'] as String),
      acceptance: Acceptance.values[json['acceptance'] as int],
      reaction: Reaction.values[json['reaction'] as int],
      notes: json['notes'] as String?,
      photosPaths: (json['photosPaths'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );
  }

  static String encodeList(List<FoodLog> logs) {
    return jsonEncode(logs.map((log) => log.toJson()).toList());
  }

  static List<FoodLog> decodeList(String jsonString) {
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList
        .map((json) => FoodLog.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
