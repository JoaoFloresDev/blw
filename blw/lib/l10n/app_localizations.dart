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
  String get babyAge => get('babyAge');
  String get notIntroducedYet => get('notIntroducedYet');
  String get tryNext => get('tryNext');
  String get searchFoods => get('searchFoods');
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

  // Paywall / Premium
  String get paywallTitle => get('paywallTitle');
  String get paywallSubtitle => get('paywallSubtitle');
  String get paywallFeatureDiary => get('paywallFeatureDiary');
  String get paywallFeature1 => get('paywallFeature1');
  String get paywallFeature2 => get('paywallFeature2');
  String get paywallFeature3 => get('paywallFeature3');
  String get paywallFeature4 => get('paywallFeature4');
  String get planWeekly => get('planWeekly');
  String get planYearly => get('planYearly');
  String get perWeek => get('perWeek');
  String get perYear => get('perYear');
  String get freeTrialBadge => get('freeTrialBadge');
  String get bestValueBadge => get('bestValueBadge');
  String get trialNote => get('trialNote');
  String get continueButton => get('continueButton');
  String get privacyPolicy => get('privacyPolicy');
  String get termsOfUse => get('termsOfUse');
  String get restoreSuccess => get('restoreSuccess');
  String get restoreNone => get('restoreNone');
  String get purchaseUnavailable => get('purchaseUnavailable');
  String get premiumFeatureTitle => get('premiumFeatureTitle');
  String get recipesPremiumSubtitle => get('recipesPremiumSubtitle');
  String weeklyEquivalent(String price) =>
      get('weeklyEquivalent').replaceAll('{price}', price);

  // Gallery add-photo prompt
  String get logMealPromptTitle => get('logMealPromptTitle');
  String get logMealPromptMessage => get('logMealPromptMessage');
  String get logMealPromptYes => get('logMealPromptYes');
  String get logMealPromptNo => get('logMealPromptNo');

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
  // ===== Foods expansion to 120 (2026-08) =====
  'food_nectarina': 'Nectarina',
  'prep_nectarina': 'Bem madura, em fatias grandes sem caroço. Se firme, cozinhe levemente até amaciar.',
  'food_figo': 'Figo',
  'prep_figo': 'Maduro e macio, cortado ao meio para o bebê raspar a polpa. Lave bem a casca.',
  'food_lichia': 'Lichia',
  'prep_lichia': 'Sem casca e sem caroço, cortada em quartos. Formato redondo e escorregadio é alto risco de engasgo.',
  'food_graviola': 'Graviola',
  'prep_graviola': 'Polpa madura sem sementes, amassada ou misturada em papas. Coe se houver fiapos duros.',
  'food_nabo': 'Nabo',
  'prep_nabo': 'Cozinhe até ficar bem macio, em palitos grossos ou purê. Sabor suave levemente adocicado quando cozido.',
  'food_rabanete': 'Rabanete',
  'prep_rabanete': 'Sempre cozido até amaciar — cru é duro e picante. Corte em fatias finas.',
  'food_acelga': 'Acelga',
  'prep_acelga': 'Refogue as folhas e pique bem fino. Os talos precisam cozinhar mais até ficarem macios.',
  'food_aspargo': 'Aspargo',
  'prep_aspargo': 'Cozinhe inteiro até ficar macio e ofereça o talo para segurar. Descarte a parte fibrosa da base.',
  'food_funcho': 'Erva-doce (Funcho)',
  'prep_funcho': 'Asse ou cozinhe o bulbo em fatias até amaciar. Sabor suave de anis que ajuda na digestão.',
  'food_ervilha_torta': 'Ervilha-torta',
  'prep_ervilha_torta': 'Cozinhe até ficar macia e corte em pedaços pequenos, amassando as ervilhas internas.',
  'food_ovo_codorna': 'Ovo de Codorna',
  'prep_ovo_codorna': 'Cozinhe bem e corte em quartos. Nunca inteiro — o formato redondo é risco de engasgo.',
  'allergen_ovo_codorna': 'Ovo é um dos principais alergênicos. Introduza em pequenas quantidades e observe por 3 dias.',
  'food_carne_moida': 'Carne Moída',
  'prep_carne_moida': 'Faça almôndegas macias e alongadas, bem cozidas, ou solta e úmida misturada a purês. Rica em ferro.',
  'food_castanha_para': 'Castanha-do-Pará',
  'prep_castanha_para': 'Só ralada fina ou como pasta diluída. Limite a 1 castanha por dia pelo selênio. Inteira, nunca antes dos 4 anos.',
  'allergen_castanha_para': 'Oleaginosas são alergênicas. Introduza uma de cada vez, em dias separados.',
  'food_pistache': 'Pistache',
  'prep_pistache': 'Como pasta fina diluída ou moído como farinha na comida. Inteiro só depois dos 4 anos.',
  'allergen_pistache': 'Oleaginosas são alergênicas. Introduza uma de cada vez, em dias separados.',
  'food_macadamia': 'Macadâmia',
  'prep_macadamia': 'Como pasta fina diluída ou ralada sobre a comida. Muito dura — inteira só depois dos 4 anos.',
  'allergen_macadamia': 'Oleaginosas são alergênicas. Introduza uma de cada vez, em dias separados.',
  'food_painco': 'Painço',
  'prep_painco': 'Cozinhe como mingau cremoso ou em bolinhos prensados. Sem glúten e fácil de digerir.',
  'food_trigo_sarraceno': 'Trigo Sarraceno',
  'prep_trigo_sarraceno': 'Apesar do nome, não tem glúten. Cozinhe bem em mingau ou use a farinha em panquecas.',
  'food_pao_sirio': 'Pão Sírio',
  'prep_pao_sirio': 'Em tiras, puro ou com pasta úmida (homus, tahine). Prefira sem sal adicionado. Contém glúten.',
  'allergen_pao_sirio': 'Trigo é alergênico. Introduza sozinho e observe por 2 horas.',
  'food_iogurte_grego': 'Iogurte Grego Natural',
  'prep_iogurte_grego': 'Natural e integral, sem açúcar. Mais espesso, ótimo para o bebê pegar com colher pré-carregada.',
  'allergen_iogurte_grego': 'Leite é alergênico. Introduza derivados um de cada vez e observe.',
  'food_queijo_fresco': 'Queijo Minas Frescal',
  'prep_queijo_fresco': 'Escolha versões com pouco sal e ofereça em palitos grossos. Derreta em preparações para bebês menores.',
  'allergen_queijo_fresco': 'Leite é alergênico. Introduza derivados um de cada vez e observe.',
  // ===== Foods expansion to 100 (2026-08) =====
  'food_uva': 'Uva',
  'prep_uva': 'Corte SEMPRE em quartos no sentido do comprimento. Uva inteira ou em metades é risco grave de engasgo até os 4 anos.',
  'food_pessego': 'Pêssego',
  'prep_pessego': 'Ofereça bem maduro em fatias grandes, sem caroço. Se estiver firme, cozinhe levemente até amaciar.',
  'food_ameixa': 'Ameixa',
  'prep_ameixa': 'Bem madura, em metades sem caroço. A casca escorregadia ajuda o bebê a segurar.',
  'food_abacaxi': 'Abacaxi',
  'prep_abacaxi': 'Corte em tiras finas e macias, sem o miolo duro. É ácido: comece com pouco e observe a pele ao redor da boca.',
  'food_coco': 'Coco',
  'prep_coco': 'Ofereça ralado fino misturado em papas e frutas, ou lascas bem finas. Pedaços duros são risco de engasgo.',
  'food_mirtilo': 'Mirtilo',
  'prep_mirtilo': 'Amasse cada mirtilo entre os dedos antes de oferecer. Inteiros só depois de 12 meses, sempre achatados.',
  'food_framboesa': 'Framboesa',
  'prep_framboesa': 'Macia e fácil de amassar, pode oferecer inteira. Lave bem e amasse levemente se o bebê estiver começando.',
  'food_amora': 'Amora',
  'prep_amora': 'Corte ao meio se forem grandes. Bem madura fica macia e segura para o bebê.',
  'food_cereja': 'Cereja',
  'prep_cereja': 'Remova o caroço e corte em quartos. Nunca ofereça inteira — mesmo formato de uva, mesmo risco.',
  'food_tangerina': 'Tangerina',
  'prep_tangerina': 'Remova sementes e a pele de cada gomo antes de oferecer. Gomos com película são difíceis de mastigar.',
  'food_goiaba': 'Goiaba',
  'prep_goiaba': 'Ofereça a polpa madura sem as sementes duras — raspe com colher. As sementes são pequenas e duras demais.',
  'food_caqui': 'Caqui',
  'prep_caqui': 'Só bem maduro e macio, em fatias ou amassado. Caqui firme é adstringente e difícil de mastigar.',
  'food_damasco': 'Damasco',
  'prep_damasco': 'Bem maduro, em metades sem caroço. Seco só depois de 12 meses, picado bem pequeno e hidratado.',
  'food_banana_da_terra': 'Banana-da-terra',
  'prep_banana_da_terra': 'Sempre cozida, assada ou grelhada até ficar macia, em palitos. Crua é dura e indigesta.',
  'food_maracuja': 'Maracujá',
  'prep_maracuja': 'Coe a polpa e misture em frutas amassadas ou iogurte. As sementes podem ser oferecidas aos poucos após 1 ano.',
  'food_batata': 'Batata',
  'prep_batata': 'Cozinhe bem e corte em palitos grossos, ou amasse. Adicione azeite para dar energia extra.',
  'food_espinafre': 'Espinafre',
  'prep_espinafre': 'Refogue e pique bem fino, misturado a purês ou bolinhos. Folhas soltas podem grudar no céu da boca.',
  'food_couve': 'Couve',
  'prep_couve': 'Retire o talo, refogue e pique bem fininho. Ótima misturada ao feijão ou purês.',
  'food_ervilha': 'Ervilha',
  'prep_ervilha': 'Amasse cada ervilha antes de oferecer, ou sirva como purê. Inteiras são pequenas demais e escorregadias.',
  'food_milho': 'Milho',
  'prep_milho': 'Na espiga cozida, para o bebê raspar com a gengiva. Grãos soltos só depois de 12 meses, amassados.',
  'food_pimentao': 'Pimentão',
  'prep_pimentao': 'Asse ou cozinhe até ficar bem macio, em tiras largas sem a pele. Cru só depois de 12 meses.',
  'food_berinjela': 'Berinjela',
  'prep_berinjela': 'Asse ou refogue em tiras grossas até ficar bem macia. A casca ajuda a manter o formato para segurar.',
  'food_quiabo': 'Quiabo',
  'prep_quiabo': 'Cozinhe inteiro e corte ao meio no comprimento. A textura pegajosa diminui assando em fogo alto.',
  'food_repolho': 'Repolho',
  'prep_repolho': 'Cozinhe até ficar bem macio e pique fino, misturado a outros pratos. Cru é difícil de mastigar.',
  'food_cebola': 'Cebola',
  'prep_cebola': 'Sempre bem cozida ou refogada em preparações. Dá sabor aos pratos sem precisar de sal.',
  'food_alho': 'Alho',
  'prep_alho': 'Use refogado como tempero desde o início. Ajuda o bebê a aceitar temperos naturais da família.',
  'food_cogumelo': 'Cogumelo',
  'prep_cogumelo': 'Cozinhe bem e corte em fatias finas ou pique. Champignon e shiitake são boas opções para começar.',
  'food_mandioca': 'Mandioca',
  'prep_mandioca': 'Cozinhe muito bem até desmanchar, retire as fibras do meio e ofereça em palitos macios ou amassada.',
  'food_couve_bruxelas': 'Couve-de-bruxelas',
  'prep_couve_bruxelas': 'Cozinhe até ficar bem macia e corte ao meio. Assada com azeite fica mais saborosa.',
  'food_mandioquinha': 'Mandioquinha',
  'prep_mandioquinha': 'Cozinhe e ofereça em palitos macios ou purê cremoso. Leve e de fácil digestão, ótima para começar.',
  'food_carne_suina': 'Carne Suína',
  'prep_carne_suina': 'Cozinhe até desfiar (lombo ou pernil) e ofereça em tiras grandes e macias. Rica em ferro e zinco.',
  'food_peru': 'Peru',
  'prep_peru': 'Ofereça desfiado ou em tiras macias da coxa, que é mais suculenta. Evite embutidos como peito de peru.',
  'food_cordeiro': 'Cordeiro',
  'prep_cordeiro': 'Cozinhe lentamente até ficar bem macio, em tiras ou desfiado. Uma das carnes mais ricas em ferro.',
  'food_figado': 'Fígado',
  'prep_figado': 'Extremamente rico em ferro. Ofereça em pequenas quantidades, 1x por semana, bem cozido e amassado.',
  'food_tilapia': 'Tilápia',
  'prep_tilapia': 'Peixe branco suave, ideal para começar. Cozinhe bem, desfie e confira espinha por espinha.',
  'allergen_tilapia': 'Peixe é alergênico comum. Introduza cedo e sozinho, observando por 2 horas.',
  'food_salmao': 'Salmão',
  'prep_salmao': 'Rico em ômega-3 para o cérebro. Asse ou cozinhe, desfie em lascas grandes e remova todas as espinhas.',
  'allergen_salmao': 'Peixe é alergênico comum. Introduza cedo e sozinho, observando por 2 horas.',
  'food_sardinha': 'Sardinha',
  'prep_sardinha': 'Fresca ou em lata (em água, sem sal), amassada com as espinhas macias removidas. Cheia de ômega-3 e cálcio.',
  'allergen_sardinha': 'Peixe é alergênico comum. Introduza cedo e sozinho, observando por 2 horas.',
  'food_atum': 'Atum',
  'prep_atum': 'Prefira atum claro em lata (em água, sem sal), no máximo 1x por semana por causa do mercúrio.',
  'allergen_atum': 'Peixe é alergênico comum. Introduza cedo e sozinho, observando por 2 horas.',
  'food_tofu': 'Tofu',
  'prep_tofu': 'Ofereça o firme em palitos grossos, puro ou levemente grelhado. Fonte de proteína e cálcio.',
  'allergen_tofu': 'Soja é alergênico. Introduza sozinha e observe por 2 horas.',
  'food_edamame': 'Edamame',
  'prep_edamame': 'Cozinhe bem e amasse cada grão antes de oferecer, ou sirva como pasta. Grãos inteiros são risco de engasgo.',
  'allergen_edamame': 'Soja é alergênico. Introduza sozinha e observe por 2 horas.',
  'food_amendoim': 'Amendoim',
  'prep_amendoim': 'Só como pasta 100% amendoim, em camada fina ou diluída em papa. Nunca inteiro ou em pedaços antes dos 4 anos.',
  'allergen_amendoim': 'Alergênico principal. Introduzir CEDO e com frequência reduz o risco de alergia. Comece com 1/4 de colher de chá.',
  'food_castanha_caju': 'Castanha de Caju',
  'prep_castanha_caju': 'Só como pasta fina diluída ou farinha polvilhada na comida. Castanha inteira é proibida antes dos 4 anos.',
  'allergen_castanha_caju': 'Oleaginosas são alergênicas. Introduza uma de cada vez, em dias separados.',
  'food_amendoa': 'Amêndoa',
  'prep_amendoa': 'Como pasta fina diluída ou farinha de amêndoas em receitas. Nunca inteira ou em lascas antes dos 4 anos.',
  'allergen_amendoa': 'Oleaginosas são alergênicas. Introduza uma de cada vez, em dias separados.',
  'food_nozes': 'Nozes',
  'prep_nozes': 'Como pasta fina ou trituradas até virar farinha, misturadas na comida. Inteiras só depois dos 4 anos.',
  'allergen_nozes': 'Oleaginosas são alergênicas. Introduza uma de cada vez, em dias separados.',
  'food_gergelim': 'Gergelim (Tahine)',
  'prep_gergelim': 'Ofereça como tahine em camada fina no pão ou diluído em papas e purês.',
  'allergen_gergelim': 'Gergelim é alergênico crescente. Introduza cedo, sozinho, e observe por 2 horas.',
  'food_arroz_integral': 'Arroz Integral',
  'prep_arroz_integral': 'Cozinhe até ficar bem macio, quase papa. Bolinhos de arroz prensado são fáceis de segurar.',
  'food_polenta': 'Polenta',
  'prep_polenta': 'Sirva cremosa na colher ou firme em palitos grelhados. Sem queijo salgado no preparo.',
  'food_cuscuz': 'Cuscuz',
  'prep_cuscuz': 'Bem hidratado e úmido, em bolinhos prensados ou na colher. Contém glúten (trigo).',
  'allergen_cuscuz': 'Trigo é alergênico. Introduza sozinho e observe por 2 horas.',
  'food_tapioca': 'Tapioca',
  'prep_tapioca': 'Faça fininha e macia, com recheio úmido (banana amassada, queijo). Seca demais pode embolar na boca.',
  'food_cevada': 'Cevada',
  'prep_cevada': 'Cozinhe até ficar bem macia, em sopas e risotos. Contém glúten.',
  'allergen_cevada': 'Cevada contém glúten. Introduza sozinha e observe por 2 horas.',
  'food_bulgur': 'Trigo Bulgur',
  'prep_bulgur': 'Cozinhe bem até ficar macio e úmido. Ótimo em bolinhos com legumes. Contém glúten.',
  'allergen_bulgur': 'Trigo é alergênico. Introduza sozinho e observe por 2 horas.',
  'food_centeio': 'Pão de Centeio',
  'prep_centeio': 'Ofereça em tiras levemente tostadas. Miolo fresco demais pode embolar — prefira tostado. Contém glúten.',
  'allergen_centeio': 'Centeio contém glúten. Introduza sozinho e observe por 2 horas.',
  'food_chia': 'Chia',
  'prep_chia': 'Sempre hidratada (deixe de molho 15 min) em papas, iogurte ou pudim. Seca pode irritar a garganta.',
  'food_linhaca': 'Linhaça',
  'prep_linhaca': 'Use moída, polvilhada em papas e frutas. A semente inteira não é digerida pelo bebê.',
  'food_pao_integral': 'Pão Integral',
  'prep_pao_integral': 'Tiras levemente tostadas são mais seguras que o miolo fresco. Escolha pães sem açúcar e com pouco sal.',
  'allergen_pao_integral': 'Trigo é alergênico. Introduza sozinho e observe por 2 horas.',
  'food_queijo_cottage': 'Queijo Cottage',
  'prep_queijo_cottage': 'Escolha versões com menos sódio e sirva na colher ou misturado a frutas amassadas.',
  'allergen_queijo_cottage': 'Leite é alergênico. Introduza derivados um de cada vez e observe.',
  'food_ricota': 'Ricota',
  'prep_ricota': 'Cremosa e pobre em sódio. Sirva na colher, em camada no pão ou misturada a legumes.',
  'allergen_ricota': 'Leite é alergênico. Introduza derivados um de cada vez e observe.',
  'food_kefir': 'Kefir',
  'prep_kefir': 'Natural, sem açúcar, na colher ou misturado a frutas. Probiótico natural para o intestino.',
  'allergen_kefir': 'Leite é alergênico. Introduza derivados um de cada vez e observe.',
  'food_manteiga': 'Manteiga',
  'prep_manteiga': 'Use sem sal, para cozinhar legumes ou em camada fina no pão. Fonte de gordura boa para energia.',
  'allergen_manteiga': 'Leite é alergênico. Introduza derivados um de cada vez e observe.',
  'food_cream_cheese': 'Cream Cheese',
  'prep_cream_cheese': 'Em camada fina no pão ou como base cremosa com legumes. Prefira versões sem sal adicionado.',
  'allergen_cream_cheese': 'Leite é alergênico. Introduza derivados um de cada vez e observe.',
  // App general
  'appTitle': 'Introducao Alimentar',
  'appSubtitle': 'Guia completo de BLW para seu bebe',

  // Navigation
  'home': 'Início',
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
  'babyAge': 'Idade do bebê',
  'notIntroducedYet': 'Ainda não introduzido',
  'tryNext': 'Experimente a seguir',
  'searchFoods': 'Buscar alimento...',
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

  // Paywall / Premium
  'paywallTitle': 'Desbloqueie o BLW Pro',
  'paywallSubtitle': 'Tudo que você precisa para acompanhar a introdução alimentar do seu bebê',
  'paywallFeatureDiary': 'Registre todas as refeições do bebê',
  'paywallFeature1': 'Exporte o diário completo em PDF',
  'paywallFeature2': 'Receitas exclusivas para cada fase',
  'paywallFeature3': 'Fotos ilimitadas em cada registro',
  'paywallFeature4': 'Sem anúncios, para sempre',
  'planWeekly': 'Semanal',
  'planYearly': 'Anual',
  'perWeek': '/semana',
  'perYear': '/ano',
  'freeTrialBadge': '3 dias grátis',
  'bestValueBadge': 'MELHOR VALOR',
  'trialNote': '3 dias grátis, depois o valor do plano. Renovação automática, cancele quando quiser.',
  'continueButton': 'Continuar',
  'privacyPolicy': 'Privacidade',
  'termsOfUse': 'Termos',
  'restoreSuccess': 'Compra restaurada com sucesso',
  'restoreNone': 'Nenhuma compra para restaurar',
  'purchaseUnavailable': 'Loja indisponível no momento. Tente novamente.',
  'premiumFeatureTitle': 'Recurso Premium',
  'recipesPremiumSubtitle': 'Receitas exclusivas para cada fase do bebê',
  'weeklyEquivalent': '{price}/sem',
  'logMealPromptTitle': 'Registrar refeição?',
  'logMealPromptMessage': 'Quer cadastrar o que o bebê está comendo?',
  'logMealPromptYes': 'Cadastrar',
  'logMealPromptNo': 'Só salvar na galeria',
};

