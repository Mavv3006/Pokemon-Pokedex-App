import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pokemon_pokedex/models/color_information.dart';
import 'package:pokemon_pokedex/models/pokemon/pokemon/pokemon.dart';
import 'package:pokemon_pokedex/screens/mainScreen/widgets/pokemon_images.dart';
import 'package:pokemon_pokedex/screens/mainScreen/widgets/pokemon_number.dart';
import 'package:pokemon_pokedex/screens/mainScreen/widgets/type_indicator.dart';
import 'package:pokemon_pokedex/utils/constants.dart';
import 'package:pokemon_pokedex/utils/utils.dart';

class PokemonWidget extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonWidget(this.pokemon, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> typeIndicator = getTypeIndicator();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        PokemonNumber(pokemon.id),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 13.0,
              right: 17,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
                boxShadow: kElevationToShadow[3],
              ),
              padding: const EdgeInsets.all(12),
              child: Column(
                children: <Widget>[
                  PokemonImages(pokemon),
                  Container(
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
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> getTypeIndicator() {
    List<Widget> typeList = [
      Text(
        '${pokemon.name}',
        style: const TextStyle(
          color: MyColors.DARK_BLUE,
          fontSize: 15,
          fontWeight: FontWeight.w800,
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
