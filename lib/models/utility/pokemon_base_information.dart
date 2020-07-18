import 'package:pokemon_pokedex/models/database/constants.dart';
import 'package:pokemon_pokedex/models/language.dart';
import 'package:pokemon_pokedex/models/pokemon/pokemon_type.dart';
import 'package:pokemon_pokedex/models/utility/deserializable.dart';
import 'package:pokemon_pokedex/models/utility/model.dart';
import 'package:pokemon_pokedex/models/utility/serializable.dart';
import 'package:to_string/to_string.dart';

part 'pokemon_base_information.g.dart';

@ToString()
class PokemonBaseInformation extends Model
    implements Serializable, Deserializable {
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

  @override
  PokemonBaseInformation fromMap(Map<String, dynamic> map) {
    return PokemonBaseInformation(
      id: map[pokemonsId] as int,
      type1: PokemonType(id: map[pokemonsType1Id] as int),
      type2: PokemonType(id: map[pokemonsType2Id] as int),
      language: Language.fromId(map[languageId] as int),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      pokemonsId: id,
      pokemonsBack: backImage,
      pokemonsFront: frontImage,
      pokemonsType1Id: type1.id,
      pokemonsType2Id: type2 == null ? null : type2.id,
    };
  }
}