// English translations
const Map<String, String> _enTranslations = {
  // ===== Foods expansion to 120 (2026-08) =====
  'food_nectarina': 'Nectarine',
  'prep_nectarina': 'Very ripe, in large pitted slices. If firm, steam briefly until soft.',
  'food_figo': 'Fig',
  'prep_figo': 'Ripe and soft, halved so baby can scoop the flesh. Wash the skin well.',
  'food_lichia': 'Lychee',
  'prep_lichia': 'Peeled and pitted, cut into quarters. Its round slippery shape is a high choking risk.',
  'food_graviola': 'Soursop',
  'prep_graviola': 'Ripe flesh with all seeds removed, mashed or mixed into porridge. Strain any tough fibers.',
  'food_nabo': 'Turnip',
  'prep_nabo': 'Cook until very soft, in thick sticks or mashed. Mild, slightly sweet when cooked.',
  'food_rabanete': 'Radish',
  'prep_rabanete': 'Always cooked until soft — raw is hard and spicy. Cut into thin slices.',
  'food_acelga': 'Chard',
  'prep_acelga': 'Sauté the leaves and chop finely. Stems need longer cooking to soften.',
  'food_aspargo': 'Asparagus',
  'prep_aspargo': 'Cook whole spears until soft and offer as a graspable stick. Trim the woody base.',
  'food_funcho': 'Fennel',
  'prep_funcho': 'Roast or steam the bulb in slices until soft. Mild anise flavor that aids digestion.',
  'food_ervilha_torta': 'Snap Peas',
  'prep_ervilha_torta': 'Cook until soft and cut into small pieces, flattening the inner peas.',
  'food_ovo_codorna': 'Quail Egg',
  'prep_ovo_codorna': 'Cook thoroughly and quarter. Never whole — the round shape is a choking hazard.',
  'allergen_ovo_codorna': 'Egg is a top allergen. Introduce in small amounts and watch for 3 days.',
  'food_carne_moida': 'Ground Beef',
  'prep_carne_moida': 'Shape into soft oblong meatballs, fully cooked, or serve loose and moist mixed into mashes. Iron-rich.',
  'food_castanha_para': 'Brazil Nut',
  'prep_castanha_para': 'Only finely grated or as thinned paste. Limit to 1 nut per day due to selenium. Never whole before age 4.',
  'allergen_castanha_para': 'Tree nuts are allergens. Introduce one at a time, on separate days.',
  'food_pistache': 'Pistachio',
  'prep_pistache': 'As thinned paste or ground into meal over food. Whole only after age 4.',
  'allergen_pistache': 'Tree nuts are allergens. Introduce one at a time, on separate days.',
  'food_macadamia': 'Macadamia',
  'prep_macadamia': 'As thinned paste or grated over food. Very hard — whole only after age 4.',
  'allergen_macadamia': 'Tree nuts are allergens. Introduce one at a time, on separate days.',
  'food_painco': 'Millet',
  'prep_painco': 'Cook as a creamy porridge or pressed patties. Gluten-free and easy to digest.',
  'food_trigo_sarraceno': 'Buckwheat',
  'prep_trigo_sarraceno': 'Despite the name, it is gluten-free. Cook well as porridge or use the flour in pancakes.',
  'food_pao_sirio': 'Pita Bread',
  'prep_pao_sirio': 'In strips, plain or with a moist spread (hummus, tahini). Choose low-salt versions. Contains gluten.',
  'allergen_pao_sirio': 'Wheat is an allergen. Introduce on its own and watch for 2 hours.',
  'food_iogurte_grego': 'Plain Greek Yogurt',
  'prep_iogurte_grego': 'Plain whole-milk, unsweetened. Thicker texture — great on a pre-loaded spoon.',
  'allergen_iogurte_grego': 'Milk is an allergen. Introduce dairy products one at a time and observe.',
  'food_queijo_fresco': 'Fresh White Cheese',
  'prep_queijo_fresco': 'Choose low-salt versions and serve in thick sticks. Melt into dishes for younger babies.',
  'allergen_queijo_fresco': 'Milk is an allergen. Introduce dairy products one at a time and observe.',
  // ===== Foods expansion to 100 (2026-08) =====
  'food_uva': 'Grape',
  'prep_uva': 'ALWAYS quarter lengthwise. Whole or halved grapes are a serious choking hazard until age 4.',
  'food_pessego': 'Peach',
  'prep_pessego': 'Offer ripe in large slices, pit removed. If firm, steam briefly until soft.',
  'food_ameixa': 'Plum',
  'prep_ameixa': 'Ripe, in halves with the pit removed. The skin gives baby extra grip.',
  'food_abacaxi': 'Pineapple',
  'prep_abacaxi': 'Cut into thin soft strips, core removed. It is acidic: start small and watch for skin irritation around the mouth.',
  'food_coco': 'Coconut',
  'prep_coco': 'Offer finely shredded mixed into porridge or fruit, or very thin shavings. Hard chunks are a choking hazard.',
  'food_mirtilo': 'Blueberry',
  'prep_mirtilo': 'Flatten each blueberry between your fingers before serving. Whole only after 12 months, always squished.',
  'food_framboesa': 'Raspberry',
  'prep_framboesa': 'Soft and easy to mash — can be served whole. Wash well and flatten slightly for beginners.',
  'food_amora': 'Blackberry',
  'prep_amora': 'Halve large berries. Ripe blackberries are soft and safe for baby.',
  'food_cereja': 'Cherry',
  'prep_cereja': 'Remove the pit and quarter. Never serve whole — same shape and risk as grapes.',
  'food_tangerina': 'Tangerine',
  'prep_tangerina': 'Remove seeds and the membrane of each segment before serving. Membranes are hard for babies to chew.',
  'food_goiaba': 'Guava',
  'prep_goiaba': 'Serve the ripe flesh without the hard seeds — scoop with a spoon. The seeds are too small and hard.',
  'food_caqui': 'Persimmon',
  'prep_caqui': 'Only when very ripe and soft, in slices or mashed. Firm persimmon is astringent and hard to chew.',
  'food_damasco': 'Apricot',
  'prep_damasco': 'Very ripe, halved and pitted. Dried apricot only after 12 months, finely chopped and rehydrated.',
  'food_banana_da_terra': 'Plantain',
  'prep_banana_da_terra': 'Always cooked — boiled, baked or grilled until soft, in sticks. Raw plantain is hard to digest.',
  'food_maracuja': 'Passion fruit',
  'prep_maracuja': 'Strain the pulp and mix into mashed fruit or yogurt. Seeds can be introduced gradually after age 1.',
  'food_batata': 'Potato',
  'prep_batata': 'Cook well and cut into thick sticks, or mash. Add olive oil for extra energy.',
  'food_espinafre': 'Spinach',
  'prep_espinafre': 'Sauté and chop finely, mixed into mashes or patties. Loose leaves can stick to the roof of the mouth.',
  'food_couve': 'Kale',
  'prep_couve': 'Remove the stem, sauté and chop very finely. Great mixed into beans or mashes.',
  'food_ervilha': 'Peas',
  'prep_ervilha': 'Flatten each pea before serving, or offer as a mash. Whole peas are small and slippery.',
  'food_milho': 'Corn',
  'prep_milho': 'On the cooked cob, for baby to gnaw. Loose kernels only after 12 months, flattened.',
  'food_pimentao': 'Bell pepper',
  'prep_pimentao': 'Roast or steam until very soft, in wide strips without the skin. Raw only after 12 months.',
  'food_berinjela': 'Eggplant',
  'prep_berinjela': 'Roast or sauté in thick strips until very soft. The skin helps the strip hold together for gripping.',
  'food_quiabo': 'Okra',
  'prep_quiabo': 'Cook whole and halve lengthwise. Roasting at high heat reduces the slimy texture.',
  'food_repolho': 'Cabbage',
  'prep_repolho': 'Cook until very soft and chop finely, mixed into dishes. Raw cabbage is hard to chew.',
  'food_cebola': 'Onion',
  'prep_cebola': 'Always well cooked or sautéed within dishes. Adds flavor without needing salt.',
  'food_alho': 'Garlic',
  'prep_alho': 'Use sautéed as seasoning from the start. Helps baby get used to the family\'s natural flavors.',
  'food_cogumelo': 'Mushroom',
  'prep_cogumelo': 'Cook well and slice thinly or chop. Button and shiitake mushrooms are good starters.',
  'food_mandioca': 'Cassava',
  'prep_mandioca': 'Cook very well until tender, remove the central fibers and serve in soft sticks or mashed.',
  'food_couve_bruxelas': 'Brussels sprouts',
  'prep_couve_bruxelas': 'Cook until very soft and halve. Roasting with olive oil improves the flavor.',
  'food_mandioquinha': 'Arracacha',
  'prep_mandioquinha': 'Cook and serve in soft sticks or a creamy mash. Light and easy to digest — great starter food.',
  'food_carne_suina': 'Pork',
  'prep_carne_suina': 'Slow-cook until shreddable (loin or shoulder) and serve in large soft strips. Rich in iron and zinc.',
  'food_peru': 'Turkey',
  'prep_peru': 'Serve shredded or in soft strips from the thigh, which is juicier. Avoid deli turkey products.',
  'food_cordeiro': 'Lamb',
  'prep_cordeiro': 'Slow-cook until very tender, in strips or shredded. One of the most iron-rich meats.',
  'food_figado': 'Liver',
  'prep_figado': 'Extremely iron-rich. Offer small amounts once a week, well cooked and mashed.',
  'food_tilapia': 'Tilapia',
  'prep_tilapia': 'Mild white fish, ideal to start. Cook well, flake and double-check for bones.',
  'allergen_tilapia': 'Fish is a common allergen. Introduce early and on its own, watching for 2 hours.',
  'food_salmao': 'Salmon',
  'prep_salmao': 'Rich in brain-building omega-3. Bake or poach, flake into large pieces and remove all bones.',
  'allergen_salmao': 'Fish is a common allergen. Introduce early and on its own, watching for 2 hours.',
  'food_sardinha': 'Sardine',
  'prep_sardinha': 'Fresh or canned (in water, no salt), mashed with soft bones removed. Packed with omega-3 and calcium.',
  'allergen_sardinha': 'Fish is a common allergen. Introduce early and on its own, watching for 2 hours.',
  'food_atum': 'Tuna',
  'prep_atum': 'Choose canned light tuna (in water, no salt), at most once a week due to mercury.',
  'allergen_atum': 'Fish is a common allergen. Introduce early and on its own, watching for 2 hours.',
  'food_tofu': 'Tofu',
  'prep_tofu': 'Serve firm tofu in thick sticks, plain or lightly pan-seared. Good source of protein and calcium.',
  'allergen_tofu': 'Soy is an allergen. Introduce on its own and watch for 2 hours.',
  'food_edamame': 'Edamame',
  'prep_edamame': 'Cook well and flatten each bean before serving, or offer as a mash. Whole beans are a choking hazard.',
  'allergen_edamame': 'Soy is an allergen. Introduce on its own and watch for 2 hours.',
  'food_amendoim': 'Peanut',
  'prep_amendoim': 'Only as 100% peanut butter, thinly spread or thinned into porridge. Never whole or in pieces before age 4.',
  'allergen_amendoim': 'Top allergen. EARLY and frequent introduction reduces allergy risk. Start with 1/4 teaspoon.',
  'food_castanha_caju': 'Cashew',
  'prep_castanha_caju': 'Only as thinned nut butter or ground meal sprinkled on food. Whole cashews are off-limits before age 4.',
  'allergen_castanha_caju': 'Tree nuts are allergens. Introduce one at a time, on separate days.',
  'food_amendoa': 'Almond',
  'prep_amendoa': 'As thinned almond butter or almond flour in recipes. Never whole or slivered before age 4.',
  'allergen_amendoa': 'Tree nuts are allergens. Introduce one at a time, on separate days.',
  'food_nozes': 'Walnut',
  'prep_nozes': 'As thin nut butter or ground into meal and mixed into food. Whole only after age 4.',
  'allergen_nozes': 'Tree nuts are allergens. Introduce one at a time, on separate days.',
  'food_gergelim': 'Sesame (Tahini)',
  'prep_gergelim': 'Serve as tahini thinly spread on bread or thinned into porridge and mashes.',
  'allergen_gergelim': 'Sesame is a growing allergen. Introduce early, on its own, and watch for 2 hours.',
  'food_arroz_integral': 'Brown Rice',
  'prep_arroz_integral': 'Cook until very soft, almost porridge-like. Pressed rice balls are easy to hold.',
  'food_polenta': 'Polenta',
  'prep_polenta': 'Serve creamy on a spoon or set firm and cut into grilled sticks. Skip salty cheese in the recipe.',
  'food_cuscuz': 'Couscous',
  'prep_cuscuz': 'Well hydrated and moist, as pressed balls or on a spoon. Contains gluten (wheat).',
  'allergen_cuscuz': 'Wheat is an allergen. Introduce on its own and watch for 2 hours.',
  'food_tapioca': 'Tapioca',
  'prep_tapioca': 'Make it thin and soft with a moist filling (mashed banana, cheese). Too dry it can clump in the mouth.',
  'food_cevada': 'Barley',
  'prep_cevada': 'Cook until very soft, in soups and stews. Contains gluten.',
  'allergen_cevada': 'Barley contains gluten. Introduce on its own and watch for 2 hours.',
  'food_bulgur': 'Bulgur Wheat',
  'prep_bulgur': 'Cook well until soft and moist. Great in veggie patties. Contains gluten.',
  'allergen_bulgur': 'Wheat is an allergen. Introduce on its own and watch for 2 hours.',
  'food_centeio': 'Rye Bread',
  'prep_centeio': 'Serve in lightly toasted strips. Very fresh crumb can ball up — toast it first. Contains gluten.',
  'allergen_centeio': 'Rye contains gluten. Introduce on its own and watch for 2 hours.',
  'food_chia': 'Chia Seeds',
  'prep_chia': 'Always hydrated (soak 15 min) in porridge, yogurt or pudding. Dry seeds can irritate the throat.',
  'food_linhaca': 'Flaxseed',
  'prep_linhaca': 'Use ground, sprinkled over porridge and fruit. Whole seeds pass through undigested.',
  'food_pao_integral': 'Whole Wheat Bread',
  'prep_pao_integral': 'Lightly toasted strips are safer than fresh crumb. Choose bread with no sugar and little salt.',
  'allergen_pao_integral': 'Wheat is an allergen. Introduce on its own and watch for 2 hours.',
  'food_queijo_cottage': 'Cottage Cheese',
  'prep_queijo_cottage': 'Choose lower-sodium versions and serve on a spoon or mixed with mashed fruit.',
  'allergen_queijo_cottage': 'Milk is an allergen. Introduce dairy products one at a time and observe.',
  'food_ricota': 'Ricotta',
  'prep_ricota': 'Creamy and low in sodium. Serve on a spoon, spread on bread or mixed into vegetables.',
  'allergen_ricota': 'Milk is an allergen. Introduce dairy products one at a time and observe.',
  'food_kefir': 'Kefir',
  'prep_kefir': 'Plain, unsweetened, on a spoon or mixed with fruit. A natural probiotic for the gut.',
  'allergen_kefir': 'Milk is an allergen. Introduce dairy products one at a time and observe.',
  'food_manteiga': 'Butter',
  'prep_manteiga': 'Use unsalted, for cooking vegetables or thinly spread on bread. Good fat for energy.',
  'allergen_manteiga': 'Milk is an allergen. Introduce dairy products one at a time and observe.',
  'food_cream_cheese': 'Cream Cheese',
  'prep_cream_cheese': 'Thinly spread on bread or as a creamy base with vegetables. Choose no-added-salt versions.',
  'allergen_cream_cheese': 'Milk is an allergen. Introduce dairy products one at a time and observe.',
  // App general
  'appTitle': 'Baby Food Introduction',
  'appSubtitle': 'Complete BLW guide for your baby',

  // Navigation
  'home': 'Home',
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
  'babyAge': "Baby's age",
  'notIntroducedYet': 'Not introduced yet',
  'tryNext': 'Try next',
  'searchFoods': 'Search foods...',
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

  // Paywall / Premium
  'paywallTitle': 'Unlock BLW Pro',
  'paywallSubtitle': 'Everything you need to track your baby\'s food journey',
  'paywallFeatureDiary': 'Log every one of your baby\'s meals',
  'paywallFeature1': 'Export the full diary as PDF',
  'paywallFeature2': 'Exclusive recipes for every stage',
  'paywallFeature3': 'Unlimited photos on every record',
  'paywallFeature4': 'No ads, forever',
  'planWeekly': 'Weekly',
  'planYearly': 'Yearly',
  'perWeek': '/week',
  'perYear': '/year',
  'freeTrialBadge': '3 days free',
  'bestValueBadge': 'BEST VALUE',
  'trialNote': '3 days free, then the plan price. Auto-renews, cancel anytime.',
  'continueButton': 'Continue',
  'privacyPolicy': 'Privacy',
  'termsOfUse': 'Terms',
  'restoreSuccess': 'Purchase restored successfully',
  'restoreNone': 'No purchases to restore',
  'purchaseUnavailable': 'Store unavailable right now. Please try again.',
  'premiumFeatureTitle': 'Premium Feature',
  'recipesPremiumSubtitle': 'Exclusive recipes for every baby stage',
  'weeklyEquivalent': '{price}/wk',
  'logMealPromptTitle': 'Log this meal?',
  'logMealPromptMessage': 'Want to log what your baby is eating?',
  'logMealPromptYes': 'Log it',
  'logMealPromptNo': 'Just save to gallery',
};

