enum RecipeCategory {
  breakfast,
  lunch,
  dinner,
  snack,
}

extension RecipeCategoryExtension on RecipeCategory {
  String get icon {
    switch (this) {
      case RecipeCategory.breakfast:
        return '🌅';
      case RecipeCategory.lunch:
        return '☀️';
      case RecipeCategory.dinner:
        return '🌙';
      case RecipeCategory.snack:
        return '🍪';
    }
  }
}

class Recipe {
  final String id;
  final String name;
  final String icon;
  final RecipeCategory category;
  final int ageMonths; // minimum age in months
  final int prepTimeMinutes;
  final List<String> ingredients;
  final List<String> instructions;
  final String tip;
  final bool isAllergen;

  const Recipe({
    required this.id,
    required this.name,
    required this.icon,
    required this.category,
    required this.ageMonths,
    required this.prepTimeMinutes,
    required this.ingredients,
    required this.instructions,
    required this.tip,
    this.isAllergen = false,
  });
}

const List<Recipe> allRecipes = [
  // Breakfast recipes
  Recipe(
    id: 'panqueca_banana',
    name: 'Panqueca de Banana',
    icon: '🥞',
    category: RecipeCategory.breakfast,
    ageMonths: 6,
    prepTimeMinutes: 15,
    ingredients: [
      '1 banana madura',
      '1 ovo',
      '2 colheres de aveia',
    ],
    instructions: [
      'Amasse bem a banana com um garfo',
      'Misture o ovo e a aveia',
      'Aqueça uma frigideira antiaderente em fogo baixo',
      'Coloque pequenas porções da massa',
      'Vire quando dourar (cerca de 2 minutos cada lado)',
      'Deixe esfriar antes de servir',
    ],
    tip: 'Corte em tiras para facilitar a pegada do bebê',
    isAllergen: true,
  ),
  Recipe(
    id: 'mingau_aveia',
    name: 'Mingau de Aveia com Frutas',
    icon: '🥣',
    category: RecipeCategory.breakfast,
    ageMonths: 6,
    prepTimeMinutes: 10,
    ingredients: [
      '2 colheres de aveia',
      '100ml de leite materno ou fórmula',
      'Frutas amassadas a gosto',
    ],
    instructions: [
      'Cozinhe a aveia com o leite em fogo baixo',
      'Mexa constantemente por 5 minutos',
      'Deixe esfriar',
      'Adicione frutas amassadas por cima',
    ],
    tip: 'Experimente com banana, mamão ou manga amassados',
    isAllergen: true,
  ),
  Recipe(
    id: 'ovo_mexido',
    name: 'Ovo Mexido Cremoso',
    icon: '🍳',
    category: RecipeCategory.breakfast,
    ageMonths: 6,
    prepTimeMinutes: 8,
    ingredients: [
      '1 ovo',
      '1 colher de chá de manteiga sem sal',
    ],
    instructions: [
      'Bata o ovo em uma tigela',
      'Derreta a manteiga em fogo baixo',
      'Adicione o ovo e mexa constantemente',
      'Retire do fogo quando ainda cremoso',
      'Deixe esfriar antes de servir',
    ],
    tip: 'Sirva em pedaços grandes ou amassado com um garfo',
    isAllergen: true,
  ),

  // Lunch recipes
  Recipe(
    id: 'pure_batata_cenoura',
    name: 'Purê de Batata com Cenoura',
    icon: '🥔',
    category: RecipeCategory.lunch,
    ageMonths: 6,
    prepTimeMinutes: 25,
    ingredients: [
      '1 batata média',
      '1 cenoura média',
      'Azeite de oliva',
    ],
    instructions: [
      'Descasque e corte a batata e a cenoura em cubos',
      'Cozinhe no vapor até ficarem bem macias',
      'Amasse com um garfo',
      'Adicione um fio de azeite',
      'Misture bem e sirva morno',
    ],
    tip: 'Deixe alguns pedaços maiores para o bebê praticar a mastigação',
  ),
  Recipe(
    id: 'frango_desfiado',
    name: 'Frango Desfiado com Legumes',
    icon: '🍗',
    category: RecipeCategory.lunch,
    ageMonths: 6,
    prepTimeMinutes: 40,
    ingredients: [
      '1 coxa de frango sem pele',
      '1 cenoura',
      '1 abobrinha pequena',
      'Ervas frescas (salsinha, cebolinha)',
    ],
    instructions: [
      'Cozinhe o frango em água até ficar bem macio',
      'Cozinhe os legumes no vapor',
      'Desfie o frango em tiras longas',
      'Corte os legumes em palitos',
      'Sirva juntos no prato',
    ],
    tip: 'O formato de tiras ajuda o bebê a segurar',
  ),
  Recipe(
    id: 'bolinho_arroz_feijao',
    name: 'Bolinho de Arroz e Feijão',
    icon: '🍚',
    category: RecipeCategory.lunch,
    ageMonths: 7,
    prepTimeMinutes: 20,
    ingredients: [
      '1/2 xícara de arroz cozido',
      '1/4 xícara de feijão cozido e amassado',
      '1 colher de farinha de aveia',
    ],
    instructions: [
      'Misture o arroz com o feijão amassado',
      'Adicione a farinha de aveia',
      'Modele em pequenos bolinhos achatados',
      'Asse em forno a 180°C por 15 minutos',
      'Vire na metade do tempo',
    ],
    tip: 'Ótima forma de oferecer leguminosas para o bebê',
  ),
  Recipe(
    id: 'peixe_legumes',
    name: 'Peixe com Legumes',
    icon: '🐟',
    category: RecipeCategory.lunch,
    ageMonths: 7,
    prepTimeMinutes: 25,
    ingredients: [
      '1 filé de tilápia ou outro peixe branco',
      '1 batata doce',
      'Brócolis',
      'Azeite de oliva',
    ],
    instructions: [
      'Cozinhe a batata doce no vapor',
      'Cozinhe o brócolis no vapor',
      'Asse o peixe no forno com azeite',
      'Verifique se não há espinhas',
      'Corte em pedaços adequados',
    ],
    tip: 'Sempre verifique minuciosamente se há espinhas antes de servir',
    isAllergen: true,
  ),
  Recipe(
    id: 'carne_moida',
    name: 'Carne Moída com Abóbora',
    icon: '🥩',
    category: RecipeCategory.lunch,
    ageMonths: 6,
    prepTimeMinutes: 30,
    ingredients: [
      '100g de carne moída magra',
      '1 fatia de abóbora',
      'Cebola ralada',
      'Azeite',
    ],
    instructions: [
      'Refogue a cebola no azeite',
      'Adicione a carne e cozinhe bem',
      'Cozinhe a abóbora no vapor',
      'Amasse a abóbora',
      'Sirva a carne sobre a abóbora',
    ],
    tip: 'A carne moída é mais fácil de mastigar para bebês iniciantes',
  ),

  // Dinner recipes
  Recipe(
    id: 'sopa_legumes',
    name: 'Sopa de Legumes Cremosa',
    icon: '🥣',
    category: RecipeCategory.dinner,
    ageMonths: 6,
    prepTimeMinutes: 35,
    ingredients: [
      '1 batata',
      '1 cenoura',
      '1 abobrinha',
      '1 pedaço de abóbora',
      'Azeite de oliva',
    ],
    instructions: [
      'Descasque e corte todos os legumes',
      'Cozinhe em água até ficarem macios',
      'Bata no liquidificador ou amasse',
      'Adicione azeite',
      'Sirva morna',
    ],
    tip: 'Deixe mais grossa para o bebê comer com as mãos ou mais líquida para colher',
  ),
  Recipe(
    id: 'macarrao_molho',
    name: 'Macarrão com Molho de Tomate Caseiro',
    icon: '🍝',
    category: RecipeCategory.dinner,
    ageMonths: 8,
    prepTimeMinutes: 25,
    ingredients: [
      'Macarrão penne ou fusilli',
      '2 tomates maduros',
      '1/2 cebola',
      'Azeite',
      'Manjericão fresco',
    ],
    instructions: [
      'Cozinhe o macarrão até ficar bem macio',
      'Refogue a cebola no azeite',
      'Adicione os tomates sem pele e sementes',
      'Cozinhe até formar um molho',
      'Misture com o macarrão e sirva',
    ],
    tip: 'Formatos como fusilli são mais fáceis de pegar',
    isAllergen: true,
  ),
  Recipe(
    id: 'omelete_legumes',
    name: 'Omelete de Legumes',
    icon: '🥚',
    category: RecipeCategory.dinner,
    ageMonths: 7,
    prepTimeMinutes: 15,
    ingredients: [
      '2 ovos',
      'Espinafre picado',
      'Tomate picado',
      'Azeite',
    ],
    instructions: [
      'Bata os ovos',
      'Adicione os vegetais picados',
      'Aqueça azeite em frigideira antiaderente',
      'Despeje a mistura e cozinhe em fogo baixo',
      'Vire e cozinhe o outro lado',
      'Corte em tiras para servir',
    ],
    tip: 'Experimente diferentes vegetais a cada vez',
    isAllergen: true,
  ),

  // Snack recipes
  Recipe(
    id: 'palitos_legumes',
    name: 'Palitos de Legumes',
    icon: '🥕',
    category: RecipeCategory.snack,
    ageMonths: 6,
    prepTimeMinutes: 15,
    ingredients: [
      'Cenoura',
      'Abobrinha',
      'Batata doce',
    ],
    instructions: [
      'Corte os legumes em palitos do tamanho do seu dedo',
      'Cozinhe no vapor até ficarem macios',
      'Devem estar macios o suficiente para amassar com os dedos',
      'Sirva em temperatura ambiente',
    ],
    tip: 'Perfeito para praticar a pegada palmar',
  ),
  Recipe(
    id: 'banana_canela',
    name: 'Banana Assada com Canela',
    icon: '🍌',
    category: RecipeCategory.snack,
    ageMonths: 6,
    prepTimeMinutes: 15,
    ingredients: [
      '1 banana',
      'Pitada de canela',
    ],
    instructions: [
      'Corte a banana ao meio no sentido do comprimento',
      'Polvilhe canela por cima',
      'Asse no forno a 180°C por 10 minutos',
      'Deixe esfriar antes de servir',
    ],
    tip: 'A canela adiciona sabor sem precisar de açúcar',
  ),
  Recipe(
    id: 'bolinho_batata',
    name: 'Bolinho de Batata Doce',
    icon: '🥔',
    category: RecipeCategory.snack,
    ageMonths: 7,
    prepTimeMinutes: 30,
    ingredients: [
      '1 batata doce média',
      '1 colher de farinha de aveia',
      'Canela a gosto',
    ],
    instructions: [
      'Cozinhe a batata doce até ficar macia',
      'Amasse bem',
      'Misture a farinha e a canela',
      'Modele bolinhos pequenos',
      'Asse a 180°C por 15 minutos',
    ],
    tip: 'Ótimo para levar em passeios',
    isAllergen: true,
  ),
  Recipe(
    id: 'frutas_iogurte',
    name: 'Frutas com Iogurte',
    icon: '🍓',
    category: RecipeCategory.snack,
    ageMonths: 6,
    prepTimeMinutes: 5,
    ingredients: [
      'Iogurte natural integral',
      'Frutas variadas (morango, banana, manga)',
    ],
    instructions: [
      'Corte as frutas em pedaços adequados',
      'Coloque o iogurte em um potinho',
      'Disponha as frutas ao redor ou por cima',
      'Deixe o bebê explorar as texturas',
    ],
    tip: 'Use iogurte sem açúcar - as frutas já adoçam naturalmente',
    isAllergen: true,
  ),
  Recipe(
    id: 'abacate_amassado',
    name: 'Abacate Amassado',
    icon: '🥑',
    category: RecipeCategory.snack,
    ageMonths: 6,
    prepTimeMinutes: 5,
    ingredients: [
      '1/2 abacate maduro',
    ],
    instructions: [
      'Corte o abacate ao meio',
      'Retire o caroço',
      'Amasse levemente com um garfo',
      'Sirva diretamente na casca ou em um prato',
    ],
    tip: 'Rico em gorduras boas para o desenvolvimento cerebral',
  ),
  Recipe(
    id: 'torrada_banana',
    name: 'Torrada com Banana',
    icon: '🍞',
    category: RecipeCategory.snack,
    ageMonths: 8,
    prepTimeMinutes: 5,
    ingredients: [
      '1 fatia de pão integral',
      '1/2 banana',
    ],
    instructions: [
      'Torre levemente o pão',
      'Amasse a banana',
      'Espalhe sobre a torrada',
      'Corte em tiras',
    ],
    tip: 'Escolha pão sem açúcar adicionado',
    isAllergen: true,
  ),
];

Recipe? getRecipeById(String id) {
  try {
    return allRecipes.firstWhere((r) => r.id == id);
  } catch (_) {
    return null;
  }
}

List<Recipe> getRecipesByCategory(RecipeCategory category) {
  return allRecipes.where((r) => r.category == category).toList();
}

List<Recipe> getRecipesForAge(int ageMonths) {
  return allRecipes.where((r) => r.ageMonths <= ageMonths).toList();
}
