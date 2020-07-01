import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:pokemon_pokedex/models/pokemon/pokemon/pokemon.dart';
import 'package:pokemon_pokedex/models/pokemon_list.dart';
import 'package:pokemon_pokedex/models/utility/named_api_resource.dart';

class ApiProvider {
  static const String BASE_URL = "https://pokeapi.co/api/v2/";
  Client client = Client();

  Future<List<Pokemon>> getAll() async {
    Response response = await _getAllPokemon();
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      PokemonList list = PokemonList.fromJSON(jsonResponse);
      return await extractPokemonFromList(list);
    }
    return [];
  }

  Future<List<Pokemon>> extractPokemonFromList(PokemonList list) async {
    List<Pokemon> pokemonList = [];
    list.results.forEach((element) async {
      Response pokemonResponse = await _getFromUrl(element.url);
      if (pokemonResponse.statusCode == 200) {
        Map<String, dynamic> pokemonJsonResponse =
            json.decode(pokemonResponse.body);
        pokemonList.add(Pokemon.fromJson(pokemonJsonResponse));
      }
    });
    return pokemonList;
  }

  Future<Pokemon> getSingle(int id) async {
    Response response = await _getSinglePokemon(id: id);

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      return Pokemon.fromJson(jsonResponse);
    }
    return Pokemon.fromJson({});
  }

  Future<List<Pokemon>> getMultiple({int offset, int limit}) async {
    Response response = await _getMultiplePokemon(
      offset: offset,
      limit: limit,
    );

    List<Pokemon> pokemonList = [];
    if (response.statusCode == 200) {
      List<NamedAPIResource> results = json.decode(response.body)['results'];

      results.forEach(
        (NamedAPIResource element) async {
          Response response = await _getFromUrl(element.url);
          if (response.statusCode == 200) {
            Map<String, dynamic> jsonResponse = json.decode(response.body);
            pokemonList.add(Pokemon.fromJson(jsonResponse));
          }
        },
      );
    }

    return pokemonList;
  }

  Future<Response> _getAllPokemon() async {
    final String url = BASE_URL + "pokemon";
    return await client.get(url);
  }

  Future<Response> _getFromUrl(String url) async {
    return await client.get(url);
  }

  Future<Response> _getMultiplePokemon({
    @required int offset,
    @required int limit,
  }) async {
    final String url = BASE_URL + 'pokemon?limit=$limit&offset=$offset';
    return await client.get(url);
  }

  Future<Response> _getSinglePokemon({@required int id}) async {
    final String url = BASE_URL + 'pokemon/$id';
    return await client.get(url);
  }
}
