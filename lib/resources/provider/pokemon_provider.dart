import 'package:flutter/cupertino.dart';
import 'package:pokemon_pokedex/models/utility/pokemon_base_information.dart';
import 'package:pokemon_pokedex/resources/api/api_provider.dart';
import 'package:pokemon_pokedex/resources/database/storageDatabase/storage.dart';
import 'package:pokemon_pokedex/resources/settings/settings_provider.dart';

class PokemonProvider extends ChangeNotifier {
  ApiProvider apiProvider;
  StorageProvider storageProvider;

  /// The page beeing displayed.
  int _currentPage = 0;

  /// An instance of the settings provider to get access to the language and
  /// the amount of pokemon per page value
  SettingsProvider settingsProvider;

  /// Goes to the next screen.
  void nextPage() {
    _currentPage++;
    notifyListeners();
  }

  /// Goes to the next screen.
  void previousPage() {
    if (_currentPage != 0) {
      _currentPage--;
    }
    notifyListeners();
  }

  /// Getter for the currentPageNumber.
  int get currentPageNumber => _currentPage;

  /// Getter for the pokemon on the current page.
  Future<List<PokemonBaseInformation>> get currentPage async =>
      _getCurrentPage(_currentPage);

  /// Fetches the pokemon for the current page.
  Future<List<PokemonBaseInformation>> _getCurrentPage(int page) async {
    int offset = page * settingsProvider.pokemonAmountPerPage;
    return storageProvider.getMultiple(
      offset,
      settingsProvider.pokemonAmountPerPage,
      settingsProvider.language,
    );
  }
}
