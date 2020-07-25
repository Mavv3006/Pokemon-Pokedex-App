import 'package:flutter/material.dart';
import 'package:pokemon_pokedex/resources/provider/all_pokemons.dart';
import 'package:pokemon_pokedex/utils/constants.dart';
import 'package:provider/provider.dart';

class ForwardButton extends StatelessWidget {
  const ForwardButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AllPokemons allPokemons = Provider.of<AllPokemons>(context);

    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.only(
          right: 25,
          bottom: 25,
        ),
        child: FloatingActionButton(
          heroTag: "nextButton",
          onPressed: allPokemons.nextPage,
          // Active Button Color
          backgroundColor: MyColors.DARK_BLUE,
          child: Icon(
            Icons.navigate_next,
            color: MyColors.YELLOW,
            size: 30,
          ),
        ),
      ),
    );
  }
}
