import 'package:flutter/cupertino.dart';
import 'package:pokemon_pokedex/models/pokemon/pokemon.dart';
import 'package:pokemon_pokedex/resources/api_provider.dart';

class AllPokemons extends ChangeNotifier {
  final ApiProvider apiProvider = ApiProvider();
  List<Pokemon> _pokemonList = <Pokemon>[];

  AllPokemons() {
    _updateList();
  }

  List<Pokemon> get getAll {
    return _pokemonList;
  }

  _updateList() async {
    _pokemonList.add(await apiProvider.getSingle(1));
    notifyListeners();
    _pokemonList.add(await apiProvider.getSingle(2));
    notifyListeners();
    _pokemonList.add(await apiProvider.getSingle(384));
    notifyListeners();
  }
}
