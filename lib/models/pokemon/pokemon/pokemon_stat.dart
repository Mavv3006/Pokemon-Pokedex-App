import 'package:pokemon_pokedex/models/utility/named_api_resource.dart';

class PokemonStat {
  final NamedAPIResource stat;
  final int effort;
  final int baseStat;

  PokemonStat({
    this.stat,
    this.effort,
    this.baseStat,
  });
}
