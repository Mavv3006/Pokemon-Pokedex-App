import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pokemon_pokedex/models/utility/named_api_resource.dart';
import 'package:to_string/to_string.dart';

part 'pokemon_type.g.dart';

@ToString()
class PokemonType {
  int id;
  String url;
  String name;

  PokemonType.fromUrl(this.url);

  PokemonType.fromJson({
    @required Map<String, dynamic> json,
    @required String url,
  }) {
    this.id = json['id'];
    this.url = url;
    var names = json['names'] as List;
    name = names
        .map((e) => Name.fromJson(e))
        .toList()
        .where((element) => element.language.name == 'de')
        .elementAt(0)
        .name;
  }
  @override
  String toString() {
    return _$PokemonTypeToString(this);
  }
}

class Name {
  String name;
  NamedAPIResource language;

  Name.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    language = NamedAPIResource.fromJson(json['language']);
  }
}
