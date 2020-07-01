import 'package:pokemon_pokedex/models/color_information.dart';
import 'package:pokemon_pokedex/models/pokemon/pokemon/pokemon_type.dart';
import 'package:pokemon_pokedex/utils/constants.dart';

class Utils {
  static ColorInformation mapTypeToColor(PokemonType type) {
    try {
      switch (type.type.name) {
        case 'test':
          return PokemonTypeColors.fire;
        default:
          return PokemonTypeColors.electric;
      }
    } catch (_) {
      return PokemonTypeColors.unknown;
    }
  }
}
