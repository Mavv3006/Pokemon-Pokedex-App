import 'package:flutter/material.dart';
import 'package:pokemon_pokedex/models/utility/pokemon_base_information.dart';
import 'package:pokemon_pokedex/screens/pokedexScreen/widgets/pokemon_widget.dart';

class PokemonListView extends StatelessWidget {
  final List<PokemonBaseInformation> pokemonList;

  const PokemonListView(
    this.pokemonList, {
    Key key,
  }) : super(key: key);

  Widget _itemBuilder(BuildContext context, int index) =>
      PokemonWidget(pokemonList[index]);

  Widget _separatorBuilder(BuildContext context, int index) => Divider(
        color: Colors.transparent,
        height: 12,
      );

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(
        top: 20,
        bottom: 20,
      ),
      itemCount: pokemonList.length,
      itemBuilder: _itemBuilder,
      separatorBuilder: _separatorBuilder,
    );
  }
}
