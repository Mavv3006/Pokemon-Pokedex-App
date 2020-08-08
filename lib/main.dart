import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokemon_pokedex/screens/pokedexScreen/pokedex_screen.dart';
import 'package:pokemon_pokedex/screens/searchScreen/search_screen.dart';
import 'package:pokemon_pokedex/screens/settingsScreen/settings_screen.dart';
import 'package:pokemon_pokedex/screens/widgets/download.dart';
import 'package:pokemon_pokedex/screens/widgets/provider_list.dart';
import 'package:pokemon_pokedex/utils/constants.dart';
import 'package:pokemon_pokedex/utils/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return ProviderList(
      child: MaterialApp(
        initialRoute: Routes.downlaod,
        routes: {
          Routes.pokedex: (context) => PokedexScreen(),
          Routes.search: (context) => SearchScreen(),
          Routes.downlaod: (context) => Download(),
          Routes.settings: (context) => SettingsScreen(),
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
