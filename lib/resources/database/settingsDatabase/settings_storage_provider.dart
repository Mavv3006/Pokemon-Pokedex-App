import 'package:pokemon_pokedex/models/language.dart';

abstract class SettingsStorageProvider {
  Future<void> init();

  Future<Language> getActiveLanguage();
  Future<void> setActiveLanguage(Language language);
  Future<void> updateActiveLanguage(Language language);

  Future<int> getPokemonPerPageCount();
  Future<void> setPokemonPerPageCount(int count);
  Future<void> updatePokemonPerPageCount(int count);
}
