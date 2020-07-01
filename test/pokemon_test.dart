import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon_pokedex/models/pokemon/pokemon/pokemon.dart';
import 'package:pokemon_pokedex/models/pokemon_list.dart';

void main() {
  test('parse http json response', () {
    Map<String, dynamic> json = {
      "count": 964,
      "next": "https://pokeapi.co/api/v2/pokemon?offset=1&limit=1",
      "previous": null,
      "results": [
        {
          "name": "bulbasaur",
          "url": "https://pokeapi.co/api/v2/pokemon/1/",
        },
      ]
    };

    PokemonList list = PokemonList.fromJSON(json);

    expect(list.count, 964);
    expect(list.next, "https://pokeapi.co/api/v2/pokemon?offset=1&limit=1");
    expect(list.previous, null);
    expect(list.results.length, 1);
  });

  test('parse single pokemon', () {
    Map<String, dynamic> json = {
      "id": 1,
      'name': "test",
    };

    Pokemon pokemon = Pokemon.fromJSON(json);

    expect(pokemon.id, 1);
    expect(pokemon.name, 'test');
    expect(pokemon.abilities, null);
  });
}
