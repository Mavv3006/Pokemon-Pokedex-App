import 'package:pokemon_pokedex/models/utility/model.dart';

abstract class Deserializable {
  Model fromMap(Map<String, dynamic> map);
}
