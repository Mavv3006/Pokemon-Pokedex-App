import 'package:pokemon_pokedex/models/utility/named_api_resource.dart';

class PokemonList {
  final int count;
  final String next;
  final String previous;
  final List<NamedAPIResource> results;

  PokemonList({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  static PokemonList fromJSON(Map<String, dynamic> json) {
    try {
      print(json['results'].toString());
      List<dynamic> resultsMap =
          json['results'] as List<dynamic>;
      List<NamedAPIResource> resultsList = [];
      resultsMap.forEach((element) {
        NamedAPIResource resource = NamedAPIResource.fromJSON(element);
        resultsList.add(resource);
      });

      return PokemonList(
        count: json['count'] as int,
        next: json['next'] as String,
        previous: json['previous'] as String,
        results: resultsList,
      );
    } catch (e) {
      print(e.toString());
      print('nothing found');
    }
    return PokemonList(results: []);
  }
}
