import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:pokemon_pokedex/models/pokemon/pokemon/pokemon.dart';
import 'dart:convert';

import 'pokemon_1.dart';

import 'package:pokemon_pokedex/resources/api_provider.dart';

main() {
  test('get single Pokemon', () async {
    final ApiProvider client = ApiProvider();
    client.client = MockClient((request) async {
      return Response(json.encode(pokemon_1), 200);
    });
    final Pokemon pokemon = await client.getSingle(1);

    print(
        "id: ${pokemon.id}, name: ${pokemon.name}, weight: ${pokemon.weight}");
    expect(pokemon.id, 1);
    expect(pokemon.name, 'bulbasaur');
    expect(pokemon.weight, 69);
  });
}
