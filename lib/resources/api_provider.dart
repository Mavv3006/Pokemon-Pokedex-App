import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:pokemon_pokedex/models/pokemon/pokemon.dart';
import 'package:pokemon_pokedex/models/pokemon/pokemon_type.dart';
import 'package:pokemon_pokedex/models/utility/additional_information.dart';
import 'package:pokemon_pokedex/models/utility/pokemon_base_information.dart';

class ApiProvider {
  final Uri baseUrl = Uri.https('pokeapi.co', '/api/v2/');
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
    Uri uri = baseUrl.replace(path: baseUrl.path + 'pokemon/$id');
    Response response = await client.get(uri.toString());
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    return Pokemon.fromJson(jsonResponse);
  }

  Future<Pokemon> getSingleBasicInformationFromUrl(String url) async {
    Response response = await client.get(url);
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    return Pokemon.fromJson(jsonResponse);
  }

  /// Returns additional information about a specific information.
  /// These include the name and information about the type.
  Future<AdditionalInformation> getAdditionalInformation(
      Pokemon pokemon) async {
    AdditionalInformation additionalInformation = AdditionalInformation();
    additionalInformation.name = await getName(pokemon.id);
    for (PokemonType type in pokemon.types) {
      additionalInformation.types.add(await getType(type.url));
    }
    return additionalInformation;
  }

  /// Returns the name of the pokemon identified by the id
  Future<String> getName(int id) async {
    Uri uri = baseUrl.replace(path: baseUrl.path + 'pokemon-species/$id');
    Response response = await client.get(uri.toString());
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

  /// Returns all the information about multiple pokemon
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

  /// Returns basic Information about multiple pokemon
  Future<List<Pokemon>> getMultipleBasicInformation({
    @required int limit,
    @required int offset,
  }) async {
    Uri uri = baseUrl.replace(
      path: baseUrl.path + 'pokemon',
      queryParameters: {
        'limit': limit.toString(),
        'offset': offset.toString(),
      },
    );
    Response response = await client.get(uri);
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    List<Pokemon> pokemonList = [];
    for (var element in jsonResponse['results']) {
      Pokemon pokemon = await getSingleBasicInformationFromUrl(element['url']);
      pokemonList.add(pokemon);
    }
    return pokemonList;
  }

  Future<PokemonBaseInformation> getBaseInformation(int id) async {}

  Future<int> getPokemonCount() async {}

  Future<List<PokemonBaseInformation>> getBaseInformationForAll() async {
    final int count = await getPokemonCount();
    List<PokemonBaseInformation> list = [];
    for (int i = 1; i < count; i++) {
      list.add(await getBaseInformation(i));
    }
    return list;
  }
}
