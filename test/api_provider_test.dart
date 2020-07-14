import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:pokemon_pokedex/models/pokemon/pokemon.dart';
import 'package:pokemon_pokedex/models/pokemon/pokemon_type.dart';
import 'package:pokemon_pokedex/models/utility/additional_information.dart';
import 'package:pokemon_pokedex/resources/api_provider.dart';

import 'data/data.dart';

main() {
  test('Get basic information about Pokemon', () async {
    final ApiProvider client = ApiProvider();
    client.client = MockClient(clientResponse);
    final Pokemon pokemon = await client.getSingleBasicInformation(1);

    expect(pokemon.id, 1);
    expect(pokemon.sprites.backShinyFemale, null);
    expect(pokemon.sprites.frontDefault, isNotNull);
    expect(pokemon.types[0].url, 'https://pokeapi.co/api/v2/type/12/');
  });

  test('Get basic information about Pokemon form a URL', () async {
    final ApiProvider client = ApiProvider();
    client.client = MockClient(clientResponse);

    final Pokemon pokemon = await client.getSingleBasicInformationFromUrl(
        client.baseUrl.toString() + 'pokemon/1');

    expect(pokemon.id, 1);
    expect(pokemon.sprites.backShinyFemale, null);
    expect(pokemon.sprites.frontDefault, isNotNull);
    expect(pokemon.types[0].url, 'https://pokeapi.co/api/v2/type/12/');
  });

  test('Get name of Pokemon', () async {
    final ApiProvider client = ApiProvider();
    client.client = MockClient(clientResponse);

    final String name = await client.getName(1);

    expect(name, 'Bisasam');
  });

  test('Get name of pokemon type', () async {
    final ApiProvider client = ApiProvider();
    client.client = MockClient(clientResponse);

    final PokemonType type =
        await client.getType('https://pokeapi.co/api/v2/type/1');

    expect(type.url, 'https://pokeapi.co/api/v2/type/1');
    expect(type.id, 1);
    expect(type.name, "Normal");
  });

  test('Get additional information about a pokemon', () async {
    final ApiProvider client = ApiProvider();
    client.client = MockClient(clientResponse);

    Pokemon pokemon = await client.getSingleBasicInformation(1);
    AdditionalInformation additionalInformation =
        await client.getAdditionalInformation(pokemon);

    expect(additionalInformation.name, 'Bisasam');
    expect(additionalInformation.types.length, 2);
    expect(additionalInformation.types[0].url,
        'https://pokeapi.co/api/v2/type/12/');
    expect(additionalInformation.types[1].url,
        'https://pokeapi.co/api/v2/type/4/');
    expect(additionalInformation.types[0].id, isNotNull);
  });

  test('ApiProvider.getSingle()', () async {
    final ApiProvider client = ApiProvider();
    client.client = MockClient(clientResponse);

    final Pokemon pokemon = await client.getSingle(1);
    expect(pokemon.id, 1);
    expect(pokemon.name, 'Bisasam');
    expect(pokemon.types.length, 2);
    expect(pokemon.types[0].url, 'https://pokeapi.co/api/v2/type/12/');
    expect(pokemon.types[1].url, 'https://pokeapi.co/api/v2/type/4/');
    expect(pokemon.types[0].id, isNotNull);
  });

  test('ApiProvider.getMultiple()', () async {
    final ApiProvider client = ApiProvider();
    client.client = MockClient(clientResponse);

    List<Pokemon> list = await client.getMultiple(limit: 1, offset: 1);

    expect(list.length, 2);
    expect(list[0].id, 1);
    expect(list[1].id, 1);
    expect(list[1].name, 'Bisasam');
    expect(list[1].types.length, 2);
    expect(list[1].types[0].url, 'https://pokeapi.co/api/v2/type/12/');
    expect(list[1].types[1].url, 'https://pokeapi.co/api/v2/type/4/');
    expect(list[1].types[0].id, isNotNull);
    print(list[0]);
  });

  test('Get multiple basic information', () async {
    final ApiProvider client = ApiProvider();
    client.client = MockClient(clientResponse);

    List<Pokemon> list =
        await client.getMultipleBasicInformation(limit: 1, offset: 1);

    expect(list.length, 2);
    expect(list[0].id, 1);
    expect(list[1].id, 1);
  });
}

Future<Response> clientResponse(Request request) async {
  final client = ApiProvider();
  if (request.url
      .toString()
      .startsWith(client.baseUrl.toString() + 'pokemon/')) {
    return Response(
      json.encode(pokemon_1),
      200,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
      },
    );
  } else if (request.url
      .toString()
      .startsWith(client.baseUrl.toString() + 'pokemon-species')) {
    return Response(
      json.encode(pokemon_species_1),
      200,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
      },
    );
  } else if (request.url
      .toString()
      .startsWith(client.baseUrl.toString() + 'type')) {
    return Response(
      json.encode(pokemon_type_1),
      200,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
      },
    );
  } else if (request.url
      .toString()
      .startsWith(client.baseUrl.toString() + 'pokemon?')) {
    return Response(
      json.encode(pokemon_list),
      200,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
      },
    );
  } else {
    return Response(null, 404);
  }
}
