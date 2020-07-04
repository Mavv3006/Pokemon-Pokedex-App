import 'package:pokemon_pokedex/models/utility/named_api_resource.dart';

class Name {
  String name;
  NamedAPIResource language;

  Name.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    language = NamedAPIResource.fromJson(json['language']);
  }
}
