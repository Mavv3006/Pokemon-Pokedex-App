import 'package:flutter/foundation.dart';
import 'package:pokemon_pokedex/models/language.dart';

class SettingsProvider extends ChangeNotifier {
  Language _language;
  int _pokemonAmountPerPage;

  SettingsProvider()
      : _language = Language.german(),
        _pokemonAmountPerPage = 10;

// Setter and Getter for the language ------------------------------------------
  Language get language => _language;

  set language(Language newValue) {
    _language = newValue;
    notifyListeners();
  }

// Setter and Getter for the amount of pokemon shown per page ------------------
  int get pokemonAmountPerPage => _pokemonAmountPerPage;

  set pokemonAmountPerPage(int newValue) {
    _pokemonAmountPerPage = newValue;
    notifyListeners();
  }
}
