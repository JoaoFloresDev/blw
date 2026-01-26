enum FoodCategory {
  fruits,
  vegetables,
  proteins,
  grains,
  dairy,
}

enum AgeGroup {
  sixMonths,
  sevenMonths,
  eightMonths,
  nineMonths,
  tenToTwelveMonths,
  afterOneYear,
}

extension FoodCategoryExtension on FoodCategory {
  String get displayName {
    switch (this) {
      case FoodCategory.fruits:
        return 'Frutas';
      case FoodCategory.vegetables:
        return 'Legumes e Verduras';
      case FoodCategory.proteins:
        return 'Proteinas';
      case FoodCategory.grains:
        return 'Cereais e Graos';
      case FoodCategory.dairy:
        return 'Laticinios';
    }
  }

  String get icon {
    switch (this) {
      case FoodCategory.fruits:
        return '🍎';
      case FoodCategory.vegetables:
        return '🥕';
      case FoodCategory.proteins:
        return '🍗';
      case FoodCategory.grains:
        return '🌾';
      case FoodCategory.dairy:
        return '🧀';
    }
  }
}

extension AgeGroupExtension on AgeGroup {
  String get displayName {
    switch (this) {
      case AgeGroup.sixMonths:
        return '6 meses';
      case AgeGroup.sevenMonths:
        return '7 meses';
      case AgeGroup.eightMonths:
        return '8 meses';
      case AgeGroup.nineMonths:
        return '9 meses';
      case AgeGroup.tenToTwelveMonths:
        return '10-12 meses';
      case AgeGroup.afterOneYear:
        return 'Apos 1 ano';
    }
  }
}

class Food {
  final String id;
  final String name;
  final String icon;
  final FoodCategory category;
  final AgeGroup minimumAge;
  final String preparationTip;
  final bool isAllergen;
  final String? allergenInfo;

  const Food({
    required this.id,
    required this.name,
    required this.icon,
    required this.category,
    required this.minimumAge,
    required this.preparationTip,
    this.isAllergen = false,
    this.allergenInfo,
  });
}
