import 'package:flutter/cupertino.dart';
import 'package:pokemon_pokedex/models/pokemon/pokemon.dart';
import 'package:pokemon_pokedex/resources/api/api_provider.dart';
import 'package:pokemon_pokedex/resources/settings/settings_provider.dart';

class PokemonProvider extends ChangeNotifier {
  final ApiProvider apiProvider = ApiProvider();

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
  Future<List<Pokemon>> get currentPage async => _getCurrentPage(_currentPage);

  /// Fetches the pokemon for the current page.
  Future<List<Pokemon>> _getCurrentPage(int page) async {
    int offset = page * settingsProvider.pokemonAmountPerPage;
    return apiProvider.getMultiple(
      offset: offset,
      limit: settingsProvider.pokemonAmountPerPage,
    );
  }
}
