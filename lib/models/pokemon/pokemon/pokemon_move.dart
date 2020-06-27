import 'package:pokemon_pokedex/models/utility/named_api_resource.dart';

class PokemonMove {
  final NamedAPIResource move;
  final List<PokemonMoveVersion> versionGroupDetails;

  PokemonMove({
    this.move,
    this.versionGroupDetails,
  });
}

class PokemonMoveVersion {
  final NamedAPIResource moveLearnMethod;
  final NamedAPIResource versionGroup;
  final int levelLearnedAt;

  PokemonMoveVersion({
    this.moveLearnMethod,
    this.versionGroup,
    this.levelLearnedAt,
  });
}
