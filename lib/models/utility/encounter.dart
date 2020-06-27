import 'package:pokemon_pokedex/models/utility/named_api_resource.dart';

class Encounter {
  final int minLevel;
  final int maxLevel;
  final NamedAPIResource conditionValues;
  final int chance;
  final NamedAPIResource method;

  Encounter({
    this.minLevel,
    this.maxLevel,
    this.conditionValues,
    this.chance,
    this.method,
  });
}
