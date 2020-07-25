import 'package:flutter/material.dart';
import 'package:pokemon_pokedex/models/grid_screen_information.dart';
import 'package:pokemon_pokedex/models/utility/pokemon_base_information.dart';
import 'package:pokemon_pokedex/resources/database/storage_provider.dart';
import 'package:pokemon_pokedex/screens/searchScreen/widgets/empty_search_result.dart';
import 'package:pokemon_pokedex/screens/searchScreen/widgets/search_result.dart';
import 'package:provider/provider.dart';

class SearchBody extends StatelessWidget {
  final String query;
  final GridScreenInformation screenInformation = GridScreenInformation();

  SearchBody({Key key, this.query}) : super(key: key);

  _calcScreenInformation(BuildContext context) {
    double width = MediaQuery.of(context).size.width -
        2 * GridScreenInformation.outerPadding;

    screenInformation.crossAxisCount = _calcAmount(width);
    screenInformation.calcAspectRatio(width: width);
  }

  int _calcAmount(double width) {
    if (screenInformation.isValid(width)) {
      int amount = screenInformation.getAmount(width);
      return amount;
    } else {
      print('invalid state');
      return 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (query == "") {
      return EmptySearchResult();
    }

    _calcScreenInformation(context);

    StorageProvider database = Provider.of<StorageProvider>(context);

    return FutureBuilder(
      future: database.search(query),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SearchResult(
            data: snapshot.data as List<PokemonBaseInformation>,
            screenInformation: screenInformation,
          );
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
