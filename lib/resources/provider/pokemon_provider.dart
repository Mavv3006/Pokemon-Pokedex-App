import 'package:flutter/cupertino.dart';
import 'package:pokemon_pokedex/models/language.dart';
import 'package:pokemon_pokedex/models/pokemon/pokemon.dart';
import 'package:pokemon_pokedex/resources/api/api_provider.dart';

class PokemonProvider extends ChangeNotifier {
  final ApiProvider apiProvider = ApiProvider();

  Language language;

  /// The page beeing displayed.
  int _currentPage = 0;

  /// The amount of pokemon shown per page.
  int _amountPerPage;

  set pokemonAmountPerPage(int amountPerPage) {
    _amountPerPage = amountPerPage;
    notifyListeners();
  }

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
    int offset = page * _amountPerPage;
    return apiProvider.getMultiple(
      offset: offset,
      limit: _amountPerPage,
    );
  }
}
