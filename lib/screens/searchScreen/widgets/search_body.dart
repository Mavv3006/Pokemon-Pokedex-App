import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokemon_pokedex/models/database/base_information_database.dart';
import 'package:pokemon_pokedex/models/language.dart';
import 'package:pokemon_pokedex/models/utility/pokemon_base_information.dart';
import 'package:pokemon_pokedex/screens/searchScreen/widgets/database_provider.dart';
import 'package:pokemon_pokedex/screens/searchScreen/widgets/search_item.dart';
import 'package:pokemon_pokedex/utils/constants.dart';

class SearchBody extends StatelessWidget {
  final String query;

  SearchBody({Key key, this.query}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (query == "") {
      return Container();
    }

    BaseInformationDatabase database = DatabaseProvider.of(context).database;

    return FutureBuilder(
      future: database.search(query),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<PokemonBaseInformation> data =
              snapshot.data as List<PokemonBaseInformation>;

          // return ListView.separated(
          //   padding: const EdgeInsets.only(
          //     top: 26,
          //     left: 21,
          //     right: 21,
          //   ),
          //   itemBuilder: (context, index) {
          //     PokemonBaseInformation pokemon = data[index];
          //     return SearchItem(
          //       name: pokemon.name,
          //       number: pokemon.id,
          //       picture: pokemon.frontImage,
          //     );
          //   },
          //   separatorBuilder: (BuildContext context, int index) => Divider(
          //     color: Colors.transparent,
          //     height: 14,
          //   ),
          //   itemCount: data.length,
          // );

          return GridView.builder(
            padding: const EdgeInsets.only(
              top: 26,
              left: 21,
              right: 21,
            ),
            scrollDirection: Axis.vertical,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 14,
              crossAxisSpacing: 21,
              childAspectRatio: 16 / 10,
            ),
            itemBuilder: (context, index) {
              PokemonBaseInformation pokemon = data[index];
              return SearchItem(
                name: pokemon.name,
                number: pokemon.id,
                picture: pokemon.frontImage,
              );
            },
            itemCount: data.length,
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          return Center(
            child: Text(
              "No Data",
              style: GoogleFonts.lato(color: MyColors.DARK_BLUE, fontSize: 24),
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
