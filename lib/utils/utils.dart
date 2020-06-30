import 'package:pokemon_pokedex/models/color_information.dart';
import 'package:pokemon_pokedex/models/pokemon/pokemon/pokemon_type.dart';
import 'package:pokemon_pokedex/utils/constants.dart';

class Utils {
  static ColorInformation mapTypeToColor(PokemonType type) {
    try {
      switch (type.type.name) {
        case 'test':
          return PokemonTypeColors.poison;
        default:
          return PokemonTypeColors.yellow;
      }
    } catch (_) {
      return PokemonTypeColors.white;
    }
  }
}
