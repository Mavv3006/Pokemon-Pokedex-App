import 'package:flutter/material.dart';
import 'package:pokemon_pokedex/models/utility/pokemon_base_information.dart';
import 'package:pokemon_pokedex/resources/provider/pokemon_provider.dart';
import 'package:pokemon_pokedex/screens/pokedexScreen/widgets/pokemon_list_view.dart';
import 'package:provider/provider.dart';

class MainBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PokemonProvider>(
      builder: (BuildContext context, PokemonProvider value, Widget child) {
        return FutureBuilder(
          future: value.currentPage,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            // the app is currently fetching information
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            // the app has data
            if (snapshot.hasData) {
              List<PokemonBaseInformation> pokemonList =
                  snapshot.data as List<PokemonBaseInformation>;

              return PokemonListView(pokemonList);
            }

            print('failed state');
            return Container();
          },
        );
      },
    );
  }
}
