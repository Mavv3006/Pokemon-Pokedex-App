import 'package:pokemon_pokedex/models/utility/named_api_resource.dart';

class PokemonAbility {
  final bool isHidden;
  final int slot;
  final NamedAPIResource ability;

  PokemonAbility({
    this.isHidden,
    this.slot,
    this.ability,
  });
}
