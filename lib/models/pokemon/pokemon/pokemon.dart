import 'package:pokemon_pokedex/models/pokemon/abilities/ability.dart';
import 'package:pokemon_pokedex/models/pokemon/pokemon/pokemon_details.dart';
import 'package:pokemon_pokedex/models/utility/util.dart';

class Pokemon {
  int id;
  String name;
  int baseExperience;
  int height;
  bool isDefault;
  int order;
  int weight;
  List<PokemonAbility> abilities;
  List<NamedAPIResource> forms;
  List<VersionGameIndex> gameIndicies;
  List<PokemonHeldItem> heldItems;
  String locationAreaEncounters;
  List<PokemonMove> moves;
  PokemonSprites sprites;
  NamedAPIResource species;
  List<PokemonStat> stats;
  List<PokemonType> types;

  Pokemon.fromJson(Map<String, dynamic> json) {
    var abilitiesList = json['abilities'] as List;
    var formsList = json['forms'] as List;
    var gameIndiciesList = json['game_indices'] as List;
    var heldItemsList = json['held_items'] as List;
    var movesList = json['moves'] as List;
    var statsList = json['stats'] as List;
    var typesList = json['types'] as List;

    id = json['id'];
    name = json['name'];
    baseExperience = json['base_experience'];
    height = json['height'];
    isDefault = json['is_default'];
    order = json['order'];
    weight = json['weight'];
    abilities = abilitiesList.map((i) => Ability.fromJson(i)).toList();
    forms = formsList.map((i) => NamedAPIResource.fromJSON(i)).toList();
    gameIndicies = [];
    heldItems = [];
    locationAreaEncounters = json['location_area_encounters'];
    moves = [];
    sprites = PokemonSprites.fromJSON(json['sprites']);
    species = NamedAPIResource.fromJSON(json['species']);
    stats = [];
    types = [];
  }
}