// Spanish translations
const Map<String, String> _esTranslations = {
  // ===== Foods expansion to 120 (2026-08) =====
  'food_nectarina': 'Nectarina',
  'prep_nectarina': 'Bien madura, en rodajas grandes sin hueso. Si está firme, cocínala al vapor hasta ablandar.',
  'food_figo': 'Higo',
  'prep_figo': 'Maduro y blando, cortado por la mitad para que el bebé coma la pulpa. Lava bien la piel.',
  'food_lichia': 'Lichi',
  'prep_lichia': 'Sin piel y sin hueso, cortada en cuartos. Su forma redonda y resbaladiza es de alto riesgo de atragantamiento.',
  'food_graviola': 'Guanábana',
  'prep_graviola': 'Pulpa madura sin semillas, aplastada o mezclada en papillas. Cuela las fibras duras.',
  'food_nabo': 'Nabo',
  'prep_nabo': 'Cocínalo hasta que esté muy blando, en bastones gruesos o puré. Suave y dulce al cocinarse.',
  'food_rabanete': 'Rábano',
  'prep_rabanete': 'Siempre cocido hasta ablandar: crudo es duro y picante. Corta en rodajas finas.',
  'food_acelga': 'Acelga',
  'prep_acelga': 'Saltea las hojas y pícalas finas. Los tallos necesitan más cocción para ablandarse.',
  'food_aspargo': 'Espárrago',
  'prep_aspargo': 'Cocina los espárragos enteros hasta que estén blandos y ofrécelos como bastón. Quita la base fibrosa.',
  'food_funcho': 'Hinojo',
  'prep_funcho': 'Asa o cocina el bulbo en rodajas hasta ablandar. Sabor anisado suave que ayuda a la digestión.',
  'food_ervilha_torta': 'Tirabeques',
  'prep_ervilha_torta': 'Cocínalos hasta que estén blandos y corta en trozos pequeños, aplastando los guisantes internos.',
  'food_ovo_codorna': 'Huevo de Codorniz',
  'prep_ovo_codorna': 'Cocínalo bien y corta en cuartos. Nunca entero: la forma redonda es riesgo de atragantamiento.',
  'allergen_ovo_codorna': 'El huevo es un alérgeno principal. Introdúcelo en pequeñas cantidades y observa 3 días.',
  'food_carne_moida': 'Carne Molida',
  'prep_carne_moida': 'Haz albóndigas blandas y alargadas, bien cocidas, o suelta y húmeda mezclada con purés. Rica en hierro.',
  'food_castanha_para': 'Castaña de Brasil',
  'prep_castanha_para': 'Solo rallada fina o como crema diluida. Limita a 1 al día por el selenio. Entera, nunca antes de los 4 años.',
  'allergen_castanha_para': 'Los frutos secos son alérgenos. Introduce uno a la vez, en días separados.',
  'food_pistache': 'Pistacho',
  'prep_pistache': 'Como crema diluida o molido como harina sobre la comida. Entero solo después de los 4 años.',
  'allergen_pistache': 'Los frutos secos son alérgenos. Introduce uno a la vez, en días separados.',
  'food_macadamia': 'Macadamia',
  'prep_macadamia': 'Como crema diluida o rallada sobre la comida. Muy dura: entera solo después de los 4 años.',
  'allergen_macadamia': 'Los frutos secos son alérgenos. Introduce uno a la vez, en días separados.',
  'food_painco': 'Mijo',
  'prep_painco': 'Cocínalo como papilla cremosa o en tortitas prensadas. Sin gluten y fácil de digerir.',
  'food_trigo_sarraceno': 'Trigo Sarraceno',
  'prep_trigo_sarraceno': 'A pesar del nombre, no tiene gluten. Cocínalo bien en papilla o usa la harina en tortitas.',
  'food_pao_sirio': 'Pan de Pita',
  'prep_pao_sirio': 'En tiras, solo o con crema húmeda (hummus, tahini). Prefiere versiones sin sal. Contiene gluten.',
  'allergen_pao_sirio': 'El trigo es un alérgeno. Introdúcelo solo y observa 2 horas.',
  'food_iogurte_grego': 'Yogur Griego Natural',
  'prep_iogurte_grego': 'Natural y entero, sin azúcar. Más espeso: ideal en cuchara precargada.',
  'allergen_iogurte_grego': 'La leche es un alérgeno. Introduce los lácteos de uno en uno y observa.',
  'food_queijo_fresco': 'Queso Fresco',
  'prep_queijo_fresco': 'Elige versiones bajas en sal y sirve en bastones gruesos. Fúndelo en platos para bebés más pequeños.',
  'allergen_queijo_fresco': 'La leche es un alérgeno. Introduce los lácteos de uno en uno y observa.',
  // ===== Foods expansion to 100 (2026-08) =====
  'food_uva': 'Uva',
  'prep_uva': 'Corta SIEMPRE en cuartos a lo largo. La uva entera o en mitades es un riesgo grave de atragantamiento hasta los 4 años.',
  'food_pessego': 'Melocotón',
  'prep_pessego': 'Ofrécelo bien maduro en rodajas grandes, sin hueso. Si está firme, cocínalo al vapor hasta ablandar.',
  'food_ameixa': 'Ciruela',
  'prep_ameixa': 'Bien madura, en mitades sin hueso. La piel ayuda al bebé a sujetarla.',
  'food_abacaxi': 'Piña',
  'prep_abacaxi': 'Corta en tiras finas y blandas, sin el centro duro. Es ácida: empieza con poco y observa la piel alrededor de la boca.',
  'food_coco': 'Coco',
  'prep_coco': 'Ofrécelo rallado fino mezclado con papillas o fruta, o en láminas muy finas. Los trozos duros son riesgo de atragantamiento.',
  'food_mirtilo': 'Arándano',
  'prep_mirtilo': 'Aplasta cada arándano entre los dedos antes de ofrecerlo. Enteros solo después de los 12 meses, siempre aplastados.',
  'food_framboesa': 'Frambuesa',
  'prep_framboesa': 'Blanda y fácil de aplastar: puede ofrecerse entera. Lávala bien y aplástala un poco al principio.',
  'food_amora': 'Mora',
  'prep_amora': 'Corta por la mitad las más grandes. Bien madura queda blanda y segura para el bebé.',
  'food_cereja': 'Cereza',
  'prep_cereja': 'Quita el hueso y corta en cuartos. Nunca la ofrezcas entera: mismo riesgo que la uva.',
  'food_tangerina': 'Mandarina',
  'prep_tangerina': 'Quita las semillas y la piel de cada gajo antes de ofrecerla. La membrana es difícil de masticar.',
  'food_goiaba': 'Guayaba',
  'prep_goiaba': 'Ofrece la pulpa madura sin las semillas duras: retírala con cuchara. Las semillas son demasiado duras.',
  'food_caqui': 'Caqui',
  'prep_caqui': 'Solo bien maduro y blando, en rodajas o aplastado. El caqui firme es astringente y difícil de masticar.',
  'food_damasco': 'Albaricoque',
  'prep_damasco': 'Bien maduro, en mitades sin hueso. Seco solo después de los 12 meses, muy picado e hidratado.',
  'food_banana_da_terra': 'Plátano macho',
  'prep_banana_da_terra': 'Siempre cocido, asado o a la plancha hasta que esté blando, en bastones. Crudo es duro e indigesto.',
  'food_maracuja': 'Maracuyá',
  'prep_maracuja': 'Cuela la pulpa y mézclala con fruta aplastada o yogur. Las semillas pueden introducirse poco a poco después del año.',
  'food_batata': 'Patata',
  'prep_batata': 'Cocínala bien y corta en bastones gruesos, o aplasta. Añade aceite de oliva para más energía.',
  'food_espinafre': 'Espinaca',
  'prep_espinafre': 'Saltéala y pícala fina, mezclada en purés o tortitas. Las hojas sueltas pueden pegarse al paladar.',
  'food_couve': 'Col rizada',
  'prep_couve': 'Quita el tallo, saltéala y pícala muy fina. Ideal mezclada con frijoles o purés.',
  'food_ervilha': 'Guisantes',
  'prep_ervilha': 'Aplasta cada guisante antes de ofrecerlo, o sirve en puré. Enteros son pequeños y resbaladizos.',
  'food_milho': 'Maíz',
  'prep_milho': 'En la mazorca cocida, para que el bebé roa. Granos sueltos solo después de los 12 meses, aplastados.',
  'food_pimentao': 'Pimiento',
  'prep_pimentao': 'Asado o al vapor hasta que esté muy blando, en tiras anchas sin piel. Crudo solo después de los 12 meses.',
  'food_berinjela': 'Berenjena',
  'prep_berinjela': 'Ásala o saltéala en tiras gruesas hasta que esté muy blanda. La piel ayuda a que no se deshaga al agarrarla.',
  'food_quiabo': 'Quimbombó',
  'prep_quiabo': 'Cocínalo entero y corta a lo largo. Asarlo a fuego alto reduce la textura babosa.',
  'food_repolho': 'Repollo',
  'prep_repolho': 'Cocínalo hasta que esté muy blando y pícalo fino, mezclado en platos. Crudo es difícil de masticar.',
  'food_cebola': 'Cebolla',
  'prep_cebola': 'Siempre bien cocida o salteada dentro de las preparaciones. Da sabor sin necesidad de sal.',
  'food_alho': 'Ajo',
  'prep_alho': 'Úsalo salteado como condimento desde el inicio. Ayuda al bebé a aceptar los sabores de la familia.',
  'food_cogumelo': 'Champiñón',
  'prep_cogumelo': 'Cocínalo bien y corta en láminas finas o pica. Champiñón y shiitake son buenas opciones para empezar.',
  'food_mandioca': 'Yuca',
  'prep_mandioca': 'Cocínala muy bien hasta que esté tierna, quita las fibras del centro y sirve en bastones blandos o aplastada.',
  'food_couve_bruxelas': 'Coles de Bruselas',
  'prep_couve_bruxelas': 'Cocínalas hasta que estén muy blandas y corta por la mitad. Asadas con aceite saben mejor.',
  'food_mandioquinha': 'Arracacha',
  'prep_mandioquinha': 'Cocínala y sirve en bastones blandos o puré cremoso. Ligera y fácil de digerir, ideal para empezar.',
  'food_carne_suina': 'Cerdo',
  'prep_carne_suina': 'Cocina hasta que se deshebre (lomo o paleta) y sirve en tiras grandes y blandas. Rica en hierro y zinc.',
  'food_peru': 'Pavo',
  'prep_peru': 'Sirve deshebrado o en tiras blandas del muslo, que es más jugoso. Evita el fiambre de pavo.',
  'food_cordeiro': 'Cordero',
  'prep_cordeiro': 'Cocínalo lento hasta que esté muy tierno, en tiras o deshebrado. Una de las carnes más ricas en hierro.',
  'food_figado': 'Hígado',
  'prep_figado': 'Riquísimo en hierro. Ofrécelo en pequeñas cantidades, 1 vez por semana, bien cocido y aplastado.',
  'food_tilapia': 'Tilapia',
  'prep_tilapia': 'Pescado blanco suave, ideal para empezar. Cocínalo bien, desmenuza y revisa bien las espinas.',
  'allergen_tilapia': 'El pescado es un alérgeno común. Introdúcelo pronto y solo, observando 2 horas.',
  'food_salmao': 'Salmón',
  'prep_salmao': 'Rico en omega-3 para el cerebro. Al horno o pochado, en lascas grandes y sin ninguna espina.',
  'allergen_salmao': 'El pescado es un alérgeno común. Introdúcelo pronto y solo, observando 2 horas.',
  'food_sardinha': 'Sardina',
  'prep_sardinha': 'Fresca o en lata (en agua, sin sal), aplastada y sin espinas. Llena de omega-3 y calcio.',
  'allergen_sardinha': 'El pescado es un alérgeno común. Introdúcelo pronto y solo, observando 2 horas.',
  'food_atum': 'Atún',
  'prep_atum': 'Prefiere atún claro en lata (en agua, sin sal), máximo 1 vez por semana por el mercurio.',
  'allergen_atum': 'El pescado es un alérgeno común. Introdúcelo pronto y solo, observando 2 horas.',
  'food_tofu': 'Tofu',
  'prep_tofu': 'Ofrece el firme en bastones gruesos, solo o ligeramente dorado. Fuente de proteína y calcio.',
  'allergen_tofu': 'La soja es un alérgeno. Introdúcela sola y observa 2 horas.',
  'food_edamame': 'Edamame',
  'prep_edamame': 'Cocínalo bien y aplasta cada grano antes de ofrecerlo, o sirve como pasta. Enteros son riesgo de atragantamiento.',
  'allergen_edamame': 'La soja es un alérgeno. Introdúcela sola y observa 2 horas.',
  'food_amendoim': 'Cacahuete',
  'prep_amendoim': 'Solo como crema 100% cacahuete, en capa fina o diluida en papilla. Nunca entero ni en trozos antes de los 4 años.',
  'allergen_amendoim': 'Alérgeno principal. Introducirlo PRONTO y con frecuencia reduce el riesgo de alergia. Empieza con 1/4 de cucharadita.',
  'food_castanha_caju': 'Anacardo',
  'prep_castanha_caju': 'Solo como crema diluida o harina espolvoreada. El anacardo entero está prohibido antes de los 4 años.',
  'allergen_castanha_caju': 'Los frutos secos son alérgenos. Introduce uno a la vez, en días separados.',
  'food_amendoa': 'Almendra',
  'prep_amendoa': 'Como crema diluida o harina de almendra en recetas. Nunca entera ni en láminas antes de los 4 años.',
  'allergen_amendoa': 'Los frutos secos son alérgenos. Introduce uno a la vez, en días separados.',
  'food_nozes': 'Nuez',
  'prep_nozes': 'Como crema fina o molidas como harina, mezcladas en la comida. Enteras solo después de los 4 años.',
  'allergen_nozes': 'Los frutos secos son alérgenos. Introduce uno a la vez, en días separados.',
  'food_gergelim': 'Sésamo (Tahini)',
  'prep_gergelim': 'Ofrécelo como tahini en capa fina sobre pan o diluido en papillas y purés.',
  'allergen_gergelim': 'El sésamo es un alérgeno en aumento. Introdúcelo pronto, solo, y observa 2 horas.',
  'food_arroz_integral': 'Arroz Integral',
  'prep_arroz_integral': 'Cocínalo hasta que esté muy blando. Las bolitas de arroz prensado son fáciles de agarrar.',
  'food_polenta': 'Polenta',
  'prep_polenta': 'Sírvela cremosa en cuchara o firme en bastones a la plancha. Sin queso salado en la preparación.',
  'food_cuscuz': 'Cuscús',
  'prep_cuscuz': 'Bien hidratado y húmedo, en bolitas prensadas o en cuchara. Contiene gluten (trigo).',
  'allergen_cuscuz': 'El trigo es un alérgeno. Introdúcelo solo y observa 2 horas.',
  'food_tapioca': 'Tapioca',
  'prep_tapioca': 'Hazla fina y blanda, con relleno húmedo (plátano aplastado, queso). Muy seca puede apelmazarse en la boca.',
  'food_cevada': 'Cebada',
  'prep_cevada': 'Cocínala hasta que esté muy blanda, en sopas y guisos. Contiene gluten.',
  'allergen_cevada': 'La cebada contiene gluten. Introdúcela sola y observa 2 horas.',
  'food_bulgur': 'Bulgur',
  'prep_bulgur': 'Cocínalo bien hasta que esté blando y húmedo. Ideal en tortitas de verduras. Contiene gluten.',
  'allergen_bulgur': 'El trigo es un alérgeno. Introdúcelo solo y observa 2 horas.',
  'food_centeio': 'Pan de Centeno',
  'prep_centeio': 'Ofrécelo en tiras ligeramente tostadas. La miga muy fresca puede apelmazarse. Contiene gluten.',
  'allergen_centeio': 'El centeno contiene gluten. Introdúcelo solo y observa 2 horas.',
  'food_chia': 'Chía',
  'prep_chia': 'Siempre hidratada (remoja 15 min) en papillas, yogur o pudín. Seca puede irritar la garganta.',
  'food_linhaca': 'Linaza',
  'prep_linhaca': 'Úsala molida, espolvoreada en papillas y fruta. La semilla entera no se digiere.',
  'food_pao_integral': 'Pan Integral',
  'prep_pao_integral': 'Tiras ligeramente tostadas son más seguras que la miga fresca. Elige pan sin azúcar y con poca sal.',
  'allergen_pao_integral': 'El trigo es un alérgeno. Introdúcelo solo y observa 2 horas.',
  'food_queijo_cottage': 'Queso Cottage',
  'prep_queijo_cottage': 'Elige versiones bajas en sodio y sirve en cuchara o mezclado con fruta aplastada.',
  'allergen_queijo_cottage': 'La leche es un alérgeno. Introduce los lácteos de uno en uno y observa.',
  'food_ricota': 'Ricotta',
  'prep_ricota': 'Cremosa y baja en sodio. Sirve en cuchara, untada en pan o mezclada con verduras.',
  'allergen_ricota': 'La leche es un alérgeno. Introduce los lácteos de uno en uno y observa.',
  'food_kefir': 'Kéfir',
  'prep_kefir': 'Natural, sin azúcar, en cuchara o mezclado con fruta. Probiótico natural para el intestino.',
  'allergen_kefir': 'La leche es un alérgeno. Introduce los lácteos de uno en uno y observa.',
  'food_manteiga': 'Mantequilla',
  'prep_manteiga': 'Úsala sin sal, para cocinar verduras o en capa fina sobre pan. Grasa buena para energía.',
  'allergen_manteiga': 'La leche es un alérgeno. Introduce los lácteos de uno en uno y observa.',
  'food_cream_cheese': 'Queso Crema',
  'prep_cream_cheese': 'En capa fina sobre pan o como base cremosa con verduras. Prefiere versiones sin sal añadida.',
  'allergen_cream_cheese': 'La leche es un alérgeno. Introduce los lácteos de uno en uno y observa.',
  // App general
  'appTitle': 'Introduccion Alimentaria',
  'appSubtitle': 'Guia completa de BLW para tu bebe',

  // Navigation
  'home': 'Inicio',
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
  'babyAge': 'Edad del bebé',
  'notIntroducedYet': 'Aún no introducido',
  'tryNext': 'Prueba a continuación',
  'searchFoods': 'Buscar alimento...',
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

  // Paywall / Premium
  'paywallTitle': 'Desbloquea BLW Pro',
  'paywallSubtitle': 'Todo lo que necesitas para seguir la alimentación de tu bebé',
  'paywallFeatureDiary': 'Registra todas las comidas del bebé',
  'paywallFeature1': 'Exporta el diario completo en PDF',
  'paywallFeature2': 'Recetas exclusivas para cada etapa',
  'paywallFeature3': 'Fotos ilimitadas en cada registro',
  'paywallFeature4': 'Sin anuncios, para siempre',
  'planWeekly': 'Semanal',
  'planYearly': 'Anual',
  'perWeek': '/semana',
  'perYear': '/año',
  'freeTrialBadge': '3 días gratis',
  'bestValueBadge': 'MEJOR VALOR',
  'trialNote': '3 días gratis, luego el precio del plan. Se renueva automáticamente, cancela cuando quieras.',
  'continueButton': 'Continuar',
  'privacyPolicy': 'Privacidad',
  'termsOfUse': 'Términos',
  'restoreSuccess': 'Compra restaurada con éxito',
  'restoreNone': 'No hay compras para restaurar',
  'purchaseUnavailable': 'Tienda no disponible. Inténtalo de nuevo.',
  'premiumFeatureTitle': 'Función Premium',
  'recipesPremiumSubtitle': 'Recetas exclusivas para cada etapa del bebé',
  'weeklyEquivalent': '{price}/sem',
  'logMealPromptTitle': '¿Registrar comida?',
  'logMealPromptMessage': '¿Quieres registrar lo que está comiendo tu bebé?',
  'logMealPromptYes': 'Registrar',
  'logMealPromptNo': 'Solo guardar en galería',
};
