import 'package:flutter/material.dart';
import 'package:pokemon_pokedex/screens/mainScreen/widgets/main_body.dart';
import 'package:pokemon_pokedex/utils/constants.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.BLUE,
      appBar: AppBar(
        bottom: PreferredSize(
          child: Container(),
          preferredSize: Size.fromHeight(5),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
          ),
        ),
        iconTheme: IconThemeData(color: MyColors.YELLOW),
        centerTitle: true,
        backgroundColor: MyColors.DARK_BLUE,
        title: Text(
          "Pokémon",
          style: TextStyle(
            color: MyColors.YELLOW,
            fontSize: 30,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: MainBody(),
    );
  }
}
