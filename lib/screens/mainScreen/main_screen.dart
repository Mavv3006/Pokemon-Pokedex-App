import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokemon_pokedex/resources/provider/all_pokemons.dart';
import 'package:pokemon_pokedex/screens/mainScreen/widgets/main_body.dart';
import 'package:pokemon_pokedex/screens/drawer/main_drawer.dart';
import 'package:pokemon_pokedex/utils/constants.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AllPokemons allPokemons = Provider.of<AllPokemons>(context);

    return Scaffold(
      backgroundColor: MyColors.BLUE,
      drawer: MainDrawer(),
      appBar: AppBar(
        bottom: PreferredSize(
          child: Container(),
          preferredSize: Size.fromHeight(5),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
          ),
        ),
        iconTheme: IconThemeData(color: MyColors.YELLOW),
        centerTitle: true,
        backgroundColor: MyColors.DARK_BLUE,
        title: Text(
          "Pokémon",
          style: GoogleFonts.lato(
            textStyle: Theme.of(context).textTheme.headline6.copyWith(
                  color: MyColors.YELLOW,
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                ),
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          MainBody(),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 25,
                bottom: 25,
              ),
              child: FloatingActionButton(
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
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(
                right: 25,
                bottom: 25,
              ),
              child: FloatingActionButton(
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
          ),
        ],
      ),
    );
  }
}
