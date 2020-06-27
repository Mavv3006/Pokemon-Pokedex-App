import 'dart:convert';

import 'package:http/http.dart';
import 'package:pokemon_pokedex/models/pokemon/pokemon/pokemon.dart';
import 'package:pokemon_pokedex/models/pokemon_list.dart';
import 'package:pokemon_pokedex/utils/http_controller.dart';

class PokemonHttpClient {
  static Future<List<Pokemon>> getAll() async {
    Response response = await HttpController.getAllPokemon();
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      PokemonList list = PokemonList.fromJSON(jsonResponse);
      return await extractPokemonFromList(list);
    }
    return [];
  }

  static Future<List<Pokemon>> extractPokemonFromList(PokemonList list) async {
    List<Pokemon> pokemonList = [];
    list.results.forEach((element) async {
      Response pokemonResponse = await HttpController.getFromUrl(element.url);
      if (pokemonResponse.statusCode == 200) {
        Map<String, dynamic> pokemonJsonResponse =
            json.decode(pokemonResponse.body);
        pokemonList.add(Pokemon.fromJSON(pokemonJsonResponse));
      }
    });
    return pokemonList;
  }

  static Future<Pokemon> getWithId(int id) async {
    Response response = await HttpController.getPokemonWithId(id);

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      return Pokemon.fromJSON(jsonResponse);
    }
    return Pokemon();
  }
}
