import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:pokemon_pokedex/models/pokemon/pokemon.dart';
import 'package:pokemon_pokedex/models/pokemon/pokemon_type.dart';
import 'package:pokemon_pokedex/models/utility/additional_information.dart';

class ApiProvider {
  static const String BASE_URL = "https://pokeapi.co/api/v2/";
  Client client = Client();

  Future<Pokemon> getSingle(int id) async {
    Pokemon pokemon = await getSingleBasicInformation(id);
    AdditionalInformation additionalInformation =
        await getAdditionalInformation(pokemon);
    pokemon.name = additionalInformation.name;
    pokemon.types = additionalInformation.types;
    return pokemon;
  }

  Future<Pokemon> getSingleBasicInformation(int id) async {
    Response response = await client.get(BASE_URL + 'pokemon/$id');
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    return Pokemon.fromJson(jsonResponse);
  }

  Future<Pokemon> getSingleBasicInformationFromUrl(String url) async {
    Response response = await client.get(url);
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    return Pokemon.fromJson(jsonResponse);
  }

  Future<AdditionalInformation> getAdditionalInformation(
      Pokemon pokemon) async {
    AdditionalInformation additionalInformation = AdditionalInformation();
    additionalInformation.name = await getName(pokemon.id);
    for (PokemonType type in pokemon.types) {
      additionalInformation.types.add(await getType(type.url));
    }
    return additionalInformation;
  }

  Future<String> getName(int id) async {
    Response response = await client.get(BASE_URL + 'pokemon-species/$id');
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    List<dynamic> names = jsonResponse['names'];
    List<dynamic> name =
        names.where((element) => element['language']['name'] == 'de').toList();
    return name[0]['name'];
  }

  Future<PokemonType> getType(String url) async {
    Response response = await client.get(url);
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    return PokemonType.fromJson(json: jsonResponse, url: url);
  }

  Future<List<Pokemon>> getMultiple({
    @required int offset,
    @required int limit,
  }) async {
    List<Pokemon> list = await getMultipleBasicInformation(
      limit: limit,
      offset: offset,
    );
    for (Pokemon pokemon in list) {
      AdditionalInformation additionalInformation =
          await getAdditionalInformation(pokemon);
      pokemon.name = additionalInformation.name;
      pokemon.types = additionalInformation.types;
    }
    return list;
  }

  Future<List<Pokemon>> getMultipleBasicInformation({
    @required int limit,
    @required int offset,
  }) async {
    String url = BASE_URL + 'pokemon?limit=$limit&offset=$offset';
    Response response = await client.get(url);
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    List<Pokemon> pokemonList = [];
    for (var element in jsonResponse['results']) {
      Pokemon pokemon = await getSingleBasicInformationFromUrl(element['url']);
      pokemonList.add(pokemon);
    }
    return pokemonList;
  }
}
