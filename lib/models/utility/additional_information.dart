import 'package:pokemon_pokedex/models/pokemon/pokemon_type.dart';
import 'package:to_string/to_string.dart';

part 'additional_information.g.dart';

@ToString()
class AdditionalInformation {
  String name;
  List<PokemonType> types;

  AdditionalInformation() {
    types = [];
  }

  @override
  String toString() {
    return _$AdditionalInformationToString(this);
  }
}
