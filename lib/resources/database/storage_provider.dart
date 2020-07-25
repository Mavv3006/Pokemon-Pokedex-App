import 'package:pokemon_pokedex/models/language.dart';
import 'package:pokemon_pokedex/models/utility/pokemon_base_information.dart';

abstract class StorageProvider {
  Future<List<PokemonBaseInformation>> search(String query);
  Future<List<PokemonBaseInformation>> getAll(Language language);
  Future<void> update();
}
