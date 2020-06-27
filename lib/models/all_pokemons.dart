import 'package:flutter/cupertino.dart';
import 'package:pokemon_pokedex/models/pokemon/pokemon/pokemon.dart';
import 'package:pokemon_pokedex/resources/pokemon_http_client.dart';

class AllPokemons extends ChangeNotifier{
  List<Pokemon> _pokemonList;

  AllPokemons() {
    _getAllPokemon();
  }

  List<Pokemon> get getAll => _pokemonList;

  _getAllPokemon() async {
    _pokemonList = await PokemonHttpClient.getAll();
    notifyListeners();
  }
}
