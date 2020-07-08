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
      body: Stack(
        children: <Widget>[
          MainBody(),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 25,
                bottom: 25,
              ),
              child: FloatingActionButton(
                onPressed: null,
                child: Icon(
                  Icons.navigate_before,
                  color: MyColors.YELLOW,
                  size: 30,
                ),
                // Disabled Button Color
                backgroundColor: MyColors.BLUE_ACCENT,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(
                right: 25,
                bottom: 25,
              ),
              child: FloatingActionButton(
                onPressed: () {},
                // Active Button Color
                backgroundColor: MyColors.DARK_BLUE,
                child: Icon(
                  Icons.navigate_next,
                  color: MyColors.YELLOW,
                  size: 30,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
