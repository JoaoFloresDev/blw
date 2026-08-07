import 'package:flutter/material.dart';
import '../models/food.dart';

/// Renders a food's icon. Foods without a matching Unicode emoji get a
/// generated emoji-style image from assets/images/foods/; the rest use
/// their emoji character.
class FoodIcon extends StatelessWidget {
  final Food food;
  final double size;

  const FoodIcon(this.food, {super.key, required this.size});

  static const Set<String> customIcons = {
    'acelga',
    'ameixa',
    'amendoa',
    'aspargo',
    'caqui',
    'castanha_caju',
    'castanha_para',
    'chia',
    'couve_bruxelas',
    'cuscuz',
    'damasco',
    'figo',
    'framboesa',
    'funcho',
    'gergelim',
    'goiaba',
    'graviola',
    'lichia',
    'macadamia',
    'mamao',
    'mandioca',
    'mandioquinha',
    'maracuja',
    'nabo',
    'nozes',
    'pistache',
    'polenta',
    'quiabo',
    'rabanete',
    'tofu',
  };

  @override
  Widget build(BuildContext context) {
    if (customIcons.contains(food.id)) {
      return Image.asset(
        'assets/images/foods/${food.id}.png',
        width: size * 1.2,
        height: size * 1.2,
        fit: BoxFit.contain,
      );
    }
    return Text(food.icon, style: TextStyle(fontSize: size));
  }
}
