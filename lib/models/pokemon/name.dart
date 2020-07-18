import 'package:pokemon_pokedex/models/utility/deserializable.dart';
import 'package:pokemon_pokedex/models/utility/model.dart';
import 'package:pokemon_pokedex/models/utility/serializable.dart';
import 'package:pokemon_pokedex/models/database/constants.dart';

class Name extends Model implements Serializable, Deserializable {
  final String name;
  final int pokemonId;
  final int languageId;

  Name(this.name, this.pokemonId, this.languageId);

  @override
  Name fromMap(Map<String, dynamic> map) {
    return Name(
      map[namesName] as String,
      map[namesPokemonId] as int,
      map[namesLanguageId] as int,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      namesName: name,
      namesPokemonId: pokemonId,
      namesLanguageId: languageId,
    };
  }
}
