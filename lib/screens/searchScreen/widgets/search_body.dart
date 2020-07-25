import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokemon_pokedex/models/grid_screen_information.dart';
import 'package:pokemon_pokedex/models/utility/pokemon_base_information.dart';
import 'package:pokemon_pokedex/resources/database/storage_provider.dart';
import 'package:pokemon_pokedex/screens/searchScreen/widgets/search_item.dart';
import 'package:pokemon_pokedex/utils/constants.dart';
import 'package:provider/provider.dart';

class SearchBody extends StatelessWidget {
  final String query;
  static const double _crossAxisSpacing = 21;
  static const double _mainAxisSpacing = 14;
  static const double _outerPadding = 21;
  static const double _minGridElementWidth = 145;
  static const double _minGridElementHeight = 108;
  final GridScreenInformation screenInformation = GridScreenInformation();

  SearchBody({Key key, this.query}) : super(key: key);

  GridScreenInformation _calcScreenInformation(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 2 * _outerPadding;

    int amount = _calcAmount(width);

    double elementWidth = _calcWidth(amount, width);

    screenInformation.childAspectRatio = elementWidth / _minGridElementHeight;
    screenInformation.crossAxisCount = amount;

    print(
      '''
      elementWidth: $elementWidth // 
      screenInformation: ${screenInformation.toString()}
      ''',
    );
    return GridScreenInformation();
  }

  double _calcWidth(int amount, double width) {
    return (width - (amount - 1) * _crossAxisSpacing) / amount;
  }

  int _calcAmount(double width) {
    if (_crossAxisSpacing > -width &&
        _minGridElementWidth > -_crossAxisSpacing) {
      int amount = (_crossAxisSpacing + width) ~/
          (_crossAxisSpacing + _minGridElementWidth);
      return amount;
    } else {
      print('invalid state');
      return 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (query == "") {
      return Container();
    }

    _calcScreenInformation(context);

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
              left: _outerPadding,
              right: _outerPadding,
            ),
            scrollDirection: Axis.vertical,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              // crossAxisCount: 2,
              crossAxisCount: screenInformation.crossAxisCount,
              mainAxisSpacing: _mainAxisSpacing,
              crossAxisSpacing: _crossAxisSpacing,
              // childAspectRatio: 16 / 10,
              childAspectRatio: screenInformation.childAspectRatio,
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
