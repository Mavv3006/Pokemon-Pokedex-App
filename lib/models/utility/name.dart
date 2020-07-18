import 'package:pokemon_pokedex/models/utility/named_api_resource.dart';

class Name {
  String name;
  NamedAPIResource language;

  Name({
    this.name,
    this.language,
  });

  Name.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String;
    language =
        NamedAPIResource.fromJson(json['language'] as Map<String, dynamic>);
  }
}
