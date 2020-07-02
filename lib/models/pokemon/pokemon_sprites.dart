import 'package:to_string/to_string.dart';
part 'pokemon_sprites.g.dart';

@ToString()
class PokemonSprites {
  String frontDefault;
  String frontShiny;
  String frontFemale;
  String frontShinyFemale;
  String backDefault;
  String backShiny;
  String backFemale;
  String backShinyFemale;

  PokemonSprites.fromJson(Map<String, dynamic> json) {
    backDefault = json['back_default'];
    backFemale = json['back_female'];
    backShinyFemale = json['back_shiny_female'];
    frontDefault = json['front_default'];
    frontFemale = json['front_female'];
    frontShiny = json['front_shiny'];
    frontShinyFemale = json['front_shiny_female'];
  }

  @override
  String toString() {
    return _$PokemonSpritesToString(this);
  }
}
