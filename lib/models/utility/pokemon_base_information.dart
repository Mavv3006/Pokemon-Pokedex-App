import 'package:pokemon_pokedex/models/language.dart';
import 'package:pokemon_pokedex/models/pokemon/pokemon_type.dart';

class PokemonBaseInformation {
  final String frontImage;
  final String backImage;
  final PokemonType type1;
  final PokemonType type2;
  final Language language;
  final int id;
  final String name;

  PokemonBaseInformation({
    this.name,
    this.id,
    this.type1,
    this.type2,
    this.language,
  })  : frontImage =
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png',
        backImage =
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/$id.png';
}
