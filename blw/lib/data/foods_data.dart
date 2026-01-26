import '../models/food.dart';

const List<Food> allFoods = [
  // FRUTAS - 6 meses
  Food(
    id: 'banana',
    name: 'Banana',
    icon: '🍌',
    category: FoodCategory.fruits,
    minimumAge: AgeGroup.sixMonths,
    preparationTip: 'Corte em formato de palito ou amasse levemente. Pode deixar com parte da casca para facilitar a pegada.',
  ),
  Food(
    id: 'abacate',
    name: 'Abacate',
    icon: '🥑',
    category: FoodCategory.fruits,
    minimumAge: AgeGroup.sixMonths,
    preparationTip: 'Corte em fatias ou amasse. Rico em gorduras boas para o desenvolvimento cerebral.',
  ),
  Food(
    id: 'manga',
    name: 'Manga',
    icon: '🥭',
    category: FoodCategory.fruits,
    minimumAge: AgeGroup.sixMonths,
    preparationTip: 'Corte em palitos ou ofereca no caroco para o bebe segurar e chupar.',
  ),
  Food(
    id: 'pera',
    name: 'Pera',
    icon: '🍐',
    category: FoodCategory.fruits,
    minimumAge: AgeGroup.sixMonths,
    preparationTip: 'Ofereca madura e macia, cortada em palitos. Pode cozinhar levemente se estiver muito dura.',
  ),
  Food(
    id: 'mamao',
    name: 'Mamao',
    icon: '🍈',
    category: FoodCategory.fruits,
    minimumAge: AgeGroup.sixMonths,
    preparationTip: 'Ofereca maduro em pedacos ou amassado. Otimo para o intestino.',
  ),
  Food(
    id: 'melao',
    name: 'Melao',
    icon: '🍈',
    category: FoodCategory.fruits,
    minimumAge: AgeGroup.sixMonths,
    preparationTip: 'Corte em palitos finos. Bem maduro fica mais macio.',
  ),
  Food(
    id: 'melancia',
    name: 'Melancia',
    icon: '🍉',
    category: FoodCategory.fruits,
    minimumAge: AgeGroup.sixMonths,
    preparationTip: 'Remova as sementes e corte em palitos. Muito refrescante!',
  ),
  Food(
    id: 'maca',
    name: 'Maca',
    icon: '🍎',
    category: FoodCategory.fruits,
    minimumAge: AgeGroup.sixMonths,
    preparationTip: 'Cozinhe no vapor ate ficar macia ou rale. Crua so apos 1 ano.',
  ),

  // FRUTAS - 7+ meses
  Food(
    id: 'morango',
    name: 'Morango',
    icon: '🍓',
    category: FoodCategory.fruits,
    minimumAge: AgeGroup.sevenMonths,
    preparationTip: 'Corte ao meio ou em quartos. Lave muito bem.',
  ),
  Food(
    id: 'kiwi',
    name: 'Kiwi',
    icon: '🥝',
    category: FoodCategory.fruits,
    minimumAge: AgeGroup.eightMonths,
    preparationTip: 'Descasque e corte em rodelas ou palitos.',
  ),
  Food(
    id: 'laranja',
    name: 'Laranja',
    icon: '🍊',
    category: FoodCategory.fruits,
    minimumAge: AgeGroup.eightMonths,
    preparationTip: 'Ofereca em gomos sem a pele fina. Prefira variedades menos acidas.',
  ),

  // LEGUMES E VERDURAS - 6 meses
  Food(
    id: 'batata_doce',
    name: 'Batata Doce',
    icon: '🍠',
    category: FoodCategory.vegetables,
    minimumAge: AgeGroup.sixMonths,
    preparationTip: 'Cozinhe no vapor e corte em palitos. Rica em vitamina A.',
  ),
  Food(
    id: 'cenoura',
    name: 'Cenoura',
    icon: '🥕',
    category: FoodCategory.vegetables,
    minimumAge: AgeGroup.sixMonths,
    preparationTip: 'Cozinhe no vapor ate ficar bem macia. Corte em palitos grossos.',
  ),
  Food(
    id: 'abobora',
    name: 'Abobora',
    icon: '🎃',
    category: FoodCategory.vegetables,
    minimumAge: AgeGroup.sixMonths,
    preparationTip: 'Cozinhe no vapor ou asse. Fica bem macia e docinha.',
  ),
  Food(
    id: 'chuchu',
    name: 'Chuchu',
    icon: '🥒',
    category: FoodCategory.vegetables,
    minimumAge: AgeGroup.sixMonths,
    preparationTip: 'Cozinhe bem e corte em palitos. Sabor suave, otimo para comecar.',
  ),
  Food(
    id: 'brocolis',
    name: 'Brocolis',
    icon: '🥦',
    category: FoodCategory.vegetables,
    minimumAge: AgeGroup.sixMonths,
    preparationTip: 'Cozinhe no vapor os floretes. O talo serve de "cabo" para segurar.',
  ),
  Food(
    id: 'couve_flor',
    name: 'Couve-flor',
    icon: '🥬',
    category: FoodCategory.vegetables,
    minimumAge: AgeGroup.sixMonths,
    preparationTip: 'Cozinhe no vapor ate ficar macia. Ofereca os floretes.',
  ),
  Food(
    id: 'abobrinha',
    name: 'Abobrinha',
    icon: '🥒',
    category: FoodCategory.vegetables,
    minimumAge: AgeGroup.sixMonths,
    preparationTip: 'Cozinhe no vapor ou grelhada. Corte em palitos com casca.',
  ),
  Food(
    id: 'vagem',
    name: 'Vagem',
    icon: '🫛',
    category: FoodCategory.vegetables,
    minimumAge: AgeGroup.sixMonths,
    preparationTip: 'Cozinhe no vapor ate ficar macia. Formato ideal para BLW.',
  ),
  Food(
    id: 'beterraba',
    name: 'Beterraba',
    icon: '🟣',
    category: FoodCategory.vegetables,
    minimumAge: AgeGroup.sixMonths,
    preparationTip: 'Cozinhe ate ficar macia e corte em palitos. Mancha as roupas!',
  ),
  Food(
    id: 'inhame',
    name: 'Inhame',
    icon: '🥔',
    category: FoodCategory.vegetables,
    minimumAge: AgeGroup.sixMonths,
    preparationTip: 'Cozinhe bem e amasse ou corte em pedacos. Muito nutritivo.',
  ),

  // LEGUMES - 7+ meses
  Food(
    id: 'tomate',
    name: 'Tomate',
    icon: '🍅',
    category: FoodCategory.vegetables,
    minimumAge: AgeGroup.eightMonths,
    preparationTip: 'Remova as sementes e a pele. Corte em pedacos pequenos.',
  ),
  Food(
    id: 'pepino',
    name: 'Pepino',
    icon: '🥒',
    category: FoodCategory.vegetables,
    minimumAge: AgeGroup.nineMonths,
    preparationTip: 'Descasque, remova as sementes e corte em palitos.',
  ),

  // PROTEINAS - 6 meses
  Food(
    id: 'frango',
    name: 'Frango',
    icon: '🍗',
    category: FoodCategory.proteins,
    minimumAge: AgeGroup.sixMonths,
    preparationTip: 'Cozinhe bem e desfie ou corte em tiras. Coxa e sobrecoxa sao mais macias.',
  ),
  Food(
    id: 'carne_bovina',
    name: 'Carne Bovina',
    icon: '🥩',
    category: FoodCategory.proteins,
    minimumAge: AgeGroup.sixMonths,
    preparationTip: 'Cozinhe ate ficar bem macia. Cortes como patinho e maminha sao bons. Desfie ou corte em tiras.',
  ),
  Food(
    id: 'gema_ovo',
    name: 'Gema de Ovo',
    icon: '🥚',
    category: FoodCategory.proteins,
    minimumAge: AgeGroup.sixMonths,
    preparationTip: 'Cozinhe bem (gema dura) e ofereca amassada ou em pedacos.',
    isAllergen: true,
    allergenInfo: 'Ovo e um dos principais alergenicos. Introduza em pequenas quantidades e observe por 3 dias.',
  ),
  Food(
    id: 'peixe',
    name: 'Peixe',
    icon: '🐟',
    category: FoodCategory.proteins,
    minimumAge: AgeGroup.sixMonths,
    preparationTip: 'Prefira peixes de agua doce ou sardinha. Cozinhe bem e remova todas as espinhas.',
    isAllergen: true,
    allergenInfo: 'Peixe pode causar alergia. Comece com peixes menos alergenicos como tilapia.',
  ),
  Food(
    id: 'feijao',
    name: 'Feijao',
    icon: '🫘',
    category: FoodCategory.proteins,
    minimumAge: AgeGroup.sixMonths,
    preparationTip: 'Cozinhe bem e amasse levemente. Pode oferecer o caldo tambem.',
  ),
  Food(
    id: 'lentilha',
    name: 'Lentilha',
    icon: '🟤',
    category: FoodCategory.proteins,
    minimumAge: AgeGroup.sixMonths,
    preparationTip: 'Cozinhe ate ficar bem macia. Rica em ferro.',
  ),
  Food(
    id: 'grao_de_bico',
    name: 'Grao de Bico',
    icon: '🫛',
    category: FoodCategory.proteins,
    minimumAge: AgeGroup.sixMonths,
    preparationTip: 'Cozinhe muito bem e amasse (homus) ou ofereca inteiro supervisionado.',
  ),

  // PROTEINAS - 9+ meses
  Food(
    id: 'ovo_inteiro',
    name: 'Ovo Inteiro',
    icon: '🍳',
    category: FoodCategory.proteins,
    minimumAge: AgeGroup.nineMonths,
    preparationTip: 'Apos introduzir a gema sem reacoes, pode oferecer o ovo inteiro bem cozido.',
    isAllergen: true,
    allergenInfo: 'A clara do ovo e mais alergenica que a gema.',
  ),
  Food(
    id: 'camarao',
    name: 'Camarao',
    icon: '🦐',
    category: FoodCategory.proteins,
    minimumAge: AgeGroup.afterOneYear,
    preparationTip: 'Cozinhe bem e corte em pedacos pequenos. Introduza com cautela.',
    isAllergen: true,
    allergenInfo: 'Frutos do mar sao altamente alergenicos. Introduza apos 1 ano com supervisao.',
  ),

  // CEREAIS E GRAOS - 6 meses
  Food(
    id: 'arroz',
    name: 'Arroz',
    icon: '🍚',
    category: FoodCategory.grains,
    minimumAge: AgeGroup.sixMonths,
    preparationTip: 'Cozinhe ate ficar bem macio. Pode amassar levemente ou fazer bolinhos.',
  ),
  Food(
    id: 'aveia',
    name: 'Aveia',
    icon: '🥣',
    category: FoodCategory.grains,
    minimumAge: AgeGroup.sixMonths,
    preparationTip: 'Cozinhe com agua ou leite materno. Faca mingau ou panquecas.',
    isAllergen: true,
    allergenInfo: 'Pode conter tracos de gluten. Use aveia certificada sem gluten se necessario.',
  ),
  Food(
    id: 'macarrao',
    name: 'Macarrao',
    icon: '🍝',
    category: FoodCategory.grains,
    minimumAge: AgeGroup.sixMonths,
    preparationTip: 'Cozinhe ate ficar bem macio. Formatos como fusilli sao faceis de pegar.',
    isAllergen: true,
    allergenInfo: 'Contem gluten. Observe reacoes.',
  ),
  Food(
    id: 'pao',
    name: 'Pao',
    icon: '🍞',
    category: FoodCategory.grains,
    minimumAge: AgeGroup.sevenMonths,
    preparationTip: 'Ofereca em tiras ou torrrado levemente. Prefira paes sem acucar.',
    isAllergen: true,
    allergenInfo: 'Contem gluten e pode conter leite.',
  ),
  Food(
    id: 'quinoa',
    name: 'Quinoa',
    icon: '🌾',
    category: FoodCategory.grains,
    minimumAge: AgeGroup.sixMonths,
    preparationTip: 'Cozinhe bem e misture com vegetais. Muito nutritiva!',
  ),

  // LATICINIOS - 6+ meses
  Food(
    id: 'iogurte_natural',
    name: 'Iogurte Natural',
    icon: '🥛',
    category: FoodCategory.dairy,
    minimumAge: AgeGroup.sixMonths,
    preparationTip: 'Ofereca integral e sem acucar. Pode misturar com frutas.',
    isAllergen: true,
    allergenInfo: 'Derivado do leite de vaca. Observe intolerancia a lactose ou alergia a proteina do leite.',
  ),
  Food(
    id: 'queijo',
    name: 'Queijo',
    icon: '🧀',
    category: FoodCategory.dairy,
    minimumAge: AgeGroup.nineMonths,
    preparationTip: 'Prefira queijos pasteurizados como mussarela ou ricota. Corte em palitos.',
    isAllergen: true,
    allergenInfo: 'Derivado do leite. Evite queijos maturados pelo alto teor de sodio.',
  ),
  Food(
    id: 'leite_vaca',
    name: 'Leite de Vaca',
    icon: '🥛',
    category: FoodCategory.dairy,
    minimumAge: AgeGroup.afterOneYear,
    preparationTip: 'Apenas apos 1 ano como bebida. Antes pode usar em preparacoes.',
    isAllergen: true,
    allergenInfo: 'Nao deve substituir o leite materno ou formula antes de 1 ano.',
  ),
];

List<Food> getFoodsByCategory(FoodCategory category) {
  return allFoods.where((food) => food.category == category).toList();
}

List<Food> getFoodsByAge(AgeGroup age) {
  return allFoods.where((food) => food.minimumAge.index <= age.index).toList();
}

List<Food> getAllergenFoods() {
  return allFoods.where((food) => food.isAllergen).toList();
}

Food? getFoodById(String id) {
  try {
    return allFoods.firstWhere((food) => food.id == id);
  } catch (e) {
    return null;
  }
}
