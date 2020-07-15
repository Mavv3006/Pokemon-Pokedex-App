import 'package:flutter/material.dart';
import 'package:pokemon_pokedex/models/color_information.dart';
import 'package:pokemon_pokedex/models/pokemon/name.dart';
import 'package:pokemon_pokedex/utils/pokemon_type_colors.dart';
import 'package:to_string/to_string.dart';

part 'pokemon_type.g.dart';

@ToString()
class PokemonType {
  int id;
  String url;
  String name;
  ColorInformation color;

  PokemonType.fromUrl(this.url);

  PokemonType.fromJson({
    @required Map<String, dynamic> json,
    @required String url,
  }) {
    this.id = json['id'] as int;
    this.url = url;
    List<dynamic> names = json['names'] as List<dynamic>;
    name = names
        .cast<Map<String, dynamic>>()
        .map((Map<String, dynamic> e) => Name.fromJson(e))
        .toList()
        .where((element) => element.language.name == 'de')
        .elementAt(0)
        .name;
    this.color = PokemonTypeColors.getById(id);
  }
  @override
  String toString() {
    return _$PokemonTypeToString(this);
  }

  PokemonType({
    this.id,
    this.name,
    this.url,
  }) : color = PokemonTypeColors.getById(id);
}
