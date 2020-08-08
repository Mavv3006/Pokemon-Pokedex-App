import 'package:flutter/material.dart';
import 'package:pokemon_pokedex/models/grid_screen_information.dart';
import 'package:pokemon_pokedex/models/utility/pokemon_base_information.dart';
import 'package:pokemon_pokedex/screens/searchScreen/widgets/empty_search_result.dart';
import 'package:pokemon_pokedex/screens/searchScreen/widgets/search_item.dart';

class SearchResult extends StatelessWidget {
  final List<PokemonBaseInformation> data;
  final GridScreenInformation screenInformation;

  const SearchResult({
    Key key,
    this.data,
    this.screenInformation,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) return EmptySearchResult();

    return GridView.builder(
      padding: const EdgeInsets.only(
        top: 26,
        left: GridScreenInformation.outerPadding,
        right: GridScreenInformation.outerPadding,
        bottom: GridScreenInformation.outerPadding,
      ),
      scrollDirection: Axis.vertical,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        // crossAxisCount: 2,
        crossAxisCount: screenInformation.crossAxisCount,
        mainAxisSpacing: screenInformation.mainAxisSpacing,
        crossAxisSpacing: screenInformation.crossAxisSpacing,
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
  }
}
