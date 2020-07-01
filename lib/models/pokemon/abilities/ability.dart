import 'package:pokemon_pokedex/models/utility/util.dart';

class Ability {
  NamedAPIResource ability;
  bool isHidden;
  int slot;

  Ability.fromJson(json) {
    ability = NamedAPIResource.fromJson(json['ability']);
    isHidden = json['is_hidden'];
    slot = json['slot'];
  }
}
