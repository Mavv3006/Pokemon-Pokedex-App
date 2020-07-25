import 'package:flutter/material.dart';
import 'package:pokemon_pokedex/models/pokemon/pokemon.dart';

class PokemonImages extends StatelessWidget {
  final Pokemon pokemon;

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
        pokemon.sprites.frontDefault.toString(),
        fit: BoxFit.contain,
      ),
    );
  }
}
