import 'package:flutter/material.dart';
import 'package:pokemon_pokedex/resources/provider/all_pokemons.dart';
import 'package:pokemon_pokedex/utils/constants.dart';
import 'package:provider/provider.dart';

class PreviousButton extends StatelessWidget {
  const PreviousButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AllPokemons allPokemons = Provider.of<AllPokemons>(context);

    return Align(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 25,
          bottom: 25,
        ),
        child: FloatingActionButton(
          heroTag: "backButton",
          onPressed: allPokemons.currentPageNumber == 0
              ? null
              : allPokemons.previousPage,
          child: Icon(
            Icons.navigate_before,
            color: MyColors.YELLOW,
            size: 30,
          ),
          // Disabled Button Color
          backgroundColor: allPokemons.currentPageNumber == 0
              ? MyColors.BLUE_ACCENT
              : MyColors.DARK_BLUE,
        ),
      ),
    );
  }
}
