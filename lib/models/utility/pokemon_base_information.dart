import 'package:pokemon_pokedex/models/language.dart';
import 'package:pokemon_pokedex/models/pokemon/pokemon_type.dart';
import 'package:to_string/to_string.dart';

part 'pokemon_base_information.g.dart';

@ToString()
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

  @override
  String toString() {
    return _$PokemonBaseInformationToString(this);
  }
}
