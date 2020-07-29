import 'package:flutter/material.dart';
import 'package:pokemon_pokedex/models/color_information.dart';
import 'package:pokemon_pokedex/models/utility/pokemon_base_information.dart';
import 'package:pokemon_pokedex/screens/pokedexScreen/widgets/type_indicator.dart';
import 'package:pokemon_pokedex/utils/constants.dart';
import 'package:pokemon_pokedex/utils/pokemon_type_colors.dart';

class PokemonInformation extends StatelessWidget {
  const PokemonInformation(
    this.pokemon, {
    Key key,
  }) : super(key: key);

  final PokemonBaseInformation pokemon;

  List<Widget> getTypeIndicator() {
    List<Widget> typeList = [
      Padding(
        padding: const EdgeInsets.only(left: 5.0),
        child: Text(
          '${pokemon.name}',
          style: const TextStyle(
            color: MyColors.DARK_BLUE,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ];
    ColorInformation typeColor = PokemonTypeColors.getById(pokemon.type1.id);
    Widget typeIndicator = TypeIndicator(
      typeColor: typeColor,
      typeName: pokemon.type1.name,
    );
    typeList.add(typeIndicator);
    if (pokemon.type2 != null) {
      ColorInformation typeColor = PokemonTypeColors.getById(pokemon.type2.id);
      Widget typeIndicator = TypeIndicator(
        typeColor: typeColor,
        typeName: pokemon.type2.name,
      );
      typeList.add(typeIndicator);
    }
    return typeList;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> typeIndicator = getTypeIndicator();
    return Container(
      margin: const EdgeInsets.only(top: 10),
      height: 20,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => typeIndicator[index],
        itemCount: typeIndicator.length,
        separatorBuilder: (context, index) => const Padding(
          padding: const EdgeInsets.all(6),
        ),
      ),
    );
  }
}
