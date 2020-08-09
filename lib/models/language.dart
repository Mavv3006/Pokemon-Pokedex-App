import 'package:pokemon_pokedex/models/utility/deserializable.dart';
import 'package:pokemon_pokedex/models/utility/model.dart';
import 'package:pokemon_pokedex/models/utility/serializable.dart';
import 'package:pokemon_pokedex/resources/database/storageDatabase/storage.dart';
import 'package:to_string/to_string.dart';

part 'language.g.dart';

@ToString()
class Language extends Model implements Serializable, Deserializable {
  final String shortCode;
  final int id;
  final String name;

  static List<int> _availableIds = [
    6,
    9,
  ];

  Language({
    this.id,
    this.name,
    this.shortCode,
  });

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

  static Language fromId(int id) {
    if (id == null) {
      return Language.german();
    } else if (_availableIds.contains(id)) {
      switch (id) {
        case 6:
          return Language.german();
        case 9:
          return Language.english();
        default:
          throw UnimplementedError();
      }
    } else
      throw UnimplementedError();
  }

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
