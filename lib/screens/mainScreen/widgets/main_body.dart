import 'package:flutter/material.dart';
import 'package:pokemon_pokedex/models/all_pokemons.dart';
import 'package:pokemon_pokedex/models/pokemon/pokemon/pokemon.dart';
import 'package:provider/provider.dart';

class MainBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AllPokemons>(
      builder: (BuildContext context, AllPokemons value, Widget child) {
        var all = value.getAll;
        try {
          return ListView(
            children: mapPokemonToWidget(all),
          );
        } catch(e) {
          return Text(e.toString());
        }
      },
    );
  }

  List<Widget> mapPokemonToWidget(List<Pokemon> pokemonList) {
    List<Widget> list = [Text(pokemonList.length.toString())];
    pokemonList.forEach((element) {
      list.add(Text(element.name));
    });
    return list;
  }
}
