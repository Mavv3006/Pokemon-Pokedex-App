import 'package:flutter/cupertino.dart';
import 'package:pokemon_pokedex/models/pokemon/pokemon.dart';
import 'package:pokemon_pokedex/resources/api_provider.dart';

class AllPokemons extends ChangeNotifier {
  final ApiProvider apiProvider = ApiProvider();

  /// The page beeing displayed.
  int _currentPage = 0;

  /// The amount of pokemon shown per page.
  int _amountPerPage = 10;

  set setPokemonPerPage(int amountPerPage) {
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
  get currentPageNumber => _currentPage;

  /// Getter for the pokemon on the current page.
  get currentPage async => _getCurrentPage(_currentPage);

  /// Fetches the pokemon for the current page.
  Future<List<Pokemon>> _getCurrentPage(int page) async {
    int offset = page * _amountPerPage;
    return apiProvider.getMultiple(
      offset: offset,
      limit: _amountPerPage,
    );
  }
}