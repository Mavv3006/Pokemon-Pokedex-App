import 'package:to_string/to_string.dart';

part 'language.g.dart';

@ToString()
class Language {
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
}
