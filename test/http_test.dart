import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:pokemon_pokedex/models/pokemon/pokemon.dart';
import 'package:pokemon_pokedex/models/pokemon/pokemon_type.dart';
import 'package:pokemon_pokedex/resources/api_provider.dart';

import 'pokemon_1.dart';
import 'pokemon_species_1.dart';
import 'pokemon_type_1.dart';

main() {
  test('Get basic information about Pokemon', () async {
    final ApiProvider client = ApiProvider();
    client.client = MockClient((request) async {
      return Response(json.encode(pokemon_1), 200);
    });
    final Pokemon pokemon = await client.getBasicInformation(1);

    expect(pokemon.id, 1);
    expect(pokemon.sprites.backShinyFemale, null);
    expect(pokemon.sprites.frontDefault, isNotNull);
    expect(pokemon.types[0].url, 'https://pokeapi.co/api/v2/type/12/');
  });

  test('Get name of Pokemon', () async {
    final ApiProvider client = ApiProvider();
    client.client = MockClient((request) async {
      return Response(
        json.encode(pokemon_species_1),
        200,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
        },
      );
    });

    final String name = await client.getName(1);

    expect(name, 'Bisasam');
  });

  test('Get name of pokemon type', () async {
    final ApiProvider client = ApiProvider();
    client.client = MockClient((request) async {
      return Response(
        json.encode(pokemon_type_1),
        200,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
        },
      );
    });

    final PokemonType type =
        await client.getType('https://pokeapi.co/api/v2/type/1');

    expect(type.url, 'https://pokeapi.co/api/v2/type/1');
    expect(type.id, 1);
    expect(type.name, "Normal");
  });

  test('ApiProvider.getSingle()', () async {
    final ApiProvider client = ApiProvider();
    client.client = MockClient((request) async {
      if (request.url
          .toString()
          .startsWith(ApiProvider.BASE_URL + 'pokemon/')) {
        return Response(
          json.encode(pokemon_1),
          200,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
          },
        );
      } else if (request.url
          .toString()
          .startsWith(ApiProvider.BASE_URL + 'pokemon-species/')) {
        return Response(
          json.encode(pokemon_species_1),
          200,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
          },
        );
      } else if (request.url
          .toString()
          .startsWith('https://pokeapi.co/api/v2/type/')) {
        return Response(
          json.encode(pokemon_type_1),
          200,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
          },
        );
      } else {
        return Response(null, 404);
      }
    });

    final Pokemon pokemon = await client.getSingle(1);
    expect(pokemon.id, 1);
    expect(pokemon.name, 'Bisasam');
    expect(pokemon.types.length, 2);
    expect(pokemon.types[0].url, 'https://pokeapi.co/api/v2/type/12/');
    expect(pokemon.types[1].url, 'https://pokeapi.co/api/v2/type/4/');
    expect(pokemon.types[0].id, isNotNull);
  });
}
