import 'package:flutter/material.dart';
import 'package:pokemon_pokedex/models/utility/pokemon_base_information.dart';
import 'package:pokemon_pokedex/screens/pokedexScreen/widgets/pokemon_images.dart';
import 'package:pokemon_pokedex/screens/pokedexScreen/widgets/pokemon_information.dart';
import 'package:pokemon_pokedex/screens/pokedexScreen/widgets/pokemon_number.dart';

class PokemonWidget extends StatelessWidget {
  final PokemonBaseInformation pokemon;

  final BoxDecoration _decoration = BoxDecoration(
    color: Colors.white,
    borderRadius: const BorderRadius.all(
      Radius.circular(20),
    ),
    boxShadow: kElevationToShadow[3],
  );

  PokemonWidget(this.pokemon, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        PokemonNumber(pokemon.id),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 13.0,
              right: 17,
            ),
            child: Container(
              decoration: _decoration,
              padding: const EdgeInsets.all(12),
              child: Column(
                children: <Widget>[
                  PokemonImages(pokemon),
                  PokemonInformation(pokemon),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
