import 'package:pokemon_pokedex/models/database/constants.dart';
import 'package:pokemon_pokedex/models/utility/deserializable.dart';
import 'package:pokemon_pokedex/models/utility/model.dart';
import 'package:pokemon_pokedex/models/utility/serializable.dart';
import 'package:to_string/to_string.dart';

part 'language.g.dart';

@ToString()
class Language extends Model implements Serializable, Deserializable {
  final String shortCode;
  final int id;
  final String name;

  Language.german()
      : shortCode = "de",
        name = 'Deutsch',
        id = 6;

  Language.english()
      : this.shortCode = "en",
        this.name = 'English',
        this.id = 9;

  @override
  String toString() {
    return _$LanguageToString(this);
  }

  /// Returns all available languages.
  static List<Language> getAll() {
    return [
      Language.english(),
      Language.german(),
    ];
  }

  Language({
    this.id,
    this.name,
    this.shortCode,
  });

  @override
  Language fromMap(Map<String, dynamic> map) {
    return Language(
      id: map[languagesId] as int,
      name: map[languagesName] as String,
      shortCode: map[languagesShortCode] as String,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      languagesId: id,
      languagesName: name,
      languagesShortCode: shortCode,
    };
  }
}
