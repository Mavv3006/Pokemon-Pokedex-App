import 'package:flutter/material.dart';
import 'package:pokemon_pokedex/models/pokemon/pokemon/pokemon.dart';

class PokemonImages extends StatelessWidget {
  final Pokemon pokemon;

  PokemonImages(
    this.pokemon, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (pokemon.forms == null) {
      return Container(
        height: 50,
        width: 100,
        color: Colors.greenAccent,
      );
    }
    return Container(
      height: 120,
      width: (120 * pokemon.forms.length).toDouble(),
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: pokemon.forms.length,
        itemBuilder: (context, index) {
          print(pokemon.forms[index].url);
          return Image.network(
            pokemon.forms[index].url,
            height: 120,
            width: 120,
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }
}
