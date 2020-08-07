import 'package:pokemon_pokedex/models/language.dart';
import 'package:pokemon_pokedex/models/pokemon/name.dart';
import 'package:pokemon_pokedex/models/pokemon/pokemon_type.dart';
import 'package:pokemon_pokedex/models/utility/pokemon_base_information.dart';
import 'package:to_string/to_string.dart';

part 'database_insert_model.g.dart';

@ToString()
class DatabaseInsertModel {
  List<Language> languageList;
  List<PokemonType> typeList;
  List<PokemonBaseInformation> pokemonList;
  List<Name> nameList;

  @override
  String toString() {
    return _$DatabaseInsertModelToString(this);
  }
}
