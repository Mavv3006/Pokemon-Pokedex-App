import 'package:pokemon_pokedex/models/utility/named_api_resource.dart';
import 'package:pokemon_pokedex/models/utility/version_encounter_detail.dart';

class LocatoinAreaEncounter {
  final NamedAPIResource locationArea;
  final List<VersionEncounterDetail> versionDetails;

  LocatoinAreaEncounter({this.locationArea, this.versionDetails,});
}