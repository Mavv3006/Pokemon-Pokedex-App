import 'package:flutter/material.dart';
import 'package:pokemon_pokedex/resources/provider/all_pokemons.dart';
import 'package:pokemon_pokedex/screens/mainScreen/widgets/pokemon_widget.dart';
import 'package:provider/provider.dart';

class MainBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AllPokemons>(
      builder: (BuildContext context, AllPokemons value, Widget child) {
        var all = value.getAll;
        try {
          return ListView.separated(
            padding: const EdgeInsets.only(
              top: 20,
              bottom: 20,
            ),
            itemCount: all.length,
            itemBuilder: (BuildContext context, int index) {
              return PokemonWidget(all[index]);
            },
            separatorBuilder: (BuildContext context, int index) => Divider(
              color: Colors.transparent,
              height: 12,
            ),
          );
        } catch (e) {
          return Text(e.toString());
        }
      },
    );
  }
}
