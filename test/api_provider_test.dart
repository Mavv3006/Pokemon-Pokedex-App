import 'package:flutter_test/flutter_test.dart';
import 'package:http/testing.dart';
import 'package:pokemon_pokedex/models/pokemon/pokemon.dart';
import 'package:pokemon_pokedex/models/pokemon/pokemon_type.dart';
import 'package:pokemon_pokedex/models/utility/additional_information.dart';
import 'package:pokemon_pokedex/models/utility/pokemon_base_information.dart';
import 'package:pokemon_pokedex/resources/api/api_provider.dart';

import 'data/client_response.dart';

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

  group('database functions', () {
    test('getBaseInformation()', () async {
      final ApiProvider client = ApiProvider();
      client.client = MockClient(clientResponse);

      PokemonBaseInformation information = await client.getBaseInformation(1);
      expect(information.id, 1);
      expect(information.name, 'Bisasam');
      expect(information.language.id, 6);
      expect(information.type1, isNotNull);
      expect(information.type1.id, 12);
      expect(information.type2, isNotNull);
      expect(information.type2.id, 4);
    });

    test('getBaseInformationForAll()', () async {
      final ApiProvider client = ApiProvider();
      client.client = MockClient(clientResponse);

      List<PokemonBaseInformation> list =
          await client.getBaseInformationForAll();

      expect(list.length, 10);

      for (int i = 0; i < list.length; i++,) {
        expect(list[i].id, i + 1);
        expect(list[i].language.id, 6);
        expect(list[i].name, 'Bisasam');
        expect(list[i].language.id, 6);
        expect(list[i].type1, isNotNull);
        expect(list[i].type1.id, 12);
        expect(list[i].type2, isNotNull);
        expect(list[i].type2.id, 4);
      }
    });

    test('getPokemonCount()', () async {
      final ApiProvider client = ApiProvider();
      client.client = MockClient(clientResponse);

      expect(client.pokemonCount, 10);

      await client.getPokemonCount();

      expect(client.pokemonCount, 4);
    });

    test('getTypeById()', () async {
      final ApiProvider client = ApiProvider();
      client.client = MockClient(clientResponse);

      List<PokemonType> types = await client.getTypeByPokemonId(1);

      expect(types.length, 2);
      expect(types[0].id, 12);
      expect(types[1].id, 4);
      expect(types[0].name, isNull);
      expect(types[1].name, isNull);
    });
  });
}
