import 'dart:convert';

import 'package:http/http.dart';
import 'package:pokemon_pokedex/models/pokemon/pokemon.dart';
import 'package:pokemon_pokedex/models/pokemon/pokemon_type.dart';

class ApiProvider {
  static const String BASE_URL = "https://pokeapi.co/api/v2/";
  Client client = Client();

  Future<Pokemon> getSingle(int id) async {
    Pokemon pokemon = await getBasicInformation(id);
    pokemon.name = await getName(id);
    List<PokemonType> listOfTypes = List();
    for (PokemonType type in pokemon.types) {
      listOfTypes.add(await getType(type.url));
    }
    pokemon.types = listOfTypes;
    return pokemon;
  }

  Future<Pokemon> getBasicInformation(int id) async {
    // pokemon/id -> sprites, type.url, id
    Response response = await client.get(BASE_URL + 'pokemon/$id');
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    return Pokemon.fromJson(jsonResponse);
  }

  Future<String> getName(int id) async {
    // pokemon-species/id -> name, id
    Response response = await client.get(BASE_URL + 'pokemon-species/$id');
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    List<dynamic> names = jsonResponse['names'];
    List<dynamic> name =
        names.where((element) => element['language']['name'] == 'de').toList();
    return name[0]['name'];
  }

  Future<PokemonType> getType(String url) async {
    // type/{type-id} -> type.name, type.id
    Response response = await client.get(url);
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    return PokemonType.fromJson(json: jsonResponse, url: url);
  }

  @deprecated
  Future<List<Pokemon>> getMultiple({int offset, int limit}) async {
    return [];
  }
}
