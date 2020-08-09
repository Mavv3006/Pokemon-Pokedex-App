import 'package:flutter/foundation.dart';
import 'package:pokemon_pokedex/models/language.dart';
import 'package:pokemon_pokedex/resources/database/settingsDatabase/settings_storage.dart';

class SettingsProvider extends ChangeNotifier {
  Language _language;
  int _pokemonAmountPerPage;

  SettingsStorageProvider _settingsStorageProvider;
  set settingsStorageProvider(SettingsStorageProvider provider) =>
      _settingsStorageProvider = provider;

  SettingsProvider()
      : _language = Language.german(),
        _pokemonAmountPerPage = 10;

  /// Adds the default values in the database
  setDefaultValues() {
    _settingsStorageProvider.setActiveLanguage(_language);
    _settingsStorageProvider.setPokemonPerPageCount(_pokemonAmountPerPage);
  }

// Setter and Getter for the language ------------------------------------------
  Language get language => _language;

  get logActiveLanguageFromDatabase =>
      _settingsStorageProvider.getActiveLanguage();

  set language(Language newValue) {
    _language = newValue;
    _settingsStorageProvider.updateActiveLanguage(_language);
    notifyListeners();
  }

// Setter and Getter for the amount of pokemon shown per page ------------------
  int get pokemonAmountPerPage => _pokemonAmountPerPage;

  get logPokemonAmountPerPageFromDatabase =>
      _settingsStorageProvider.getPokemonPerPageCount();

  set pokemonAmountPerPage(int newValue) {
    _pokemonAmountPerPage = newValue;
    _settingsStorageProvider.updatePokemonPerPageCount(_pokemonAmountPerPage);
    notifyListeners();
  }
}
