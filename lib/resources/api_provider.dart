import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:pokemon_pokedex/models/language.dart';
import 'package:pokemon_pokedex/models/pokemon/pokemon.dart';
import 'package:pokemon_pokedex/models/pokemon/pokemon_type.dart';
import 'package:pokemon_pokedex/models/utility/additional_information.dart';
import 'package:pokemon_pokedex/models/utility/pokemon_base_information.dart';
import 'package:pokemon_pokedex/utils/pokemon_utils.dart';

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
    Map<String, dynamic> jsonResponse =
        json.decode(response.body) as Map<String, dynamic>;
    return Pokemon.fromJson(jsonResponse);
  }

  Future<Pokemon> getSingleBasicInformationFromUrl(String url) async {
    Response response = await client.get(url);
    Map<String, dynamic> jsonResponse =
        json.decode(response.body) as Map<String, dynamic>;
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

  /// Returns the name of the pokemon identified by the id.
  Future<String> getName(int id) async {
    Uri uri = baseUrl.replace(path: baseUrl.path + 'pokemon-species/$id');
    Response response = await client.get(uri.toString());
    Map<String, dynamic> jsonResponse =
        json.decode(response.body) as Map<String, dynamic>;
    List<dynamic> names = jsonResponse['names'] as List<dynamic>;
    List<dynamic> name =
        names.where((element) => element['language']['name'] == 'de').toList();
    return name[0]['name'] as String;
  }

  Future<PokemonType> getType(String url) async {
    Response response = await client.get(url);
    Map<String, dynamic> jsonResponse =
        json.decode(response.body) as Map<String, dynamic>;
    return PokemonType.fromJson(json: jsonResponse, url: url);
  }

  /// Returns the Id and URL of the types for the pokemon identified by the Id.
  Future<List<PokemonType>> getTypeByPokemonId(int id) async {
    Uri uri = baseUrl.replace(path: baseUrl.path + 'pokemon/$id');
    Response response = await client.get(uri);
    Map<String, dynamic> jsonResponse =
        json.decode(response.body) as Map<String, dynamic>;
    var typeList = jsonResponse['types'] as List;
    List<PokemonType> list = [];
    for (var type in typeList) {
      String url = type['type']['url'] as String;
      list.add(PokemonType(
        url: url,
        id: PokemonUtils.getTypeIdFromUrl(url),
      ));
    }
    return list;
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
    Map<String, dynamic> jsonResponse =
        json.decode(response.body) as Map<String, dynamic>;
    List<Pokemon> pokemonList = [];
    for (var element in jsonResponse['results']) {
      Pokemon pokemon =
          await getSingleBasicInformationFromUrl(element['url'] as String);
      pokemonList.add(pokemon);
    }
    return pokemonList;
  }

  /// Returns the information for the pokemon with the Id needed to build
  /// the UI only from the database.
  Future<PokemonBaseInformation> getBaseInformation(int id) async {
    String _name = await getName(id);
    List<PokemonType> types = await getTypeByPokemonId(id);
    var type2 = types.length == 2 ? types[1] : null;
    return PokemonBaseInformation(
      id: id,
      name: _name,
      type1: types[0],
      type2: type2,
      language: Language.german(),
    );
  }

  /// Counts the amount of pokemon available
  Future<int> getPokemonCount() async {
    Uri _uri = baseUrl.replace(path: baseUrl.path + 'pokemon');
    Response _response = await client.get(_uri);
    Map<String, dynamic> jsonResponse =
        json.decode(_response.body) as Map<String, dynamic>;
    return jsonResponse['count'] as int;
  }

  Future<List<PokemonBaseInformation>> getBaseInformationForAll() async {
    // final int _count = await getPokemonCount();
    final int _count = 10;
    List<PokemonBaseInformation> list = [];
    for (int i = 1; i <= _count; i++) {
      list.add(await getBaseInformation(i));
    }
    return list;
  }

  /// Returns a List of all the available pokemon types.
  Future<List<PokemonType>> getAllTypes() async {
    Uri url = baseUrl.replace(path: baseUrl.path + 'type');
    Response _reponse = await client.get(url);
    Map<String, dynamic> jsonResponse =
        json.decode(_reponse.body) as Map<String, dynamic>;
    List<Map<String, dynamic>> results =
        jsonResponse['results'] as List<Map<String, dynamic>>;
    List<PokemonType> types = [];
    for (Map<String, dynamic> type in results) {
      PokemonType pokemonType = await getType(type['url'] as String);
      types.add(pokemonType);
    }
    return types;
  }
}
