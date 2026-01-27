import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static const List<Locale> supportedLocales = [
    Locale('pt', 'BR'),
    Locale('en', 'US'),
    Locale('es', 'ES'),
  ];

  static final Map<String, Map<String, String>> _localizedValues = {
    'pt': _ptTranslations,
    'en': _enTranslations,
    'es': _esTranslations,
  };

  String get(String key) {
    return _localizedValues[locale.languageCode]?[key] ??
        _localizedValues['pt']?[key] ??
        key;
  }

  // App general
  String get appTitle => get('appTitle');
  String get appSubtitle => get('appSubtitle');

  // Navigation
  String get foods => get('foods');
  String get foodDiary => get('foodDiary');
  String get allergens => get('allergens');
  String get blwTips => get('blwTips');

  // Foods screen
  String get foodsSubtitle => get('foodsSubtitle');
  String get diarySubtitle => get('diarySubtitle');
  String get allergensSubtitle => get('allergensSubtitle');
  String get tipsSubtitle => get('tipsSubtitle');
  String get infoCardText => get('infoCardText');

  // Food categories
  String get fruits => get('fruits');
  String get vegetables => get('vegetables');
  String get proteins => get('proteins');
  String get grains => get('grains');
  String get dairy => get('dairy');

  // Age groups
  String get sixMonths => get('sixMonths');
  String get sevenMonths => get('sevenMonths');
  String get eightMonths => get('eightMonths');
  String get nineMonths => get('nineMonths');
  String get tenToTwelveMonths => get('tenToTwelveMonths');
  String get afterOneYear => get('afterOneYear');
  String fromAge(String age) => get('fromAge').replaceAll('{age}', age);

  // Acceptance
  String get loved => get('loved');
  String get liked => get('liked');
  String get neutral => get('neutral');
  String get disliked => get('disliked');
  String get refused => get('refused');

  // Reactions
  String get noReaction => get('noReaction');
  String get mildReaction => get('mildReaction');
  String get moderateReaction => get('moderateReaction');
  String get severeReaction => get('severeReaction');

  // Food detail
  String get category => get('category');
  String get howToPrepare => get('howToPrepare');
  String get allergenWarning => get('allergenWarning');
  String get allergenDefaultInfo => get('allergenDefaultInfo');
  String get addToDiary => get('addToDiary');

  // Food log
  String get noRecordsYet => get('noRecordsYet');
  String get startRecording => get('startRecording');
  String get addRecord => get('addRecord');
  String get today => get('today');
  String get yesterday => get('yesterday');
  String get deleteRecord => get('deleteRecord');
  String deleteRecordConfirm(String food) =>
      get('deleteRecordConfirm').replaceAll('{food}', food);
  String get cancel => get('cancel');
  String get delete => get('delete');

  // Food log detail
  String get details => get('details');
  String get edit => get('edit');
  String get acceptance => get('acceptance');
  String get reaction => get('reaction');
  String get deleteRecordButton => get('deleteRecordButton');

  // Add food log
  String get newRecord => get('newRecord');
  String get food => get('food');
  String get selectFood => get('selectFood');
  String get date => get('date');
  String get howWasAcceptance => get('howWasAcceptance');
  String get anyReaction => get('anyReaction');
  String get notes => get('notes');
  String get notesOptional => get('notesOptional');
  String get notesHint => get('notesHint');
  String get saveRecord => get('saveRecord');
  String recordSaved(String food) =>
      get('recordSaved').replaceAll('{food}', food);

  // Allergens screen
  String get allergenicFoods => get('allergenicFoods');
  String get whatAreAllergens => get('whatAreAllergens');
  String get allergensExplanation => get('allergensExplanation');
  String get howToIntroduce => get('howToIntroduce');
  String get step1 => get('step1');
  String get step2 => get('step2');
  String get step3 => get('step3');
  String get step4 => get('step4');
  String get step5 => get('step5');

  // Tips screen
  String get whenToStart => get('whenToStart');
  String get whenToStartContent => get('whenToStartContent');
  String get whatIsBLW => get('whatIsBLW');
  String get whatIsBLWContent => get('whatIsBLWContent');
  String get howToCut => get('howToCut');
  String get howToCutContent => get('howToCutContent');
  String get chokingVsGag => get('chokingVsGag');
  String get chokingVsGagContent => get('chokingVsGagContent');
  String get forbiddenFoods => get('forbiddenFoods');
  String get forbiddenFoodsContent => get('forbiddenFoodsContent');
  String get importantTips => get('importantTips');
  String get importantTipsContent => get('importantTipsContent');
  String get safety => get('safety');
  String get safetyContent => get('safetyContent');
  String get consultPediatrician => get('consultPediatrician');
  String get patience => get('patience');
  String get patienceContent => get('patienceContent');
  String get familyMeals => get('familyMeals');
  String get familyMealsContent => get('familyMealsContent');
  String get hydration => get('hydration');
  String get hydrationContent => get('hydrationContent');
  String get balancedDiet => get('balancedDiet');
  String get balancedDietContent => get('balancedDietContent');
  String get ironRich => get('ironRich');
  String get ironRichContent => get('ironRichContent');
  String get varietyTip => get('varietyTip');
  String get varietyTipContent => get('varietyTipContent');

  // Recipes
  String get recipes => get('recipes');
  String get recipesSubtitle => get('recipesSubtitle');
  String get recipe => get('recipe');
  String get all => get('all');
  String get breakfast => get('breakfast');
  String get lunch => get('lunch');
  String get dinner => get('dinner');
  String get snack => get('snack');
  String get allergen => get('allergen');
  String get ingredients => get('ingredients');
  String get instructions => get('instructions');
  String get tip => get('tip');

  // No foods message
  String get noFoodsAvailable => get('noFoodsAvailable');
  String noFoodsForAge(String age) =>
      get('noFoodsForAge').replaceAll('{age}', age);

  // Gallery and photos
  String get gallery => get('gallery');
  String get noPhotosYet => get('noPhotosYet');
  String get addPhotosHint => get('addPhotosHint');
  String get unlimitedPhotos => get('unlimitedPhotos');
  String get upgradeToPremium => get('upgradeToPremium');
  String get shareGalleryText => get('shareGalleryText');
  String sharePhotoText(String foodName) =>
      get('sharePhotoText').replaceAll('{food}', foodName);
  String get deletePhoto => get('deletePhoto');
  String get deletePhotoConfirm => get('deletePhotoConfirm');
  String get addPhoto => get('addPhoto');
  String get takePhoto => get('takePhoto');
  String get chooseFromGallery => get('chooseFromGallery');
  String get photos => get('photos');
  String get photoLimitReached => get('photoLimitReached');

  // Premium
  String get youArePremium => get('youArePremium');
  String get premiumActiveDescription => get('premiumActiveDescription');
  String get validUntil => get('validUntil');
  String get goBack => get('goBack');
  String get goPremium => get('goPremium');
  String get premiumDescription => get('premiumDescription');
  String get monthlyPlan => get('monthlyPlan');
  String get monthlyPlanDescription => get('monthlyPlanDescription');
  String get yearlyPlan => get('yearlyPlan');
  String get yearlyPlanDescription => get('yearlyPlanDescription');
  String get lifetimePlan => get('lifetimePlan');
  String get lifetimePlanDescription => get('lifetimePlanDescription');
  String get restorePurchases => get('restorePurchases');
  String get purchaseDisclaimer => get('purchaseDisclaimer');
  String get featureUnlimitedPhotos => get('featureUnlimitedPhotos');
  String get featureMoreRecipes => get('featureMoreRecipes');
  String get featureNoAds => get('featureNoAds');
  String get featurePrioritySupport => get('featurePrioritySupport');
  String get mostPopular => get('mostPopular');
  String get purchaseSuccess => get('purchaseSuccess');
  String timesOffered(int count) => get('timesOffered').replaceAll('{count}', count.toString());
  String get neverOffered => get('neverOffered');

  // Celebration
  String get firstTime => get('firstTime');
  String get addedToDiary => get('addedToDiary');
  String get tapToContinue => get('tapToContinue');

  // Home screen
  String get quickActions => get('quickActions');
  String get addRecordSubtitle => get('addRecordSubtitle');
  String get progress => get('progress');
  String get foodsTried => get('foodsTried');
  String get totalRecords => get('totalRecords');
  String get photosSaved => get('photosSaved');
  String get recentActivity => get('recentActivity');
  String foodsTriedOf(int tried, int total) => get('foodsTriedOf').replaceAll('{tried}', tried.toString()).replaceAll('{total}', total.toString());

  // Onboarding
  String get onboardingTitle1 => get('onboardingTitle1');
  String get onboardingDesc1 => get('onboardingDesc1');
  String get onboardingTitle2 => get('onboardingTitle2');
  String get onboardingDesc2 => get('onboardingDesc2');
  String get onboardingTitle3 => get('onboardingTitle3');
  String get onboardingDesc3 => get('onboardingDesc3');
  String get onboardingTitle4 => get('onboardingTitle4');
  String get onboardingDesc4 => get('onboardingDesc4');
  String get getStarted => get('getStarted');
  String get skip => get('skip');
  String get next => get('next');

  // Tips screen sections
  String get sectionGettingStarted => get('sectionGettingStarted');
  String get sectionSafety => get('sectionSafety');
  String get sectionPracticalTips => get('sectionPracticalTips');
  String get sectionNutrition => get('sectionNutrition');

  // Food names
  String getFoodName(String foodId) => get('food_$foodId');
  String getFoodPreparation(String foodId) => get('prep_$foodId');
  String getFoodAllergenInfo(String foodId) => get('allergen_$foodId');
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['pt', 'en', 'es'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

// Portuguese translations
const Map<String, String> _ptTranslations = {
  // App general
  'appTitle': 'Introducao Alimentar',
  'appSubtitle': 'Guia completo de BLW para seu bebe',

  // Navigation
  'foods': 'Alimentos',
  'foodDiary': 'Diario Alimentar',
  'allergens': 'Alergenicos',
  'blwTips': 'Dicas de BLW',

  // Subtitles
  'foodsSubtitle': 'Descubra o que oferecer em cada fase',
  'diarySubtitle': 'Registre os alimentos introduzidos',
  'allergensSubtitle': 'Alimentos que precisam de atencao',
  'tipsSubtitle': 'Aprenda as melhores praticas',
  'infoCardText':
      'A introducao alimentar deve comecar aos 6 meses, mantendo o aleitamento materno.',

  // Food categories
  'fruits': 'Frutas',
  'vegetables': 'Legumes e Verduras',
  'proteins': 'Proteinas',
  'grains': 'Cereais e Graos',
  'dairy': 'Laticinios',

  // Age groups
  'sixMonths': '6 meses',
  'sevenMonths': '7 meses',
  'eightMonths': '8 meses',
  'nineMonths': '9 meses',
  'tenToTwelveMonths': '10-12 meses',
  'afterOneYear': 'Apos 1 ano',
  'fromAge': 'A partir de {age}',

  // Acceptance
  'loved': 'Amou',
  'liked': 'Gostou',
  'neutral': 'Neutro',
  'disliked': 'Nao gostou',
  'refused': 'Recusou',

  // Reactions
  'noReaction': 'Sem reacao',
  'mildReaction': 'Leve',
  'moderateReaction': 'Moderada',
  'severeReaction': 'Severa',

  // Food detail
  'category': 'Categoria',
  'howToPrepare': 'Como Preparar',
  'allergenWarning': 'Atencao: Alergenico',
  'allergenDefaultInfo':
      'Este alimento pode causar reacoes alergicas. Introduza com cautela e observe o bebe por 3 dias.',
  'addToDiary': 'Registrar no Diario',

  // Food log
  'noRecordsYet': 'Nenhum registro ainda',
  'startRecording':
      'Comece a registrar os alimentos\nque seu bebe experimentou!',
  'addRecord': 'Adicionar Registro',
  'today': 'Hoje',
  'yesterday': 'Ontem',
  'deleteRecord': 'Excluir registro?',
  'deleteRecordConfirm': 'Deseja excluir o registro de {food}?',
  'cancel': 'Cancelar',
  'delete': 'Excluir',

  // Food log detail
  'details': 'Detalhes',
  'edit': 'Editar',
  'acceptance': 'Aceitacao',
  'reaction': 'Reacao',
  'deleteRecordButton': 'Excluir Registro',

  // Add food log
  'newRecord': 'Novo Registro',
  'food': 'Alimento',
  'selectFood': 'Selecione um alimento',
  'date': 'Data',
  'howWasAcceptance': 'Como foi a aceitacao?',
  'anyReaction': 'Houve alguma reacao?',
  'notes': 'Observacoes',
  'notesOptional': 'Observacoes (opcional)',
  'notesHint': 'Ex: Comeu bem no almoco, fez careta no inicio...',
  'saveRecord': 'Salvar Registro',
  'recordSaved': 'Registro de {food} salvo!',

  // Allergens screen
  'allergenicFoods': 'Alimentos Alergenicos',
  'whatAreAllergens': 'O que sao alergenicos?',
  'allergensExplanation':
      'Alergenicos sao alimentos que tem maior probabilidade de causar reacoes alergicas. E importante introduzi-los com cuidado, um de cada vez, para identificar possiveis alergias.',
  'howToIntroduce': 'Como introduzir',
  'step1': 'Ofereca pela manha para observar reacoes durante o dia',
  'step2': 'Comece com pequenas quantidades',
  'step3': 'Aguarde 3 dias antes de introduzir outro alergenico',
  'step4': 'Observe sinais de alergia: manchas, inchacos, vomito, diarreia',
  'step5': 'Se houver reacao, suspenda e procure o pediatra',

  // Tips screen
  'whenToStart': 'Quando comecar?',
  'whenToStartContent':
      'A introducao alimentar deve comecar aos 6 meses de idade, quando o bebe:\n\n- Consegue sentar com apoio minimo\n- Perdeu o reflexo de protrusao da lingua\n- Demonstra interesse pela comida\n- Consegue pegar objetos e leva-los a boca',
  'whatIsBLW': 'O que e BLW?',
  'whatIsBLWContent':
      'Baby-Led Weaning (BLW) e um metodo de introducao alimentar onde o bebe se alimenta sozinho desde o inicio.\n\nO bebe pega os alimentos com as proprias maos e decide o que, quanto e em que ritmo comer.\n\nIsso estimula a autonomia, coordenacao motora e autorregulacao.',
  'howToCut': 'Como cortar os alimentos?',
  'howToCutContent':
      'Para bebes de 6-9 meses:\n- Corte em formato de palitos (tamanho do seu dedo)\n- O alimento deve ser macio o suficiente para amassar com os dedos\n\nApos 9 meses (movimento de pinca):\n- Pode oferecer pedacos menores\n- Cubos de 1-2 cm',
  'chokingVsGag': 'Engasgo vs. Gag Reflex',
  'chokingVsGagContent':
      'GAG (reflexo de nausea):\n- E normal e protetor\n- O bebe faz barulho, tosse, fica vermelho\n- Nao interfira, ele esta aprendendo\n\nENGASGO (obstrucao):\n- Silencioso, bebe nao consegue tossir\n- Fica roxo/azulado\n- Requer intervencao imediata',
  'forbiddenFoods': 'Alimentos proibidos',
  'forbiddenFoodsContent':
      'ATE 1 ANO - EVITAR:\n- Mel (risco de botulismo)\n- Sal e acucar\n- Leite de vaca como bebida\n- Alimentos ultraprocessados\n\nRISCO DE ENGASGO:\n- Uvas inteiras (corte em 4)\n- Tomate cereja inteiro\n- Oleaginosas inteiras\n- Pipoca\n- Alimentos duros e redondos',
  'importantTips': 'Dicas importantes',
  'importantTipsContent':
      '1. Ofereca o alimento pelo menos 10-15 vezes antes de desistir\n\n2. Nao force a alimentacao\n\n3. Coma junto com o bebe - ele aprende por imitacao\n\n4. Mantenha o ambiente calmo e sem distraccoes\n\n5. Ofereca agua em copo aberto\n\n6. O leite materno/formula continua sendo a principal fonte de nutricao ate 1 ano',
  'safety': 'Seguranca',
  'safetyContent':
      '- Sempre supervisione as refeicoes\n\n- O bebe deve estar sentado ereto (90 graus)\n\n- Use cadeira de alimentacao adequada\n\n- Faca um curso de primeiros socorros\n\n- Nunca ofereca alimentos com o bebe deitado ou andando\n\n- Teste a temperatura dos alimentos antes de oferecer',
  'consultPediatrician':
      'Consulte sempre o pediatra do seu bebe antes de iniciar a introducao alimentar.',
  'patience': 'Paciencia e Persistencia',
  'patienceContent':
      'E normal o bebe rejeitar alimentos novas vezes.\n\n- Ofereca o mesmo alimento de 10 a 15 vezes\n- Mude a forma de preparo\n- De intervalos de alguns dias\n- Nao force, respeite os sinais do bebe\n- Cada bebe tem seu ritmo\n- Celebre pequenas conquistas\n\nA persistencia com paciencia e fundamental para uma boa relacao com a comida.',
  'familyMeals': 'Refeicoes em Familia',
  'familyMealsContent':
      'Comer junto e fundamental!\n\n- O bebe aprende por imitacao\n- Participe das refeicoes da familia\n- Coma os mesmos alimentos que oferece\n- Evite distracoes como TV e celular\n- Crie um ambiente calmo e positivo\n- Faca das refeicoes um momento de conexao\n\nBebes que comem com a familia tendem a ter melhor aceitacao alimentar.',
  'hydration': 'Agua e Hidratacao',
  'hydrationContent':
      'A partir dos 6 meses, ofereca agua!\n\n- Use copo aberto ou de transicao\n- Ofereca agua junto com as refeicoes\n- Nao precisa ser muita quantidade\n- Evite sucos (mesmo naturais) antes de 1 ano\n- O leite materno/formula continua sendo a principal fonte de liquido\n- Observe sinais de sede',
  'balancedDiet': 'Alimentacao Equilibrada',
  'balancedDietContent':
      'Ofereca variedade de grupos alimentares:\n\n- CARBOIDRATOS: arroz, batata, macarrao\n- PROTEINAS: carnes, ovos, leguminosas\n- VEGETAIS: legumes e verduras variados\n- FRUTAS: diferentes cores e texturas\n- GORDURAS BOAS: abacate, azeite\n\nA diversidade de cores no prato indica diversidade de nutrientes!',
  'ironRich': 'Alimentos Ricos em Ferro',
  'ironRichContent':
      'O ferro e essencial para o desenvolvimento!\n\n- Carnes vermelhas (melhor fonte)\n- Frango e peixe\n- Gema de ovo\n- Feijao e lentilha\n- Vegetais verde-escuros\n\nDICA: Combine com vitamina C (laranja, tomate) para melhor absorcao.\n\nA partir dos 6 meses, as reservas de ferro do bebe comecam a diminuir.',
  'varietyTip': 'Variedade de Sabores',
  'varietyTipContent':
      'Quanto mais sabores, melhor!\n\n- Ofereca diferentes texturas\n- Varie as formas de preparo\n- Inclua temperos naturais (ervas, especiarias suaves)\n- Evite mascarar sabores\n- Deixe o bebe explorar\n- Nao adicione sal ou acucar\n\nBebes expostos a variedade desde cedo tendem a ser menos seletivos no futuro.',

  // Recipes
  'recipes': 'Receitas',
  'recipesSubtitle': 'Receitas faceis e nutritivas para seu bebe',
  'recipe': 'Receita',
  'all': 'Todas',
  'breakfast': 'Cafe da Manha',
  'lunch': 'Almoco',
  'dinner': 'Jantar',
  'snack': 'Lanche',
  'allergen': 'Alergenico',
  'ingredients': 'Ingredientes',
  'instructions': 'Modo de Preparo',
  'tip': 'Dica',

  // No foods message
  'noFoodsAvailable': 'Nenhum alimento disponivel',
  'noFoodsForAge': 'para {age}',

  // Food names
  'food_banana': 'Banana',
  'food_abacate': 'Abacate',
  'food_manga': 'Manga',
  'food_pera': 'Pera',
  'food_mamao': 'Mamao',
  'food_melao': 'Melao',
  'food_melancia': 'Melancia',
  'food_maca': 'Maca',
  'food_morango': 'Morango',
  'food_kiwi': 'Kiwi',
  'food_laranja': 'Laranja',
  'food_batata_doce': 'Batata Doce',
  'food_cenoura': 'Cenoura',
  'food_abobora': 'Abobora',
  'food_chuchu': 'Chuchu',
  'food_brocolis': 'Brocolis',
  'food_couve_flor': 'Couve-flor',
  'food_abobrinha': 'Abobrinha',
  'food_vagem': 'Vagem',
  'food_beterraba': 'Beterraba',
  'food_inhame': 'Inhame',
  'food_tomate': 'Tomate',
  'food_pepino': 'Pepino',
  'food_frango': 'Frango',
  'food_carne_bovina': 'Carne Bovina',
  'food_gema_ovo': 'Gema de Ovo',
  'food_peixe': 'Peixe',
  'food_feijao': 'Feijao',
  'food_lentilha': 'Lentilha',
  'food_grao_de_bico': 'Grao de Bico',
  'food_ovo_inteiro': 'Ovo Inteiro',
  'food_camarao': 'Camarao',
  'food_arroz': 'Arroz',
  'food_aveia': 'Aveia',
  'food_macarrao': 'Macarrao',
  'food_pao': 'Pao',
  'food_quinoa': 'Quinoa',
  'food_iogurte_natural': 'Iogurte Natural',
  'food_queijo': 'Queijo',
  'food_leite_vaca': 'Leite de Vaca',

  // Food preparations
  'prep_banana':
      'Corte em formato de palito ou amasse levemente. Pode deixar com parte da casca para facilitar a pegada.',
  'prep_abacate':
      'Corte em fatias ou amasse. Rico em gorduras boas para o desenvolvimento cerebral.',
  'prep_manga':
      'Corte em palitos ou ofereca no caroco para o bebe segurar e chupar.',
  'prep_pera':
      'Ofereca madura e macia, cortada em palitos. Pode cozinhar levemente se estiver muito dura.',
  'prep_mamao': 'Ofereca maduro em pedacos ou amassado. Otimo para o intestino.',
  'prep_melao': 'Corte em palitos finos. Bem maduro fica mais macio.',
  'prep_melancia':
      'Remova as sementes e corte em palitos. Muito refrescante!',
  'prep_maca':
      'Cozinhe no vapor ate ficar macia ou rale. Crua so apos 1 ano.',
  'prep_morango': 'Corte ao meio ou em quartos. Lave muito bem.',
  'prep_kiwi': 'Descasque e corte em rodelas ou palitos.',
  'prep_laranja':
      'Ofereca em gomos sem a pele fina. Prefira variedades menos acidas.',
  'prep_batata_doce':
      'Cozinhe no vapor e corte em palitos. Rica em vitamina A.',
  'prep_cenoura':
      'Cozinhe no vapor ate ficar bem macia. Corte em palitos grossos.',
  'prep_abobora':
      'Cozinhe no vapor ou asse. Fica bem macia e docinha.',
  'prep_chuchu':
      'Cozinhe bem e corte em palitos. Sabor suave, otimo para comecar.',
  'prep_brocolis':
      'Cozinhe no vapor os floretes. O talo serve de "cabo" para segurar.',
  'prep_couve_flor':
      'Cozinhe no vapor ate ficar macia. Ofereca os floretes.',
  'prep_abobrinha':
      'Cozinhe no vapor ou grelhada. Corte em palitos com casca.',
  'prep_vagem':
      'Cozinhe no vapor ate ficar macia. Formato ideal para BLW.',
  'prep_beterraba':
      'Cozinhe ate ficar macia e corte em palitos. Mancha as roupas!',
  'prep_inhame':
      'Cozinhe bem e amasse ou corte em pedacos. Muito nutritivo.',
  'prep_tomate':
      'Remova as sementes e a pele. Corte em pedacos pequenos.',
  'prep_pepino': 'Descasque, remova as sementes e corte em palitos.',
  'prep_frango':
      'Cozinhe bem e desfie ou corte em tiras. Coxa e sobrecoxa sao mais macias.',
  'prep_carne_bovina':
      'Cozinhe ate ficar bem macia. Cortes como patinho e maminha sao bons. Desfie ou corte em tiras.',
  'prep_gema_ovo':
      'Cozinhe bem (gema dura) e ofereca amassada ou em pedacos.',
  'prep_peixe':
      'Prefira peixes de agua doce ou sardinha. Cozinhe bem e remova todas as espinhas.',
  'prep_feijao':
      'Cozinhe bem e amasse levemente. Pode oferecer o caldo tambem.',
  'prep_lentilha': 'Cozinhe ate ficar bem macia. Rica em ferro.',
  'prep_grao_de_bico':
      'Cozinhe muito bem e amasse (homus) ou ofereca inteiro supervisionado.',
  'prep_ovo_inteiro':
      'Apos introduzir a gema sem reacoes, pode oferecer o ovo inteiro bem cozido.',
  'prep_camarao':
      'Cozinhe bem e corte em pedacos pequenos. Introduza com cautela.',
  'prep_arroz':
      'Cozinhe ate ficar bem macio. Pode amassar levemente ou fazer bolinhos.',
  'prep_aveia':
      'Cozinhe com agua ou leite materno. Faca mingau ou panquecas.',
  'prep_macarrao':
      'Cozinhe ate ficar bem macio. Formatos como fusilli sao faceis de pegar.',
  'prep_pao':
      'Ofereca em tiras ou torrado levemente. Prefira paes sem acucar.',
  'prep_quinoa':
      'Cozinhe bem e misture com vegetais. Muito nutritiva!',
  'prep_iogurte_natural':
      'Ofereca integral e sem acucar. Pode misturar com frutas.',
  'prep_queijo':
      'Prefira queijos pasteurizados como mussarela ou ricota. Corte em palitos.',
  'prep_leite_vaca':
      'Apenas apos 1 ano como bebida. Antes pode usar em preparacoes.',

  // Allergen info
  'allergen_gema_ovo':
      'Ovo e um dos principais alergenicos. Introduza em pequenas quantidades e observe por 3 dias.',
  'allergen_peixe':
      'Peixe pode causar alergia. Comece com peixes menos alergenicos como tilapia.',
  'allergen_ovo_inteiro': 'A clara do ovo e mais alergenica que a gema.',
  'allergen_camarao':
      'Frutos do mar sao altamente alergenicos. Introduza apos 1 ano com supervisao.',
  'allergen_aveia':
      'Pode conter tracos de gluten. Use aveia certificada sem gluten se necessario.',
  'allergen_macarrao': 'Contem gluten. Observe reacoes.',
  'allergen_pao': 'Contem gluten e pode conter leite.',
  'allergen_iogurte_natural':
      'Derivado do leite de vaca. Observe intolerancia a lactose ou alergia a proteina do leite.',
  'allergen_queijo':
      'Derivado do leite. Evite queijos maturados pelo alto teor de sodio.',
  'allergen_leite_vaca':
      'Nao deve substituir o leite materno ou formula antes de 1 ano.',

  // Gallery and photos
  'gallery': 'Galeria',
  'noPhotosYet': 'Nenhuma foto ainda',
  'addPhotosHint': 'Adicione fotos do seu bebe\nexperimentando novos alimentos!',
  'unlimitedPhotos': 'Fotos ilimitadas',
  'upgradeToPremium': 'Atualize para Premium',
  'shareGalleryText': 'Veja as fotos da introducao alimentar do meu bebe!',
  'sharePhotoText': 'Meu bebe experimentando {food}!',
  'deletePhoto': 'Excluir foto?',
  'deletePhotoConfirm': 'Deseja excluir esta foto?',
  'addPhoto': 'Adicionar foto',
  'takePhoto': 'Tirar foto',
  'chooseFromGallery': 'Escolher da galeria',
  'photos': 'Fotos',
  'photoLimitReached': 'Limite de fotos atingido. Atualize para Premium!',

  // Premium
  'youArePremium': 'Voce e Premium!',
  'premiumActiveDescription': 'Aproveite todos os recursos ilimitados do app.',
  'validUntil': 'Valido ate',
  'goBack': 'Voltar',
  'goPremium': 'Seja Premium',
  'premiumDescription': 'Desbloqueie todos os recursos e apoie o desenvolvimento do app.',
  'monthlyPlan': 'Mensal',
  'monthlyPlanDescription': 'R\$ 9,90/mes',
  'yearlyPlan': 'Anual',
  'yearlyPlanDescription': 'R\$ 59,90/ano - Economize 50%',
  'lifetimePlan': 'Vitalicio',
  'lifetimePlanDescription': 'Pague uma vez, use para sempre',
  'restorePurchases': 'Restaurar compras',
  'purchaseDisclaimer': 'O pagamento sera processado pela sua conta da loja de aplicativos.',
  'featureUnlimitedPhotos': 'Fotos ilimitadas',
  'featureMoreRecipes': 'Mais receitas por alimento',
  'featureNoAds': 'Sem anuncios',
  'featurePrioritySupport': 'Suporte prioritario',
  'mostPopular': 'Mais Popular',
  'purchaseSuccess': 'Compra realizada com sucesso!',
  'timesOffered': '{count}x oferecido',
  'neverOffered': 'Nunca oferecido',

  // Celebration
  'firstTime': 'Primeira vez!',
  'addedToDiary': 'foi adicionado ao diário do bebê!',
  'tapToContinue': 'Toque para continuar',

  // Home screen
  'quickActions': 'Ações Rápidas',
  'addRecordSubtitle': 'Registre um novo alimento',
  'progress': 'Progresso',
  'foodsTried': 'Alimentos\nExperimentados',
  'totalRecords': 'Total de\nRegistros',
  'photosSaved': 'Fotos\nSalvas',
  'recentActivity': 'Atividade Recente',
  'foodsTriedOf': '{tried} de {total}',

  // Onboarding
  'onboardingTitle1': 'Bem-vindo!',
  'onboardingDesc1': 'Acompanhe a introducao alimentar do seu bebe de forma simples e organizada.',
  'onboardingTitle2': 'Descubra Alimentos',
  'onboardingDesc2': 'Saiba quais alimentos oferecer em cada fase e como prepara-los de forma segura.',
  'onboardingTitle3': 'Registre Tudo',
  'onboardingDesc3': 'Anote a aceitacao, reacoes e tire fotos para acompanhar a evolucao.',
  'onboardingTitle4': 'Aprenda sobre BLW',
  'onboardingDesc4': 'Dicas e orientacoes para uma introducao alimentar segura e prazerosa.',
  'getStarted': 'Comecar',
  'skip': 'Pular',
  'next': 'Proximo',

  // Tips screen sections
  'sectionGettingStarted': 'Primeiros Passos',
  'sectionSafety': 'Segurança',
  'sectionPracticalTips': 'Dicas Práticas',
  'sectionNutrition': 'Nutrição',
};

// English translations
const Map<String, String> _enTranslations = {
  // App general
  'appTitle': 'Baby Food Introduction',
  'appSubtitle': 'Complete BLW guide for your baby',

  // Navigation
  'foods': 'Foods',
  'foodDiary': 'Food Diary',
  'allergens': 'Allergens',
  'blwTips': 'BLW Tips',

  // Subtitles
  'foodsSubtitle': 'Discover what to offer at each stage',
  'diarySubtitle': 'Record introduced foods',
  'allergensSubtitle': 'Foods that need attention',
  'tipsSubtitle': 'Learn the best practices',
  'infoCardText':
      'Food introduction should start at 6 months, while maintaining breastfeeding.',

  // Food categories
  'fruits': 'Fruits',
  'vegetables': 'Vegetables',
  'proteins': 'Proteins',
  'grains': 'Grains & Cereals',
  'dairy': 'Dairy',

  // Age groups
  'sixMonths': '6 months',
  'sevenMonths': '7 months',
  'eightMonths': '8 months',
  'nineMonths': '9 months',
  'tenToTwelveMonths': '10-12 months',
  'afterOneYear': 'After 1 year',
  'fromAge': 'From {age}',

  // Acceptance
  'loved': 'Loved it',
  'liked': 'Liked it',
  'neutral': 'Neutral',
  'disliked': 'Disliked',
  'refused': 'Refused',

  // Reactions
  'noReaction': 'No reaction',
  'mildReaction': 'Mild',
  'moderateReaction': 'Moderate',
  'severeReaction': 'Severe',

  // Food detail
  'category': 'Category',
  'howToPrepare': 'How to Prepare',
  'allergenWarning': 'Warning: Allergen',
  'allergenDefaultInfo':
      'This food may cause allergic reactions. Introduce with caution and observe your baby for 3 days.',
  'addToDiary': 'Add to Diary',

  // Food log
  'noRecordsYet': 'No records yet',
  'startRecording':
      'Start recording the foods\nyour baby has tried!',
  'addRecord': 'Add Record',
  'today': 'Today',
  'yesterday': 'Yesterday',
  'deleteRecord': 'Delete record?',
  'deleteRecordConfirm': 'Do you want to delete the {food} record?',
  'cancel': 'Cancel',
  'delete': 'Delete',

  // Food log detail
  'details': 'Details',
  'edit': 'Edit',
  'acceptance': 'Acceptance',
  'reaction': 'Reaction',
  'deleteRecordButton': 'Delete Record',

  // Add food log
  'newRecord': 'New Record',
  'food': 'Food',
  'selectFood': 'Select a food',
  'date': 'Date',
  'howWasAcceptance': 'How was the acceptance?',
  'anyReaction': 'Any reaction?',
  'notes': 'Notes',
  'notesOptional': 'Notes (optional)',
  'notesHint': 'E.g.: Ate well at lunch, made a face at first...',
  'saveRecord': 'Save Record',
  'recordSaved': '{food} record saved!',

  // Allergens screen
  'allergenicFoods': 'Allergenic Foods',
  'whatAreAllergens': 'What are allergens?',
  'allergensExplanation':
      'Allergens are foods that are more likely to cause allergic reactions. It\'s important to introduce them carefully, one at a time, to identify possible allergies.',
  'howToIntroduce': 'How to introduce',
  'step1': 'Offer in the morning to observe reactions during the day',
  'step2': 'Start with small amounts',
  'step3': 'Wait 3 days before introducing another allergen',
  'step4': 'Watch for allergy signs: rashes, swelling, vomiting, diarrhea',
  'step5': 'If there\'s a reaction, stop and consult the pediatrician',

  // Tips screen
  'whenToStart': 'When to start?',
  'whenToStartContent':
      'Food introduction should start at 6 months of age, when the baby:\n\n- Can sit with minimal support\n- Has lost the tongue thrust reflex\n- Shows interest in food\n- Can grasp objects and bring them to mouth',
  'whatIsBLW': 'What is BLW?',
  'whatIsBLWContent':
      'Baby-Led Weaning (BLW) is a method of food introduction where the baby feeds themselves from the start.\n\nThe baby picks up food with their own hands and decides what, how much, and at what pace to eat.\n\nThis encourages autonomy, motor coordination, and self-regulation.',
  'howToCut': 'How to cut foods?',
  'howToCutContent':
      'For babies 6-9 months:\n- Cut into stick shapes (size of your finger)\n- Food should be soft enough to mash with fingers\n\nAfter 9 months (pincer grasp):\n- Can offer smaller pieces\n- 1-2 cm cubes',
  'chokingVsGag': 'Choking vs. Gag Reflex',
  'chokingVsGagContent':
      'GAG (gag reflex):\n- It\'s normal and protective\n- Baby makes noise, coughs, turns red\n- Don\'t interfere, they\'re learning\n\nCHOKING (obstruction):\n- Silent, baby can\'t cough\n- Turns blue/purple\n- Requires immediate intervention',
  'forbiddenFoods': 'Forbidden foods',
  'forbiddenFoodsContent':
      'UNTIL 1 YEAR - AVOID:\n- Honey (botulism risk)\n- Salt and sugar\n- Cow\'s milk as a drink\n- Ultra-processed foods\n\nCHOKING RISK:\n- Whole grapes (cut in 4)\n- Whole cherry tomatoes\n- Whole nuts\n- Popcorn\n- Hard and round foods',
  'importantTips': 'Important tips',
  'importantTipsContent':
      '1. Offer the food at least 10-15 times before giving up\n\n2. Don\'t force feeding\n\n3. Eat with your baby - they learn by imitation\n\n4. Keep the environment calm and distraction-free\n\n5. Offer water in an open cup\n\n6. Breast milk/formula remains the main nutrition source until 1 year',
  'safety': 'Safety',
  'safetyContent':
      '- Always supervise meals\n\n- Baby should be sitting upright (90 degrees)\n\n- Use an appropriate high chair\n\n- Take a first aid course\n\n- Never offer food with baby lying down or walking\n\n- Test food temperature before offering',
  'consultPediatrician':
      'Always consult your baby\'s pediatrician before starting food introduction.',
  'patience': 'Patience and Persistence',
  'patienceContent':
      'It\'s normal for babies to reject new foods.\n\n- Offer the same food 10-15 times\n- Change the preparation method\n- Take breaks of a few days\n- Don\'t force, respect baby\'s signals\n- Every baby has their own pace\n- Celebrate small wins\n\nPersistence with patience is key to a good relationship with food.',
  'familyMeals': 'Family Meals',
  'familyMealsContent':
      'Eating together is fundamental!\n\n- Baby learns by imitation\n- Join family meals\n- Eat the same foods you offer\n- Avoid distractions like TV and phones\n- Create a calm, positive environment\n- Make meals a time for connection\n\nBabies who eat with family tend to have better food acceptance.',
  'hydration': 'Water and Hydration',
  'hydrationContent':
      'From 6 months, offer water!\n\n- Use open cup or training cup\n- Offer water with meals\n- Doesn\'t need to be much\n- Avoid juices (even natural) before 1 year\n- Breast milk/formula remains main liquid source\n- Watch for thirst signs',
  'balancedDiet': 'Balanced Diet',
  'balancedDietContent':
      'Offer variety from food groups:\n\n- CARBS: rice, potato, pasta\n- PROTEINS: meats, eggs, legumes\n- VEGETABLES: various veggies\n- FRUITS: different colors and textures\n- HEALTHY FATS: avocado, olive oil\n\nColor diversity on the plate means nutrient diversity!',
  'ironRich': 'Iron-Rich Foods',
  'ironRichContent':
      'Iron is essential for development!\n\n- Red meat (best source)\n- Chicken and fish\n- Egg yolk\n- Beans and lentils\n- Dark leafy greens\n\nTIP: Pair with vitamin C (orange, tomato) for better absorption.\n\nFrom 6 months, baby\'s iron reserves start to decrease.',
  'varietyTip': 'Variety of Flavors',
  'varietyTipContent':
      'The more flavors, the better!\n\n- Offer different textures\n- Vary preparation methods\n- Include natural seasonings (herbs, mild spices)\n- Avoid masking flavors\n- Let baby explore\n- Don\'t add salt or sugar\n\nBabies exposed to variety early tend to be less picky later.',

  // Recipes
  'recipes': 'Recipes',
  'recipesSubtitle': 'Easy and nutritious recipes for your baby',
  'recipe': 'Recipe',
  'all': 'All',
  'breakfast': 'Breakfast',
  'lunch': 'Lunch',
  'dinner': 'Dinner',
  'snack': 'Snack',
  'allergen': 'Allergen',
  'ingredients': 'Ingredients',
  'instructions': 'Instructions',
  'tip': 'Tip',

  // No foods message
  'noFoodsAvailable': 'No foods available',
  'noFoodsForAge': 'for {age}',

  // Food names
  'food_banana': 'Banana',
  'food_abacate': 'Avocado',
  'food_manga': 'Mango',
  'food_pera': 'Pear',
  'food_mamao': 'Papaya',
  'food_melao': 'Cantaloupe',
  'food_melancia': 'Watermelon',
  'food_maca': 'Apple',
  'food_morango': 'Strawberry',
  'food_kiwi': 'Kiwi',
  'food_laranja': 'Orange',
  'food_batata_doce': 'Sweet Potato',
  'food_cenoura': 'Carrot',
  'food_abobora': 'Pumpkin',
  'food_chuchu': 'Chayote',
  'food_brocolis': 'Broccoli',
  'food_couve_flor': 'Cauliflower',
  'food_abobrinha': 'Zucchini',
  'food_vagem': 'Green Beans',
  'food_beterraba': 'Beet',
  'food_inhame': 'Yam',
  'food_tomate': 'Tomato',
  'food_pepino': 'Cucumber',
  'food_frango': 'Chicken',
  'food_carne_bovina': 'Beef',
  'food_gema_ovo': 'Egg Yolk',
  'food_peixe': 'Fish',
  'food_feijao': 'Beans',
  'food_lentilha': 'Lentils',
  'food_grao_de_bico': 'Chickpea',
  'food_ovo_inteiro': 'Whole Egg',
  'food_camarao': 'Shrimp',
  'food_arroz': 'Rice',
  'food_aveia': 'Oatmeal',
  'food_macarrao': 'Pasta',
  'food_pao': 'Bread',
  'food_quinoa': 'Quinoa',
  'food_iogurte_natural': 'Plain Yogurt',
  'food_queijo': 'Cheese',
  'food_leite_vaca': 'Cow\'s Milk',

  // Food preparations
  'prep_banana':
      'Cut into stick shape or mash lightly. Can leave part of the peel to help grip.',
  'prep_abacate':
      'Cut into slices or mash. Rich in healthy fats for brain development.',
  'prep_manga':
      'Cut into sticks or offer on the pit for baby to hold and suck.',
  'prep_pera':
      'Offer ripe and soft, cut into sticks. Can lightly cook if too hard.',
  'prep_mamao':
      'Offer ripe in pieces or mashed. Great for digestion.',
  'prep_melao': 'Cut into thin sticks. Very ripe is softer.',
  'prep_melancia':
      'Remove seeds and cut into sticks. Very refreshing!',
  'prep_maca':
      'Steam until soft or grate. Raw only after 1 year.',
  'prep_morango': 'Cut in half or quarters. Wash very well.',
  'prep_kiwi': 'Peel and cut into slices or sticks.',
  'prep_laranja':
      'Offer in segments without the thin skin. Prefer less acidic varieties.',
  'prep_batata_doce':
      'Steam and cut into sticks. Rich in vitamin A.',
  'prep_cenoura':
      'Steam until very soft. Cut into thick sticks.',
  'prep_abobora':
      'Steam or roast. Becomes very soft and sweet.',
  'prep_chuchu':
      'Cook well and cut into sticks. Mild flavor, great for starting.',
  'prep_brocolis':
      'Steam the florets. The stem serves as a "handle" to hold.',
  'prep_couve_flor':
      'Steam until soft. Offer the florets.',
  'prep_abobrinha':
      'Steam or grill. Cut into sticks with skin.',
  'prep_vagem':
      'Steam until soft. Ideal shape for BLW.',
  'prep_beterraba':
      'Cook until soft and cut into sticks. Stains clothes!',
  'prep_inhame':
      'Cook well and mash or cut into pieces. Very nutritious.',
  'prep_tomate':
      'Remove seeds and skin. Cut into small pieces.',
  'prep_pepino': 'Peel, remove seeds and cut into sticks.',
  'prep_frango':
      'Cook well and shred or cut into strips. Thigh is more tender.',
  'prep_carne_bovina':
      'Cook until very tender. Cuts like rump are good. Shred or cut into strips.',
  'prep_gema_ovo':
      'Cook well (hard yolk) and offer mashed or in pieces.',
  'prep_peixe':
      'Prefer freshwater fish or sardines. Cook well and remove all bones.',
  'prep_feijao':
      'Cook well and mash lightly. Can offer the broth too.',
  'prep_lentilha': 'Cook until very soft. Rich in iron.',
  'prep_grao_de_bico':
      'Cook very well and mash (hummus) or offer whole supervised.',
  'prep_ovo_inteiro':
      'After introducing yolk without reactions, can offer whole well-cooked egg.',
  'prep_camarao':
      'Cook well and cut into small pieces. Introduce with caution.',
  'prep_arroz':
      'Cook until very soft. Can mash lightly or make balls.',
  'prep_aveia':
      'Cook with water or breast milk. Make porridge or pancakes.',
  'prep_macarrao':
      'Cook until very soft. Shapes like fusilli are easy to grab.',
  'prep_pao':
      'Offer in strips or lightly toasted. Prefer breads without sugar.',
  'prep_quinoa':
      'Cook well and mix with vegetables. Very nutritious!',
  'prep_iogurte_natural':
      'Offer whole and unsweetened. Can mix with fruits.',
  'prep_queijo':
      'Prefer pasteurized cheeses like mozzarella or ricotta. Cut into sticks.',
  'prep_leite_vaca':
      'Only after 1 year as a drink. Before that can use in preparations.',

  // Allergen info
  'allergen_gema_ovo':
      'Egg is one of the main allergens. Introduce in small amounts and observe for 3 days.',
  'allergen_peixe':
      'Fish can cause allergies. Start with less allergenic fish like tilapia.',
  'allergen_ovo_inteiro': 'Egg white is more allergenic than yolk.',
  'allergen_camarao':
      'Shellfish are highly allergenic. Introduce after 1 year with supervision.',
  'allergen_aveia':
      'May contain traces of gluten. Use certified gluten-free oats if necessary.',
  'allergen_macarrao': 'Contains gluten. Watch for reactions.',
  'allergen_pao': 'Contains gluten and may contain milk.',
  'allergen_iogurte_natural':
      'Dairy product. Watch for lactose intolerance or milk protein allergy.',
  'allergen_queijo':
      'Dairy product. Avoid aged cheeses due to high sodium content.',
  'allergen_leite_vaca':
      'Should not replace breast milk or formula before 1 year.',

  // Gallery and photos
  'gallery': 'Gallery',
  'noPhotosYet': 'No photos yet',
  'addPhotosHint': 'Add photos of your baby\ntrying new foods!',
  'unlimitedPhotos': 'Unlimited photos',
  'upgradeToPremium': 'Upgrade to Premium',
  'shareGalleryText': 'Check out photos from my baby\'s food introduction journey!',
  'sharePhotoText': 'My baby trying {food}!',
  'deletePhoto': 'Delete photo?',
  'deletePhotoConfirm': 'Do you want to delete this photo?',
  'addPhoto': 'Add photo',
  'takePhoto': 'Take photo',
  'chooseFromGallery': 'Choose from gallery',
  'photos': 'Photos',
  'photoLimitReached': 'Photo limit reached. Upgrade to Premium!',

  // Premium
  'youArePremium': 'You\'re Premium!',
  'premiumActiveDescription': 'Enjoy all unlimited features of the app.',
  'validUntil': 'Valid until',
  'goBack': 'Go Back',
  'goPremium': 'Go Premium',
  'premiumDescription': 'Unlock all features and support app development.',
  'monthlyPlan': 'Monthly',
  'monthlyPlanDescription': '\$4.99/month',
  'yearlyPlan': 'Yearly',
  'yearlyPlanDescription': '\$29.99/year - Save 50%',
  'lifetimePlan': 'Lifetime',
  'lifetimePlanDescription': 'Pay once, use forever',
  'restorePurchases': 'Restore purchases',
  'purchaseDisclaimer': 'Payment will be processed through your app store account.',
  'featureUnlimitedPhotos': 'Unlimited photos',
  'featureMoreRecipes': 'More recipes per food',
  'featureNoAds': 'No ads',
  'featurePrioritySupport': 'Priority support',
  'mostPopular': 'Most Popular',
  'purchaseSuccess': 'Purchase successful!',
  'timesOffered': '{count}x offered',
  'neverOffered': 'Never offered',

  // Celebration
  'firstTime': 'First time!',
  'addedToDiary': 'was added to baby\'s diary!',
  'tapToContinue': 'Tap to continue',

  // Home screen
  'quickActions': 'Quick Actions',
  'addRecordSubtitle': 'Record a new food',
  'progress': 'Progress',
  'foodsTried': 'Foods\nTried',
  'totalRecords': 'Total\nRecords',
  'photosSaved': 'Photos\nSaved',
  'recentActivity': 'Recent Activity',
  'foodsTriedOf': '{tried} of {total}',

  // Onboarding
  'onboardingTitle1': 'Welcome!',
  'onboardingDesc1': 'Track your baby\'s food introduction journey simply and organized.',
  'onboardingTitle2': 'Discover Foods',
  'onboardingDesc2': 'Learn which foods to offer at each stage and how to prepare them safely.',
  'onboardingTitle3': 'Record Everything',
  'onboardingDesc3': 'Note acceptance, reactions, and take photos to track progress.',
  'onboardingTitle4': 'Learn about BLW',
  'onboardingDesc4': 'Tips and guidelines for a safe and enjoyable food introduction.',
  'getStarted': 'Get Started',
  'skip': 'Skip',
  'next': 'Next',

  // Tips screen sections
  'sectionGettingStarted': 'Getting Started',
  'sectionSafety': 'Safety',
  'sectionPracticalTips': 'Practical Tips',
  'sectionNutrition': 'Nutrition',
};

// Spanish translations
const Map<String, String> _esTranslations = {
  // App general
  'appTitle': 'Introduccion Alimentaria',
  'appSubtitle': 'Guia completa de BLW para tu bebe',

  // Navigation
  'foods': 'Alimentos',
  'foodDiary': 'Diario Alimentario',
  'allergens': 'Alergenicos',
  'blwTips': 'Consejos BLW',

  // Subtitles
  'foodsSubtitle': 'Descubre que ofrecer en cada etapa',
  'diarySubtitle': 'Registra los alimentos introducidos',
  'allergensSubtitle': 'Alimentos que necesitan atencion',
  'tipsSubtitle': 'Aprende las mejores practicas',
  'infoCardText':
      'La introduccion alimentaria debe comenzar a los 6 meses, manteniendo la lactancia materna.',

  // Food categories
  'fruits': 'Frutas',
  'vegetables': 'Verduras y Legumbres',
  'proteins': 'Proteinas',
  'grains': 'Cereales y Granos',
  'dairy': 'Lacteos',

  // Age groups
  'sixMonths': '6 meses',
  'sevenMonths': '7 meses',
  'eightMonths': '8 meses',
  'nineMonths': '9 meses',
  'tenToTwelveMonths': '10-12 meses',
  'afterOneYear': 'Despues de 1 ano',
  'fromAge': 'A partir de {age}',

  // Acceptance
  'loved': 'Le encanto',
  'liked': 'Le gusto',
  'neutral': 'Neutro',
  'disliked': 'No le gusto',
  'refused': 'Rechazo',

  // Reactions
  'noReaction': 'Sin reaccion',
  'mildReaction': 'Leve',
  'moderateReaction': 'Moderada',
  'severeReaction': 'Severa',

  // Food detail
  'category': 'Categoria',
  'howToPrepare': 'Como Preparar',
  'allergenWarning': 'Atencion: Alergenico',
  'allergenDefaultInfo':
      'Este alimento puede causar reacciones alergicas. Introduce con precaucion y observa al bebe durante 3 dias.',
  'addToDiary': 'Agregar al Diario',

  // Food log
  'noRecordsYet': 'Sin registros aun',
  'startRecording':
      'Comienza a registrar los alimentos\nque tu bebe ha probado!',
  'addRecord': 'Agregar Registro',
  'today': 'Hoy',
  'yesterday': 'Ayer',
  'deleteRecord': 'Eliminar registro?',
  'deleteRecordConfirm': 'Deseas eliminar el registro de {food}?',
  'cancel': 'Cancelar',
  'delete': 'Eliminar',

  // Food log detail
  'details': 'Detalles',
  'edit': 'Editar',
  'acceptance': 'Aceptacion',
  'reaction': 'Reaccion',
  'deleteRecordButton': 'Eliminar Registro',

  // Add food log
  'newRecord': 'Nuevo Registro',
  'food': 'Alimento',
  'selectFood': 'Selecciona un alimento',
  'date': 'Fecha',
  'howWasAcceptance': 'Como fue la aceptacion?',
  'anyReaction': 'Hubo alguna reaccion?',
  'notes': 'Notas',
  'notesOptional': 'Notas (opcional)',
  'notesHint': 'Ej: Comio bien en el almuerzo, hizo muecas al principio...',
  'saveRecord': 'Guardar Registro',
  'recordSaved': 'Registro de {food} guardado!',

  // Allergens screen
  'allergenicFoods': 'Alimentos Alergenicos',
  'whatAreAllergens': 'Que son los alergenicos?',
  'allergensExplanation':
      'Los alergenicos son alimentos que tienen mayor probabilidad de causar reacciones alergicas. Es importante introducirlos con cuidado, uno a la vez, para identificar posibles alergias.',
  'howToIntroduce': 'Como introducir',
  'step1': 'Ofrece por la manana para observar reacciones durante el dia',
  'step2': 'Comienza con pequenas cantidades',
  'step3': 'Espera 3 dias antes de introducir otro alergenico',
  'step4': 'Observa signos de alergia: manchas, hinchazon, vomito, diarrea',
  'step5': 'Si hay reaccion, suspende y consulta al pediatra',

  // Tips screen
  'whenToStart': 'Cuando empezar?',
  'whenToStartContent':
      'La introduccion alimentaria debe comenzar a los 6 meses de edad, cuando el bebe:\n\n- Puede sentarse con apoyo minimo\n- Perdio el reflejo de protrusion de la lengua\n- Muestra interes por la comida\n- Puede agarrar objetos y llevarlos a la boca',
  'whatIsBLW': 'Que es BLW?',
  'whatIsBLWContent':
      'Baby-Led Weaning (BLW) es un metodo de introduccion alimentaria donde el bebe se alimenta solo desde el inicio.\n\nEl bebe toma los alimentos con sus propias manos y decide que, cuanto y a que ritmo comer.\n\nEsto estimula la autonomia, coordinacion motora y autorregulacion.',
  'howToCut': 'Como cortar los alimentos?',
  'howToCutContent':
      'Para bebes de 6-9 meses:\n- Corta en forma de palitos (tamano de tu dedo)\n- El alimento debe ser suave para aplastar con los dedos\n\nDespues de 9 meses (movimiento de pinza):\n- Puede ofrecer pedazos mas pequenos\n- Cubos de 1-2 cm',
  'chokingVsGag': 'Atragantamiento vs. Reflejo Nauseoso',
  'chokingVsGagContent':
      'REFLEJO NAUSEOSO:\n- Es normal y protector\n- El bebe hace ruido, tose, se pone rojo\n- No interfieras, esta aprendiendo\n\nATRAGANTAMIENTO (obstruccion):\n- Silencioso, el bebe no puede toser\n- Se pone morado/azulado\n- Requiere intervencion inmediata',
  'forbiddenFoods': 'Alimentos prohibidos',
  'forbiddenFoodsContent':
      'HASTA 1 ANO - EVITAR:\n- Miel (riesgo de botulismo)\n- Sal y azucar\n- Leche de vaca como bebida\n- Alimentos ultraprocesados\n\nRIESGO DE ATRAGANTAMIENTO:\n- Uvas enteras (cortar en 4)\n- Tomates cherry enteros\n- Frutos secos enteros\n- Palomitas\n- Alimentos duros y redondos',
  'importantTips': 'Consejos importantes',
  'importantTipsContent':
      '1. Ofrece el alimento al menos 10-15 veces antes de rendirte\n\n2. No fuerces la alimentacion\n\n3. Come junto con el bebe - aprende por imitacion\n\n4. Mantiene el ambiente tranquilo y sin distracciones\n\n5. Ofrece agua en vaso abierto\n\n6. La leche materna/formula sigue siendo la principal fuente de nutricion hasta 1 ano',
  'safety': 'Seguridad',
  'safetyContent':
      '- Siempre supervisa las comidas\n\n- El bebe debe estar sentado erguido (90 grados)\n\n- Usa una silla de comer adecuada\n\n- Toma un curso de primeros auxilios\n\n- Nunca ofrezcas alimentos con el bebe acostado o caminando\n\n- Prueba la temperatura de los alimentos antes de ofrecer',
  'consultPediatrician':
      'Consulta siempre al pediatra de tu bebe antes de iniciar la introduccion alimentaria.',
  'patience': 'Paciencia y Persistencia',
  'patienceContent':
      'Es normal que el bebe rechace alimentos nuevos.\n\n- Ofrece el mismo alimento de 10 a 15 veces\n- Cambia la forma de preparacion\n- Da intervalos de algunos dias\n- No fuerces, respeta las senales del bebe\n- Cada bebe tiene su ritmo\n- Celebra pequenas conquistas\n\nLa persistencia con paciencia es fundamental para una buena relacion con la comida.',
  'familyMeals': 'Comidas en Familia',
  'familyMealsContent':
      'Comer juntos es fundamental!\n\n- El bebe aprende por imitacion\n- Participa en las comidas familiares\n- Come los mismos alimentos que ofreces\n- Evita distracciones como TV y celular\n- Crea un ambiente tranquilo y positivo\n- Haz de las comidas un momento de conexion\n\nBebes que comen con la familia tienden a tener mejor aceptacion alimentaria.',
  'hydration': 'Agua e Hidratacion',
  'hydrationContent':
      'A partir de los 6 meses, ofrece agua!\n\n- Usa vaso abierto o de transicion\n- Ofrece agua junto con las comidas\n- No necesita ser mucha cantidad\n- Evita jugos (incluso naturales) antes de 1 ano\n- La leche materna/formula sigue siendo la principal fuente de liquido\n- Observa senales de sed',
  'balancedDiet': 'Alimentacion Equilibrada',
  'balancedDietContent':
      'Ofrece variedad de grupos alimenticios:\n\n- CARBOHIDRATOS: arroz, papa, pasta\n- PROTEINAS: carnes, huevos, legumbres\n- VEGETALES: verduras variadas\n- FRUTAS: diferentes colores y texturas\n- GRASAS BUENAS: aguacate, aceite de oliva\n\nLa diversidad de colores en el plato indica diversidad de nutrientes!',
  'ironRich': 'Alimentos Ricos en Hierro',
  'ironRichContent':
      'El hierro es esencial para el desarrollo!\n\n- Carnes rojas (mejor fuente)\n- Pollo y pescado\n- Yema de huevo\n- Frijoles y lentejas\n- Vegetales de hoja verde oscura\n\nCONSEJO: Combina con vitamina C (naranja, tomate) para mejor absorcion.\n\nA partir de los 6 meses, las reservas de hierro del bebe comienzan a disminuir.',
  'varietyTip': 'Variedad de Sabores',
  'varietyTipContent':
      'Cuantos mas sabores, mejor!\n\n- Ofrece diferentes texturas\n- Varia las formas de preparacion\n- Incluye condimentos naturales (hierbas, especias suaves)\n- Evita enmascarar sabores\n- Deja que el bebe explore\n- No agregues sal o azucar\n\nBebes expuestos a variedad desde temprano tienden a ser menos selectivos en el futuro.',

  // Recipes
  'recipes': 'Recetas',
  'recipesSubtitle': 'Recetas faciles y nutritivas para tu bebe',
  'recipe': 'Receta',
  'all': 'Todas',
  'breakfast': 'Desayuno',
  'lunch': 'Almuerzo',
  'dinner': 'Cena',
  'snack': 'Merienda',
  'allergen': 'Alergenico',
  'ingredients': 'Ingredientes',
  'instructions': 'Instrucciones',
  'tip': 'Consejo',

  // No foods message
  'noFoodsAvailable': 'No hay alimentos disponibles',
  'noFoodsForAge': 'para {age}',

  // Food names
  'food_banana': 'Platano',
  'food_abacate': 'Aguacate',
  'food_manga': 'Mango',
  'food_pera': 'Pera',
  'food_mamao': 'Papaya',
  'food_melao': 'Melon',
  'food_melancia': 'Sandia',
  'food_maca': 'Manzana',
  'food_morango': 'Fresa',
  'food_kiwi': 'Kiwi',
  'food_laranja': 'Naranja',
  'food_batata_doce': 'Batata',
  'food_cenoura': 'Zanahoria',
  'food_abobora': 'Calabaza',
  'food_chuchu': 'Chayote',
  'food_brocolis': 'Brocoli',
  'food_couve_flor': 'Coliflor',
  'food_abobrinha': 'Calabacin',
  'food_vagem': 'Judias Verdes',
  'food_beterraba': 'Remolacha',
  'food_inhame': 'Name',
  'food_tomate': 'Tomate',
  'food_pepino': 'Pepino',
  'food_frango': 'Pollo',
  'food_carne_bovina': 'Carne de Res',
  'food_gema_ovo': 'Yema de Huevo',
  'food_peixe': 'Pescado',
  'food_feijao': 'Frijoles',
  'food_lentilha': 'Lentejas',
  'food_grao_de_bico': 'Garbanzo',
  'food_ovo_inteiro': 'Huevo Entero',
  'food_camarao': 'Camaron',
  'food_arroz': 'Arroz',
  'food_aveia': 'Avena',
  'food_macarrao': 'Pasta',
  'food_pao': 'Pan',
  'food_quinoa': 'Quinoa',
  'food_iogurte_natural': 'Yogur Natural',
  'food_queijo': 'Queso',
  'food_leite_vaca': 'Leche de Vaca',

  // Food preparations
  'prep_banana':
      'Corta en forma de palito o aplasta ligeramente. Puede dejar parte de la cascara para facilitar el agarre.',
  'prep_abacate':
      'Corta en rodajas o aplasta. Rico en grasas saludables para el desarrollo cerebral.',
  'prep_manga':
      'Corta en palitos u ofrece en el hueso para que el bebe sostenga y chupe.',
  'prep_pera':
      'Ofrece madura y suave, cortada en palitos. Puede cocinar ligeramente si esta muy dura.',
  'prep_mamao':
      'Ofrece madura en pedazos o aplastada. Excelente para el intestino.',
  'prep_melao': 'Corta en palitos finos. Muy madura queda mas suave.',
  'prep_melancia':
      'Retira las semillas y corta en palitos. Muy refrescante!',
  'prep_maca':
      'Cocina al vapor hasta que este suave o ralla. Cruda solo despues de 1 ano.',
  'prep_morango': 'Corta a la mitad o en cuartos. Lava muy bien.',
  'prep_kiwi': 'Pela y corta en rodajas o palitos.',
  'prep_laranja':
      'Ofrece en gajos sin la piel fina. Prefiere variedades menos acidas.',
  'prep_batata_doce':
      'Cocina al vapor y corta en palitos. Rica en vitamina A.',
  'prep_cenoura':
      'Cocina al vapor hasta que este muy suave. Corta en palitos gruesos.',
  'prep_abobora':
      'Cocina al vapor o hornea. Queda muy suave y dulce.',
  'prep_chuchu':
      'Cocina bien y corta en palitos. Sabor suave, excelente para empezar.',
  'prep_brocolis':
      'Cocina al vapor los floretes. El tallo sirve de "mango" para sostener.',
  'prep_couve_flor':
      'Cocina al vapor hasta que este suave. Ofrece los floretes.',
  'prep_abobrinha':
      'Cocina al vapor o a la plancha. Corta en palitos con cascara.',
  'prep_vagem':
      'Cocina al vapor hasta que este suave. Formato ideal para BLW.',
  'prep_beterraba':
      'Cocina hasta que este suave y corta en palitos. Mancha la ropa!',
  'prep_inhame':
      'Cocina bien y aplasta o corta en pedazos. Muy nutritivo.',
  'prep_tomate':
      'Retira las semillas y la piel. Corta en pedazos pequenos.',
  'prep_pepino': 'Pela, retira las semillas y corta en palitos.',
  'prep_frango':
      'Cocina bien y desmenuza o corta en tiras. El muslo es mas tierno.',
  'prep_carne_bovina':
      'Cocina hasta que este muy tierna. Cortes como cuadril son buenos. Desmenuza o corta en tiras.',
  'prep_gema_ovo':
      'Cocina bien (yema dura) y ofrece aplastada o en pedazos.',
  'prep_peixe':
      'Prefiere pescados de agua dulce o sardinas. Cocina bien y retira todas las espinas.',
  'prep_feijao':
      'Cocina bien y aplasta ligeramente. Puede ofrecer el caldo tambien.',
  'prep_lentilha': 'Cocina hasta que este muy suave. Rica en hierro.',
  'prep_grao_de_bico':
      'Cocina muy bien y aplasta (hummus) u ofrece entero supervisado.',
  'prep_ovo_inteiro':
      'Despues de introducir la yema sin reacciones, puede ofrecer el huevo entero bien cocido.',
  'prep_camarao':
      'Cocina bien y corta en pedazos pequenos. Introduce con precaucion.',
  'prep_arroz':
      'Cocina hasta que este muy suave. Puede aplastar ligeramente o hacer bolitas.',
  'prep_aveia':
      'Cocina con agua o leche materna. Haz papilla o panqueques.',
  'prep_macarrao':
      'Cocina hasta que este muy suave. Formatos como fusilli son faciles de agarrar.',
  'prep_pao':
      'Ofrece en tiras o ligeramente tostado. Prefiere panes sin azucar.',
  'prep_quinoa':
      'Cocina bien y mezcla con verduras. Muy nutritiva!',
  'prep_iogurte_natural':
      'Ofrece entero y sin azucar. Puede mezclar con frutas.',
  'prep_queijo':
      'Prefiere quesos pasteurizados como mozzarella o ricotta. Corta en palitos.',
  'prep_leite_vaca':
      'Solo despues de 1 ano como bebida. Antes puede usar en preparaciones.',

  // Allergen info
  'allergen_gema_ovo':
      'El huevo es uno de los principales alergenicos. Introduce en pequenas cantidades y observa durante 3 dias.',
  'allergen_peixe':
      'El pescado puede causar alergia. Comienza con pescados menos alergenicos como tilapia.',
  'allergen_ovo_inteiro': 'La clara del huevo es mas alergenica que la yema.',
  'allergen_camarao':
      'Los mariscos son altamente alergenicos. Introduce despues de 1 ano con supervision.',
  'allergen_aveia':
      'Puede contener trazas de gluten. Usa avena certificada sin gluten si es necesario.',
  'allergen_macarrao': 'Contiene gluten. Observa reacciones.',
  'allergen_pao': 'Contiene gluten y puede contener leche.',
  'allergen_iogurte_natural':
      'Derivado de la leche de vaca. Observa intolerancia a la lactosa o alergia a la proteina de la leche.',
  'allergen_queijo':
      'Derivado de la leche. Evita quesos madurados por el alto contenido de sodio.',
  'allergen_leite_vaca':
      'No debe sustituir la leche materna o formula antes de 1 ano.',

  // Gallery and photos
  'gallery': 'Galeria',
  'noPhotosYet': 'Sin fotos aun',
  'addPhotosHint': 'Agrega fotos de tu bebe\nprobando nuevos alimentos!',
  'unlimitedPhotos': 'Fotos ilimitadas',
  'upgradeToPremium': 'Actualizar a Premium',
  'shareGalleryText': 'Mira las fotos de la introduccion alimentaria de mi bebe!',
  'sharePhotoText': 'Mi bebe probando {food}!',
  'deletePhoto': 'Eliminar foto?',
  'deletePhotoConfirm': 'Deseas eliminar esta foto?',
  'addPhoto': 'Agregar foto',
  'takePhoto': 'Tomar foto',
  'chooseFromGallery': 'Elegir de la galeria',
  'photos': 'Fotos',
  'photoLimitReached': 'Limite de fotos alcanzado. Actualiza a Premium!',

  // Premium
  'youArePremium': 'Eres Premium!',
  'premiumActiveDescription': 'Disfruta de todas las funciones ilimitadas de la app.',
  'validUntil': 'Valido hasta',
  'goBack': 'Volver',
  'goPremium': 'Hazte Premium',
  'premiumDescription': 'Desbloquea todas las funciones y apoya el desarrollo de la app.',
  'monthlyPlan': 'Mensual',
  'monthlyPlanDescription': '\$4.99/mes',
  'yearlyPlan': 'Anual',
  'yearlyPlanDescription': '\$29.99/ano - Ahorra 50%',
  'lifetimePlan': 'Vitalicio',
  'lifetimePlanDescription': 'Paga una vez, usa para siempre',
  'restorePurchases': 'Restaurar compras',
  'purchaseDisclaimer': 'El pago sera procesado a traves de tu cuenta de la tienda de apps.',
  'featureUnlimitedPhotos': 'Fotos ilimitadas',
  'featureMoreRecipes': 'Mas recetas por alimento',
  'featureNoAds': 'Sin anuncios',
  'featurePrioritySupport': 'Soporte prioritario',
  'mostPopular': 'Mas Popular',
  'purchaseSuccess': 'Compra exitosa!',
  'timesOffered': '{count}x ofrecido',
  'neverOffered': 'Nunca ofrecido',

  // Celebration
  'firstTime': '¡Primera vez!',
  'addedToDiary': '¡fue agregado al diario del bebé!',
  'tapToContinue': 'Toca para continuar',

  // Home screen
  'quickActions': 'Acciones Rápidas',
  'addRecordSubtitle': 'Registra un nuevo alimento',
  'progress': 'Progreso',
  'foodsTried': 'Alimentos\nProbados',
  'totalRecords': 'Total de\nRegistros',
  'photosSaved': 'Fotos\nGuardadas',
  'recentActivity': 'Actividad Reciente',
  'foodsTriedOf': '{tried} de {total}',

  // Onboarding
  'onboardingTitle1': 'Bienvenido!',
  'onboardingDesc1': 'Acompana la introduccion alimentaria de tu bebe de forma simple y organizada.',
  'onboardingTitle2': 'Descubre Alimentos',
  'onboardingDesc2': 'Aprende que alimentos ofrecer en cada etapa y como prepararlos de forma segura.',
  'onboardingTitle3': 'Registra Todo',
  'onboardingDesc3': 'Anota la aceptacion, reacciones y toma fotos para seguir el progreso.',
  'onboardingTitle4': 'Aprende sobre BLW',
  'onboardingDesc4': 'Consejos y orientaciones para una introduccion alimentaria segura y placentera.',
  'getStarted': 'Comenzar',
  'skip': 'Saltar',
  'next': 'Siguiente',

  // Tips screen sections
  'sectionGettingStarted': 'Primeros Pasos',
  'sectionSafety': 'Seguridad',
  'sectionPracticalTips': 'Consejos Prácticos',
  'sectionNutrition': 'Nutrición',
};
