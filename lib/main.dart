import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokemon_pokedex/models/all_pokemons.dart';
import 'package:pokemon_pokedex/screens/mainScreen/main_screen.dart';
import 'package:pokemon_pokedex/utils/constants.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return ChangeNotifierProvider<AllPokemons>(
      create: (BuildContext context) {
        return AllPokemons();
      },
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          textTheme: GoogleFonts.latoTextTheme(textTheme),
          primarySwatch: MyMaterialColors.DARK_BLUE,
          accentColor: MyColors.YELLOW,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(),
      ),
    );
  }
}
