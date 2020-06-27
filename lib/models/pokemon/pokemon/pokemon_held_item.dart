import 'package:pokemon_pokedex/models/utility/named_api_resource.dart';

class PokemonHeldItem {
  final NamedAPIResource item;
  final List<PokemonHeldItemVersion> versionDetails;

  PokemonHeldItem({
    this.item,
    this.versionDetails,
  });
}

class PokemonHeldItemVersion {
  final NamedAPIResource version;
  final int rarity;

  PokemonHeldItemVersion({
    this.version,
    this.rarity,
  });
}
