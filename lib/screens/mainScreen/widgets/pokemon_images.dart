import 'package:flutter/material.dart';
import 'package:pokemon_pokedex/models/pokemon/pokemon/pokemon.dart';

class PokemonImages extends StatelessWidget {
  final Pokemon pokemon;
  final double frontSize = 150;
  final double backSize = 120;

  PokemonImages(
    this.pokemon, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (pokemon.sprites == null) {
      return Container(
        height: 70,
        width: double.infinity,
        color: Colors.greenAccent,
      );
    }
    return SizedBox(
      width: double.infinity,
      height: 70,
      child: Stack(
        children: <Widget>[
          Positioned(
            child: Image.network(
              pokemon.sprites.frontDefault,
              fit: BoxFit.cover,
            ),
            top: -39,
            left: -6,
            width: frontSize,
            height: frontSize,
          ),
          Positioned(
            child: Image.network(
              pokemon.sprites.backDefault,
              fit: BoxFit.cover,
            ),
            width: backSize,
            height: backSize,
            top: -23,
            left: 105,
            // bottom: 0,
          ),
        ],
      ),
    );
  }
}
