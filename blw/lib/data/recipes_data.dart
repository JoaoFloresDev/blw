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

// MARK: - Portuguese (PT-BR)
const List<Recipe> _recipesPtBR = [
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

// MARK: - English (EN-US)
const List<Recipe> _recipesEnUS = [
  // Breakfast recipes
  Recipe(
    id: 'panqueca_banana',
    name: 'Banana Pancakes',
    icon: '🥞',
    category: RecipeCategory.breakfast,
    ageMonths: 6,
    prepTimeMinutes: 15,
    ingredients: [
      '1 ripe banana',
      '1 egg',
      '2 tablespoons of oats',
    ],
    instructions: [
      'Mash the banana well with a fork',
      'Mix in the egg and oats',
      'Heat a nonstick pan over low heat',
      'Pour in small portions of batter',
      'Flip when golden (about 2 minutes per side)',
      'Let cool before serving',
    ],
    tip: 'Cut into strips to make it easier for baby to grip',
    isAllergen: true,
  ),
  Recipe(
    id: 'mingau_aveia',
    name: 'Oatmeal Porridge with Fruit',
    icon: '🥣',
    category: RecipeCategory.breakfast,
    ageMonths: 6,
    prepTimeMinutes: 10,
    ingredients: [
      '2 tablespoons of oats',
      '100ml of breast milk or formula',
      'Mashed fruit to taste',
    ],
    instructions: [
      'Cook the oats with the milk over low heat',
      'Stir constantly for 5 minutes',
      'Let cool',
      'Top with mashed fruit',
    ],
    tip: 'Try it with mashed banana, papaya, or mango',
    isAllergen: true,
  ),
  Recipe(
    id: 'ovo_mexido',
    name: 'Creamy Scrambled Egg',
    icon: '🍳',
    category: RecipeCategory.breakfast,
    ageMonths: 6,
    prepTimeMinutes: 8,
    ingredients: [
      '1 egg',
      '1 teaspoon of unsalted butter',
    ],
    instructions: [
      'Beat the egg in a bowl',
      'Melt the butter over low heat',
      'Add the egg and stir constantly',
      'Remove from heat while still creamy',
      'Let cool before serving',
    ],
    tip: 'Serve in large pieces or mashed with a fork',
    isAllergen: true,
  ),

  // Lunch recipes
  Recipe(
    id: 'pure_batata_cenoura',
    name: 'Potato and Carrot Mash',
    icon: '🥔',
    category: RecipeCategory.lunch,
    ageMonths: 6,
    prepTimeMinutes: 25,
    ingredients: [
      '1 medium potato',
      '1 medium carrot',
      'Olive oil',
    ],
    instructions: [
      'Peel and cube the potato and carrot',
      'Steam until very soft',
      'Mash with a fork',
      'Add a drizzle of olive oil',
      'Mix well and serve warm',
    ],
    tip: 'Leave some larger pieces so baby can practice chewing',
  ),
  Recipe(
    id: 'frango_desfiado',
    name: 'Shredded Chicken with Vegetables',
    icon: '🍗',
    category: RecipeCategory.lunch,
    ageMonths: 6,
    prepTimeMinutes: 40,
    ingredients: [
      '1 skinless chicken thigh',
      '1 carrot',
      '1 small zucchini',
      'Fresh herbs (parsley, chives)',
    ],
    instructions: [
      'Cook the chicken in water until very tender',
      'Steam the vegetables',
      'Shred the chicken into long strips',
      'Cut the vegetables into sticks',
      'Serve together on the plate',
    ],
    tip: 'The strip shape helps baby hold the food',
  ),
  Recipe(
    id: 'bolinho_arroz_feijao',
    name: 'Rice and Bean Patties',
    icon: '🍚',
    category: RecipeCategory.lunch,
    ageMonths: 7,
    prepTimeMinutes: 20,
    ingredients: [
      '1/2 cup of cooked rice',
      '1/4 cup of cooked, mashed beans',
      '1 tablespoon of oat flour',
    ],
    instructions: [
      'Mix the rice with the mashed beans',
      'Add the oat flour',
      'Shape into small flat patties',
      'Bake at 180°C (350°F) for 15 minutes',
      'Flip halfway through',
    ],
    tip: 'A great way to offer legumes to your baby',
  ),
  Recipe(
    id: 'peixe_legumes',
    name: 'Fish with Vegetables',
    icon: '🐟',
    category: RecipeCategory.lunch,
    ageMonths: 7,
    prepTimeMinutes: 25,
    ingredients: [
      '1 tilapia fillet or other white fish',
      '1 sweet potato',
      'Broccoli',
      'Olive oil',
    ],
    instructions: [
      'Steam the sweet potato',
      'Steam the broccoli',
      'Bake the fish in the oven with olive oil',
      'Check carefully for bones',
      'Cut into suitable pieces',
    ],
    tip: 'Always check thoroughly for bones before serving',
    isAllergen: true,
  ),
  Recipe(
    id: 'carne_moida',
    name: 'Ground Beef with Pumpkin',
    icon: '🥩',
    category: RecipeCategory.lunch,
    ageMonths: 6,
    prepTimeMinutes: 30,
    ingredients: [
      '100g of lean ground beef',
      '1 slice of pumpkin',
      'Grated onion',
      'Olive oil',
    ],
    instructions: [
      'Sauté the onion in olive oil',
      'Add the beef and cook thoroughly',
      'Steam the pumpkin',
      'Mash the pumpkin',
      'Serve the beef over the pumpkin',
    ],
    tip: 'Ground beef is easier to chew for beginner eaters',
  ),

  // Dinner recipes
  Recipe(
    id: 'sopa_legumes',
    name: 'Creamy Vegetable Soup',
    icon: '🥣',
    category: RecipeCategory.dinner,
    ageMonths: 6,
    prepTimeMinutes: 35,
    ingredients: [
      '1 potato',
      '1 carrot',
      '1 zucchini',
      '1 piece of pumpkin',
      'Olive oil',
    ],
    instructions: [
      'Peel and chop all the vegetables',
      'Cook in water until soft',
      'Blend or mash',
      'Add olive oil',
      'Serve warm',
    ],
    tip: 'Keep it thicker for baby to eat with hands, or thinner for a spoon',
  ),
  Recipe(
    id: 'macarrao_molho',
    name: 'Pasta with Homemade Tomato Sauce',
    icon: '🍝',
    category: RecipeCategory.dinner,
    ageMonths: 8,
    prepTimeMinutes: 25,
    ingredients: [
      'Penne or fusilli pasta',
      '2 ripe tomatoes',
      '1/2 onion',
      'Olive oil',
      'Fresh basil',
    ],
    instructions: [
      'Cook the pasta until very soft',
      'Sauté the onion in olive oil',
      'Add the peeled and seeded tomatoes',
      'Cook until it forms a sauce',
      'Mix with the pasta and serve',
    ],
    tip: 'Shapes like fusilli are easier to grab',
    isAllergen: true,
  ),
  Recipe(
    id: 'omelete_legumes',
    name: 'Vegetable Omelet',
    icon: '🥚',
    category: RecipeCategory.dinner,
    ageMonths: 7,
    prepTimeMinutes: 15,
    ingredients: [
      '2 eggs',
      'Chopped spinach',
      'Chopped tomato',
      'Olive oil',
    ],
    instructions: [
      'Beat the eggs',
      'Add the chopped vegetables',
      'Heat olive oil in a nonstick pan',
      'Pour in the mixture and cook over low heat',
      'Flip and cook the other side',
      'Cut into strips to serve',
    ],
    tip: 'Try different vegetables each time',
    isAllergen: true,
  ),

  // Snack recipes
  Recipe(
    id: 'palitos_legumes',
    name: 'Vegetable Sticks',
    icon: '🥕',
    category: RecipeCategory.snack,
    ageMonths: 6,
    prepTimeMinutes: 15,
    ingredients: [
      'Carrot',
      'Zucchini',
      'Sweet potato',
    ],
    instructions: [
      'Cut the vegetables into finger-sized sticks',
      'Steam until soft',
      'They should be soft enough to mash with your fingers',
      'Serve at room temperature',
    ],
    tip: 'Perfect for practicing the palmar grasp',
  ),
  Recipe(
    id: 'banana_canela',
    name: 'Baked Banana with Cinnamon',
    icon: '🍌',
    category: RecipeCategory.snack,
    ageMonths: 6,
    prepTimeMinutes: 15,
    ingredients: [
      '1 banana',
      'A pinch of cinnamon',
    ],
    instructions: [
      'Cut the banana in half lengthwise',
      'Sprinkle cinnamon on top',
      'Bake at 180°C (350°F) for 10 minutes',
      'Let cool before serving',
    ],
    tip: 'Cinnamon adds flavor without the need for sugar',
  ),
  Recipe(
    id: 'bolinho_batata',
    name: 'Sweet Potato Bites',
    icon: '🥔',
    category: RecipeCategory.snack,
    ageMonths: 7,
    prepTimeMinutes: 30,
    ingredients: [
      '1 medium sweet potato',
      '1 tablespoon of oat flour',
      'Cinnamon to taste',
    ],
    instructions: [
      'Cook the sweet potato until soft',
      'Mash well',
      'Mix in the flour and cinnamon',
      'Shape into small bites',
      'Bake at 180°C (350°F) for 15 minutes',
    ],
    tip: 'Great for taking on outings',
    isAllergen: true,
  ),
  Recipe(
    id: 'frutas_iogurte',
    name: 'Fruit with Yogurt',
    icon: '🍓',
    category: RecipeCategory.snack,
    ageMonths: 6,
    prepTimeMinutes: 5,
    ingredients: [
      'Plain whole-milk yogurt',
      'Assorted fruit (strawberry, banana, mango)',
    ],
    instructions: [
      'Cut the fruit into suitable pieces',
      'Place the yogurt in a small bowl',
      'Arrange the fruit around or on top',
      'Let baby explore the textures',
    ],
    tip: 'Use unsweetened yogurt - the fruit already sweetens it naturally',
    isAllergen: true,
  ),
  Recipe(
    id: 'abacate_amassado',
    name: 'Mashed Avocado',
    icon: '🥑',
    category: RecipeCategory.snack,
    ageMonths: 6,
    prepTimeMinutes: 5,
    ingredients: [
      '1/2 ripe avocado',
    ],
    instructions: [
      'Cut the avocado in half',
      'Remove the pit',
      'Mash lightly with a fork',
      'Serve straight from the skin or on a plate',
    ],
    tip: 'Rich in healthy fats for brain development',
  ),
  Recipe(
    id: 'torrada_banana',
    name: 'Banana Toast',
    icon: '🍞',
    category: RecipeCategory.snack,
    ageMonths: 8,
    prepTimeMinutes: 5,
    ingredients: [
      '1 slice of whole-grain bread',
      '1/2 banana',
    ],
    instructions: [
      'Lightly toast the bread',
      'Mash the banana',
      'Spread it over the toast',
      'Cut into strips',
    ],
    tip: 'Choose bread with no added sugar',
    isAllergen: true,
  ),
];

// MARK: - Spanish (ES-ES)
const List<Recipe> _recipesEsES = [
  // Breakfast recipes
  Recipe(
    id: 'panqueca_banana',
    name: 'Tortitas de Plátano',
    icon: '🥞',
    category: RecipeCategory.breakfast,
    ageMonths: 6,
    prepTimeMinutes: 15,
    ingredients: [
      '1 plátano maduro',
      '1 huevo',
      '2 cucharadas de avena',
    ],
    instructions: [
      'Aplasta bien el plátano con un tenedor',
      'Mezcla el huevo y la avena',
      'Calienta una sartén antiadherente a fuego bajo',
      'Vierte pequeñas porciones de la masa',
      'Da la vuelta cuando se dore (unos 2 minutos por lado)',
      'Deja enfriar antes de servir',
    ],
    tip: 'Corta en tiras para que al bebé le resulte más fácil agarrarlas',
    isAllergen: true,
  ),
  Recipe(
    id: 'mingau_aveia',
    name: 'Gachas de Avena con Fruta',
    icon: '🥣',
    category: RecipeCategory.breakfast,
    ageMonths: 6,
    prepTimeMinutes: 10,
    ingredients: [
      '2 cucharadas de avena',
      '100ml de leche materna o de fórmula',
      'Fruta triturada al gusto',
    ],
    instructions: [
      'Cocina la avena con la leche a fuego bajo',
      'Remueve constantemente durante 5 minutos',
      'Deja enfriar',
      'Añade fruta triturada por encima',
    ],
    tip: 'Prueba con plátano, papaya o mango triturados',
    isAllergen: true,
  ),
  Recipe(
    id: 'ovo_mexido',
    name: 'Huevo Revuelto Cremoso',
    icon: '🍳',
    category: RecipeCategory.breakfast,
    ageMonths: 6,
    prepTimeMinutes: 8,
    ingredients: [
      '1 huevo',
      '1 cucharadita de mantequilla sin sal',
    ],
    instructions: [
      'Bate el huevo en un bol',
      'Derrite la mantequilla a fuego bajo',
      'Añade el huevo y remueve constantemente',
      'Retira del fuego cuando aún esté cremoso',
      'Deja enfriar antes de servir',
    ],
    tip: 'Sírvelo en trozos grandes o aplastado con un tenedor',
    isAllergen: true,
  ),

  // Lunch recipes
  Recipe(
    id: 'pure_batata_cenoura',
    name: 'Puré de Patata y Zanahoria',
    icon: '🥔',
    category: RecipeCategory.lunch,
    ageMonths: 6,
    prepTimeMinutes: 25,
    ingredients: [
      '1 patata mediana',
      '1 zanahoria mediana',
      'Aceite de oliva',
    ],
    instructions: [
      'Pela y corta la patata y la zanahoria en dados',
      'Cocina al vapor hasta que estén muy tiernas',
      'Aplasta con un tenedor',
      'Añade un chorrito de aceite de oliva',
      'Mezcla bien y sirve templado',
    ],
    tip: 'Deja algunos trozos más grandes para que el bebé practique la masticación',
  ),
  Recipe(
    id: 'frango_desfiado',
    name: 'Pollo Desmenuzado con Verduras',
    icon: '🍗',
    category: RecipeCategory.lunch,
    ageMonths: 6,
    prepTimeMinutes: 40,
    ingredients: [
      '1 muslo de pollo sin piel',
      '1 zanahoria',
      '1 calabacín pequeño',
      'Hierbas frescas (perejil, cebollino)',
    ],
    instructions: [
      'Cocina el pollo en agua hasta que esté muy tierno',
      'Cocina las verduras al vapor',
      'Desmenuza el pollo en tiras largas',
      'Corta las verduras en bastoncitos',
      'Sirve todo junto en el plato',
    ],
    tip: 'La forma de tiras ayuda al bebé a sujetar la comida',
  ),
  Recipe(
    id: 'bolinho_arroz_feijao',
    name: 'Tortitas de Arroz y Alubias',
    icon: '🍚',
    category: RecipeCategory.lunch,
    ageMonths: 7,
    prepTimeMinutes: 20,
    ingredients: [
      '1/2 taza de arroz cocido',
      '1/4 taza de alubias cocidas y aplastadas',
      '1 cucharada de harina de avena',
    ],
    instructions: [
      'Mezcla el arroz con las alubias aplastadas',
      'Añade la harina de avena',
      'Forma pequeñas tortitas aplanadas',
      'Hornea a 180°C durante 15 minutos',
      'Dales la vuelta a mitad de cocción',
    ],
    tip: 'Una forma estupenda de ofrecer legumbres al bebé',
  ),
  Recipe(
    id: 'peixe_legumes',
    name: 'Pescado con Verduras',
    icon: '🐟',
    category: RecipeCategory.lunch,
    ageMonths: 7,
    prepTimeMinutes: 25,
    ingredients: [
      '1 filete de tilapia u otro pescado blanco',
      '1 boniato',
      'Brócoli',
      'Aceite de oliva',
    ],
    instructions: [
      'Cocina el boniato al vapor',
      'Cocina el brócoli al vapor',
      'Hornea el pescado con aceite de oliva',
      'Comprueba que no tenga espinas',
      'Corta en trozos adecuados',
    ],
    tip: 'Comprueba siempre minuciosamente que no haya espinas antes de servir',
    isAllergen: true,
  ),
  Recipe(
    id: 'carne_moida',
    name: 'Carne Picada con Calabaza',
    icon: '🥩',
    category: RecipeCategory.lunch,
    ageMonths: 6,
    prepTimeMinutes: 30,
    ingredients: [
      '100g de carne picada magra',
      '1 rodaja de calabaza',
      'Cebolla rallada',
      'Aceite de oliva',
    ],
    instructions: [
      'Sofríe la cebolla en el aceite de oliva',
      'Añade la carne y cocínala bien',
      'Cocina la calabaza al vapor',
      'Aplasta la calabaza',
      'Sirve la carne sobre la calabaza',
    ],
    tip: 'La carne picada es más fácil de masticar para los que empiezan',
  ),

  // Dinner recipes
  Recipe(
    id: 'sopa_legumes',
    name: 'Crema de Verduras',
    icon: '🥣',
    category: RecipeCategory.dinner,
    ageMonths: 6,
    prepTimeMinutes: 35,
    ingredients: [
      '1 patata',
      '1 zanahoria',
      '1 calabacín',
      '1 trozo de calabaza',
      'Aceite de oliva',
    ],
    instructions: [
      'Pela y corta todas las verduras',
      'Cocina en agua hasta que estén tiernas',
      'Tritura con la batidora o aplasta',
      'Añade aceite de oliva',
      'Sirve templada',
    ],
    tip: 'Déjala más espesa para que el bebé coma con las manos, o más líquida para la cuchara',
  ),
  Recipe(
    id: 'macarrao_molho',
    name: 'Pasta con Salsa de Tomate Casera',
    icon: '🍝',
    category: RecipeCategory.dinner,
    ageMonths: 8,
    prepTimeMinutes: 25,
    ingredients: [
      'Pasta penne o fusilli',
      '2 tomates maduros',
      '1/2 cebolla',
      'Aceite de oliva',
      'Albahaca fresca',
    ],
    instructions: [
      'Cocina la pasta hasta que esté muy blanda',
      'Sofríe la cebolla en el aceite de oliva',
      'Añade los tomates pelados y sin semillas',
      'Cocina hasta formar una salsa',
      'Mezcla con la pasta y sirve',
    ],
    tip: 'Formas como el fusilli son más fáciles de agarrar',
    isAllergen: true,
  ),
  Recipe(
    id: 'omelete_legumes',
    name: 'Tortilla de Verduras',
    icon: '🥚',
    category: RecipeCategory.dinner,
    ageMonths: 7,
    prepTimeMinutes: 15,
    ingredients: [
      '2 huevos',
      'Espinacas picadas',
      'Tomate picado',
      'Aceite de oliva',
    ],
    instructions: [
      'Bate los huevos',
      'Añade las verduras picadas',
      'Calienta aceite de oliva en una sartén antiadherente',
      'Vierte la mezcla y cocina a fuego bajo',
      'Da la vuelta y cocina el otro lado',
      'Corta en tiras para servir',
    ],
    tip: 'Prueba con verduras diferentes cada vez',
    isAllergen: true,
  ),

  // Snack recipes
  Recipe(
    id: 'palitos_legumes',
    name: 'Bastoncitos de Verduras',
    icon: '🥕',
    category: RecipeCategory.snack,
    ageMonths: 6,
    prepTimeMinutes: 15,
    ingredients: [
      'Zanahoria',
      'Calabacín',
      'Boniato',
    ],
    instructions: [
      'Corta las verduras en bastoncitos del tamaño de tu dedo',
      'Cocina al vapor hasta que estén tiernas',
      'Deben quedar lo bastante blandas como para aplastarlas con los dedos',
      'Sirve a temperatura ambiente',
    ],
    tip: 'Perfecto para practicar el agarre palmar',
  ),
  Recipe(
    id: 'banana_canela',
    name: 'Plátano Asado con Canela',
    icon: '🍌',
    category: RecipeCategory.snack,
    ageMonths: 6,
    prepTimeMinutes: 15,
    ingredients: [
      '1 plátano',
      'Una pizca de canela',
    ],
    instructions: [
      'Corta el plátano por la mitad a lo largo',
      'Espolvorea canela por encima',
      'Hornea a 180°C durante 10 minutos',
      'Deja enfriar antes de servir',
    ],
    tip: 'La canela aporta sabor sin necesidad de azúcar',
  ),
  Recipe(
    id: 'bolinho_batata',
    name: 'Bocaditos de Boniato',
    icon: '🥔',
    category: RecipeCategory.snack,
    ageMonths: 7,
    prepTimeMinutes: 30,
    ingredients: [
      '1 boniato mediano',
      '1 cucharada de harina de avena',
      'Canela al gusto',
    ],
    instructions: [
      'Cocina el boniato hasta que esté tierno',
      'Aplasta bien',
      'Mezcla la harina y la canela',
      'Forma bocaditos pequeños',
      'Hornea a 180°C durante 15 minutos',
    ],
    tip: 'Estupendos para llevar de paseo',
    isAllergen: true,
  ),
  Recipe(
    id: 'frutas_iogurte',
    name: 'Fruta con Yogur',
    icon: '🍓',
    category: RecipeCategory.snack,
    ageMonths: 6,
    prepTimeMinutes: 5,
    ingredients: [
      'Yogur natural entero',
      'Fruta variada (fresa, plátano, mango)',
    ],
    instructions: [
      'Corta la fruta en trozos adecuados',
      'Pon el yogur en un cuenco pequeño',
      'Coloca la fruta alrededor o por encima',
      'Deja que el bebé explore las texturas',
    ],
    tip: 'Usa yogur sin azúcar: la fruta ya lo endulza de forma natural',
    isAllergen: true,
  ),
  Recipe(
    id: 'abacate_amassado',
    name: 'Aguacate Aplastado',
    icon: '🥑',
    category: RecipeCategory.snack,
    ageMonths: 6,
    prepTimeMinutes: 5,
    ingredients: [
      '1/2 aguacate maduro',
    ],
    instructions: [
      'Corta el aguacate por la mitad',
      'Retira el hueso',
      'Aplasta ligeramente con un tenedor',
      'Sirve directamente en la piel o en un plato',
    ],
    tip: 'Rico en grasas saludables para el desarrollo cerebral',
  ),
  Recipe(
    id: 'torrada_banana',
    name: 'Tostada con Plátano',
    icon: '🍞',
    category: RecipeCategory.snack,
    ageMonths: 8,
    prepTimeMinutes: 5,
    ingredients: [
      '1 rebanada de pan integral',
      '1/2 plátano',
    ],
    instructions: [
      'Tuesta ligeramente el pan',
      'Aplasta el plátano',
      'Extiéndelo sobre la tostada',
      'Corta en tiras',
    ],
    tip: 'Elige pan sin azúcar añadido',
    isAllergen: true,
  ),
];

// MARK: - Aliases & Accessors

/// Default list (Portuguese) used by the helper functions below.
const List<Recipe> allRecipes = _recipesPtBR;

/// Returns the recipe list for the given language code.
List<Recipe> recipesFor(String languageCode) {
  switch (languageCode) {
    case 'en':
      return _recipesEnUS;
    case 'es':
      return _recipesEsES;
    default:
      return _recipesPtBR;
  }
}

// MARK: - Helper Functions

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
