import 'package:flutter/material.dart';
import 'package:pokemon_pokedex/models/color_information.dart';
import 'package:pokemon_pokedex/models/pokemon/pokemon/pokemon.dart';
import 'package:pokemon_pokedex/screens/mainScreen/widgets/type_indicator.dart';
import 'package:pokemon_pokedex/utils/constants.dart';
import 'package:pokemon_pokedex/utils/utils.dart';

class PokemonInformation extends StatelessWidget {
  const PokemonInformation(
    this.pokemon, {
    Key key,
  }) : super(key: key);

  final Pokemon pokemon;

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
    if (pokemon.types != null) {
      for (var i = 0; i < pokemon.types.length; i++) {
        ColorInformation typeColor = Utils.mapTypeToColor(pokemon.types[i]);
        Widget typeIndicator = TypeIndicator(
          typeColor: typeColor,
          typeName: pokemon.types[i].type.name,
        );
        typeList.add(typeIndicator);
      }
    }
    return typeList;
  }
}
