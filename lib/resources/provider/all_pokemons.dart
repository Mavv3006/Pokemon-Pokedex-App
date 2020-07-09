import 'package:flutter/cupertino.dart';
import 'package:pokemon_pokedex/models/pokemon/pokemon.dart';
import 'package:pokemon_pokedex/resources/api_provider.dart';

class AllPokemons extends ChangeNotifier {
  final ApiProvider apiProvider = ApiProvider();
  int _currentPage = 0;
  int _amountPerPage = 10;

  set pokemonPerPage(int amountPerPage) {
    _amountPerPage = amountPerPage;
    notifyListeners();
  }

  void nextPage() {
    // _currentPage++;
    // notifyListeners();
    print("next page");
  }

  void previousPage() {
    // if (_currentPage != 0) {
    //   _currentPage--;
    //   notifyListeners();
    print("previous page");
  }

  get currentPageNumber => _currentPage;

  get currentPage async => _getPokemon(_currentPage);

  Future<List<Pokemon>> _getPokemon(int page) async {
    int offset = page * _amountPerPage;
    return apiProvider.getMultiple(
      offset: offset,
      limit: _amountPerPage,
    );
  }
}
