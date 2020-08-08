import 'package:flutter/material.dart';
import 'package:pokemon_pokedex/models/utility/pokemon_base_information.dart';

class PokemonImages extends StatelessWidget {
  final PokemonBaseInformation pokemon;

  PokemonImages(
    this.pokemon, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 120,
      child: Image.network(
        pokemon.frontImage.toString(),
        fit: BoxFit.contain,
      ),
    );
  }
}
