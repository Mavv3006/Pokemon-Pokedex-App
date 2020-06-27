import 'package:pokemon_pokedex/models/pokemon/pokemon/pokemon_details.dart';
import 'package:pokemon_pokedex/models/utility/util.dart';

class Pokemon {
  final int id;
  final String name;
  final int baseExperience;
  final int height;
  final bool isDefault;
  final int order;
  final int weight;
  final List<PokemonAbility> abilities;
  final List<NamedAPIResource> forms;
  final List<VersionGameIndex> gameIndicies;
  final List<PokemonHeldItem> heldItems;
  final String locationAreaEncounters;
  final List<PokemonMove> moves;
  final PokemonSprites sprites;
  final NamedAPIResource species;
  final List<PokemonStat> stats;
  final List<PokemonType> types;

  Pokemon({
    this.id,
    this.name,
    this.baseExperience,
    this.height,
    this.isDefault,
    this.order,
    this.weight,
    this.abilities,
    this.forms,
    this.gameIndicies,
    this.heldItems,
    this.locationAreaEncounters,
    this.moves,
    this.sprites,
    this.species,
    this.stats,
    this.types,
  });

  static Pokemon fromJSON(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'],
      name: json['name'],
    );
  }

  @override
  String toString() {
    return 'Pokemon{id: $id, name: $name}';
  }
}
