import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokemon_pokedex/screens/pokedexScreen/widgets/previous_button.dart';
import 'package:pokemon_pokedex/screens/pokedexScreen/widgets/forward_button.dart';
import 'package:pokemon_pokedex/screens/pokedexScreen/widgets/main_body.dart';
import 'package:pokemon_pokedex/screens/mainDrawer/main_drawer.dart';
import 'package:pokemon_pokedex/screens/widgets/pokemon_app_bar.dart';
import 'package:pokemon_pokedex/utils/constants.dart';

class PokedexScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.BLUE,
      drawer: MainDrawer(),
      appBar: PokemonAppBar(
        centerTitle: true,
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
          PreviousButton(),
          ForwardButton(),
        ],
      ),
    );
  }
}
