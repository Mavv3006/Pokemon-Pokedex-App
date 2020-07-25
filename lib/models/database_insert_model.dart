import 'package:pokemon_pokedex/models/language.dart';
import 'package:pokemon_pokedex/models/pokemon/name.dart';
import 'package:pokemon_pokedex/models/pokemon/pokemon_type.dart';
import 'package:pokemon_pokedex/models/utility/pokemon_base_information.dart';

class DatabaseInsertModel {
  List<Language> languageList;
  List<PokemonType> typeList;
  List<PokemonBaseInformation> pokemonList;
  List<Name> nameList;
}
