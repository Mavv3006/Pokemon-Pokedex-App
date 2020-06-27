import 'package:pokemon_pokedex/models/utility/util.dart';

class Ability {
  final int id;
  final String name;
  final bool isMainSeries;
  final NamedAPIResource generation;
  final List<Name> names;
//  final List<VerboseEffect> effectEntries;
//  final List<AbilityEffectChange> effectChanges;
//  final List<AbilityFlavorText> flavorTextEntries;
//  final List<AbilityPokemon> pokemon;

  Ability({
    this.id,
    this.name,
    this.isMainSeries,
    this.generation,
    this.names,
//    this.effectEntries,
//    this.effectChanges,
//    this.flavorTextEntries,
//    this.pokemon,
  });
}
