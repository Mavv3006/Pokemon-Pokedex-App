import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:pokemon_pokedex/resources/api_provider.dart';

import 'pokemon_1.dart';
import 'pokemon_data.dart';
import 'pokemon_list_1.dart';
import 'pokemon_species_1.dart';
import 'pokemon_type_1.dart';

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
      .endsWith(client.baseUrl.toString() + 'pokemon')) {
    return Response(
      json.encode(pokemon_data),
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
