import 'package:pokemon_pokedex/models/utility/encounter.dart';
import 'package:pokemon_pokedex/models/utility/named_api_resource.dart';

class VersionEncounterDetail {
  final NamedAPIResource version;
  final int maxChance;
  final List<Encounter> encounterDetails;

  VersionEncounterDetail({
    this.version,
    this.maxChance,
    this.encounterDetails,
  });
}
