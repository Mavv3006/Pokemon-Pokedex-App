import 'package:pokemon_pokedex/models/pokemon/pokemon_sprites.dart';
import 'package:pokemon_pokedex/models/pokemon/pokemon_type.dart';
import 'package:pokemon_pokedex/models/utility/additional_information.dart';
import 'package:to_string/to_string.dart';

part 'pokemon.g.dart';

@ToString()
class Pokemon {
  List<PokemonType> types;
  String name;
  int id;
  PokemonSprites sprites;

  Pokemon.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int;
    sprites = PokemonSprites.fromJson(json['sprites'] as Map<String, dynamic>);

    var typeList = json['types'] as List;
    types = typeList
        .map(
          (e) => PokemonType.fromUrl(e['type']['url'] as String),
        )
        .toList();
  }

  updateWithAdditionalInformation(AdditionalInformation additionalInformation) {
    types = additionalInformation.types;
    name = additionalInformation.name;
  }

  Pokemon({
    this.id,
    this.name,
    this.sprites,
    this.types,
  });

  @override
  String toString() {
    return _$PokemonToString(this);
  }
}
