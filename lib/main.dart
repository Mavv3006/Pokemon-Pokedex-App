import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokemon_pokedex/resources/provider/pokemon_provider.dart';
import 'package:pokemon_pokedex/screens/pokedexScreen/pokedex_screen.dart';
import 'package:pokemon_pokedex/screens/searchScreen/search_screen.dart';
import 'package:pokemon_pokedex/screens/widgets/download_notifier.dart';
import 'package:pokemon_pokedex/screens/widgets/provider_list.dart';
import 'package:pokemon_pokedex/utils/constants.dart';
import 'package:pokemon_pokedex/utils/routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return ProviderList(
      child: MaterialApp(
        initialRoute: Routes.pokedex,
        routes: {
          Routes.pokedex: (context) => PokedexScreen(),
          Routes.search: (context) => SearchScreen(),
        },
        title: 'Flutter Demo',
        theme: ThemeData(
          textTheme: GoogleFonts.latoTextTheme(textTheme),
          primarySwatch: MyMaterialColors.DARK_BLUE,
          accentColor: MyColors.YELLOW,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
      ),
    );
  }
}
