import 'package:flutter/foundation.dart';
import 'package:pokemon_pokedex/models/language.dart';

class SettingsProvider extends ChangeNotifier {
  Language _language;
  int _pokemonAmountPerPage;
  int _pokemonCount;
  bool _updatedPokemonCount;

  SettingsProvider()
      : _language = Language.german(),
        _pokemonAmountPerPage = 10,
        _pokemonCount = 100,
        _updatedPokemonCount = false;

// Setter and Getter for the language ------------------------------------------
  Language get language => _language;

  set language(Language newValue) {
    _language = newValue;
    notifyListeners();
  }

// Setter and Getter for pokemon count -----------------------------------------
  int get pokemonCount => _pokemonCount;

  set pokemonCount(int newValue) {
    _pokemonCount = newValue;
    notifyListeners();
  }

// Setter and Getter for updated pokemon count ---------------------------------
  bool get hasUpdatedPokemonCount => _updatedPokemonCount;

  set hasUpdatedPokemonCount(bool newValue) {
    _updatedPokemonCount = newValue;
    notifyListeners();
  }

// Setter and Getter for the amount of pokemon shown per page ------------------
  int get pokemonAmountPerPage => _pokemonAmountPerPage;

  set pokemonAmountPerPage(int newValue) {
    _pokemonAmountPerPage = newValue;
    notifyListeners();
  }
}
