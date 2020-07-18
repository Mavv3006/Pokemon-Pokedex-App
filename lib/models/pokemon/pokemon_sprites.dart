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
    backDefault = json['back_default'] as String;
    backFemale = json['back_female'] as String;
    backShinyFemale = json['back_shiny_female'] as String;
    frontDefault = json['front_default'] as String;
    frontFemale = json['front_female'] as String;
    frontShiny = json['front_shiny'] as String;
    frontShinyFemale = json['front_shiny_female'] as String;
  }

  PokemonSprites({
    this.backDefault,
    this.backFemale,
    this.backShiny,
    this.backShinyFemale,
    this.frontDefault,
    this.frontFemale,
    this.frontShiny,
    this.frontShinyFemale,
  });

  @override
  String toString() {
    return _$PokemonSpritesToString(this);
  }
}
