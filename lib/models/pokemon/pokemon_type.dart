import 'package:flutter/material.dart';
import 'package:pokemon_pokedex/models/color_information.dart';
import 'package:pokemon_pokedex/models/database/constants.dart';
import 'package:pokemon_pokedex/models/utility/deserializable.dart';
import 'package:pokemon_pokedex/models/utility/model.dart';
import 'package:pokemon_pokedex/models/utility/name.dart';
import 'package:pokemon_pokedex/models/utility/serializable.dart';
import 'package:pokemon_pokedex/utils/pokemon_type_colors.dart';
import 'package:to_string/to_string.dart';

part 'pokemon_type.g.dart';

@ToString()
class PokemonType extends Model implements Serializable, Deserializable {
  int id;
  String url;
  String name;
  ColorInformation color;
  int languageId;

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

  PokemonType({
    this.id,
    this.name,
    this.url,
    this.languageId,
  }) : color = PokemonTypeColors.getById(id);

  @override
  String toString() {
    return _$PokemonTypeToString(this);
  }

  @override
  PokemonType fromMap(Map<String, dynamic> map) {
    return PokemonType(
      id: map[typesTypeId] as int,
      name: map[typesName] as String,
      languageId: map[typesLanguageId] as int,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      typesTypeId: id,
      typesName: name,
      typesLanguageId: languageId,
    };
  }
}
