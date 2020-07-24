import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokemon_pokedex/models/utility/pokemon_base_information.dart';
import 'package:pokemon_pokedex/resources/database/storage_provider.dart';
import 'package:pokemon_pokedex/screens/searchScreen/widgets/search_item.dart';
import 'package:pokemon_pokedex/utils/constants.dart';
import 'package:provider/provider.dart';

class SearchBody extends StatelessWidget {
  final String query;

  SearchBody({Key key, this.query}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (query == "") {
      return Container();
    }

    StorageProvider database = Provider.of<StorageProvider>(context);

    return FutureBuilder(
      future: database.search(query),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<PokemonBaseInformation> data =
              snapshot.data as List<PokemonBaseInformation>;

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
