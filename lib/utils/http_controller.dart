import 'package:http/http.dart';

class HttpController {
  static const String BASE_URL = "https://pokeapi.co/api/v2/";

  static Future<Response> getAllPokemon() async {
    final String url = BASE_URL + "pokemon";
    return await get(url);
  }

  static Future<Response> getAllPokemonWithLimit(int limit) async {
    final String url = BASE_URL + "pokemon?limit=$limit";
    return await get(url);
  }

  static Future<Response> getPokemonWithId(int id) async {
    final String url = BASE_URL + "pokemon/" + id.toString();
    return await get(url);
  }

  static Future<Response> getFromUrl(String url) async {
    return await get(url);
  }
}
