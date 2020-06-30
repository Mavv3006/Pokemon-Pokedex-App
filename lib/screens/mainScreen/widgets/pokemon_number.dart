import 'package:flutter/material.dart';
import 'package:pokemon_pokedex/utils/constants.dart';

class PokemonNumber extends StatelessWidget {
  final int id;

  const PokemonNumber(
    this.id, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 17.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: kElevationToShadow[3],
        ),
        padding: const EdgeInsets.only(
          left: 24,
          top: 14,
          bottom: 14,
          right: 24,
        ),
        child: Text(
          '$id',
          style: TextStyle(
            color: MyColors.DARK_BLUE,
            fontSize: 18,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}
