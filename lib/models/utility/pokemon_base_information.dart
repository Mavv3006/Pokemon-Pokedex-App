import 'dart:developer';

import 'package:pokemon_pokedex/models/language.dart';
import 'package:pokemon_pokedex/models/pokemon/pokemon_type.dart';
import 'package:pokemon_pokedex/models/utility/deserializable.dart';
import 'package:pokemon_pokedex/models/utility/model.dart';
import 'package:pokemon_pokedex/models/utility/serializable.dart';
import 'package:pokemon_pokedex/resources/database/sqflite/constants.dart';
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
    // Type 1
    int typeId = map[pokemonsType1Id] as int;
    String typeName = map[typesName1] as String;
    PokemonType type1 = PokemonType(id: typeId, name: typeName);

    // Type 2
    PokemonType type2;
    if (map[pokemonsType2Id] != null) {
      typeId = map[pokemonsType2Id] as int;
      typeName = map[typesName2] as String;
      type2 = PokemonType(id: typeId, name: typeName);
    }

    // Pokemon ID
    int pokemonId = map[pokemonsId] as int;

    // Language
    Language language = Language.fromId(map[languageId] as int);

    // Name
    String pokemonName = map[namesName] as String;

    return PokemonBaseInformation(
      id: pokemonId,
      type1: type1,
      type2: type2,
      language: language,
      name: pokemonName,
    );
  }

  static PokemonBaseInformation fromDatabaseSearchResult(
      Map<String, dynamic> map) {
    return PokemonBaseInformation(
      id: map['names_pokemonId'] as int,
      name: map['names_name'] as String,
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
