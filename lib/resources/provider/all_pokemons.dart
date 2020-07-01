import 'package:flutter/cupertino.dart';
import 'package:pokemon_pokedex/models/pokemon/pokemon/pokemon.dart';
import 'package:pokemon_pokedex/models/pokemon/pokemon/pokemon_details.dart';
import 'package:pokemon_pokedex/models/utility/util.dart';
import 'package:pokemon_pokedex/resources/api_provider.dart';

class AllPokemons extends ChangeNotifier {
  final ApiProvider apiProvider = ApiProvider();
  List<Pokemon> _pokemonList = <Pokemon>[
    Pokemon(
      id: 1,
      name: "1st Pokemon",
      types: [
        PokemonType(
          slot: 1,
          type: NamedAPIResource(name: "jo jofjo sdkfjl"),
        ),
        PokemonType(
          slot: 2,
          type: NamedAPIResource(name: "jo jofjo sdkfjl"),
        ),
      ],
    ),
    Pokemon(
      id: 2,
      forms: [
        NamedAPIResource(
          name: 'front',
          url:
              'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/132.png',
        ),
        NamedAPIResource(
          name: 'back',
          url:
              'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/132.png',
        ),
      ],
      sprites: PokemonSprites(
        frontDefault:
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/132.png',
        backDefault:
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/132.png',
      ),
      name: "2nd Pokemon",
      types: [
        PokemonType(
          slot: 1,
          type: NamedAPIResource(name: "test"),
        ),
        PokemonType(
          slot: 2,
          type: NamedAPIResource(name: "jo"),
        )
      ],
    ),
    Pokemon(
      id: 3,
      name: "3rd Pokemon",
    ),
    Pokemon(
      id: 4,
      name: "4th Pokemon",
      forms: [
        NamedAPIResource(
          name: 'front',
          url:
              'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/5.png',
        ),
      ],
    ),
    Pokemon(
      id: 5,
      name: "5th Pokemon",
    ),
    Pokemon(
      id: 3,
      name: "3rd Pokemon",
    ),
    Pokemon(
      id: 4,
      name: "4th Pokemon",
    ),
    Pokemon(
      id: 5,
      name: "5th Pokemon",
    ),
    // Pokemon(id: 5, name: "5th Pokemon"),
  ];

  AllPokemons() {
    _updateList();
  }

  List<Pokemon> get getAll => _pokemonList;

  _updateList() async {
    _pokemonList = await apiProvider.getMultiple(
      limit: 10,
      offset: 0,
    );
    notifyListeners();
  }
}
