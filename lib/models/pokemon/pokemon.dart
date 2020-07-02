import 'package:pokemon_pokedex/models/pokemon/pokemon_sprites.dart';
import 'package:pokemon_pokedex/models/pokemon/pokemon_type.dart';
import 'package:to_string/to_string.dart';

part 'pokemon.g.dart';

@ToString()
class Pokemon {
  List<PokemonType> types;
  String name;
  int id;
  PokemonSprites sprites;

  Pokemon.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sprites = PokemonSprites.fromJson(json['sprites']);

    var typeList = json['types'] as List;
    types = typeList
        .map(
          (e) => PokemonType.fromUrl(e['type']['url']),
        )
        .toList();
  }

  @override
  String toString() {
    return _$PokemonToString(this);
  }
}
