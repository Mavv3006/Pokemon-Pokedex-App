import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokemon_pokedex/resources/api/api_provider.dart';
import 'package:pokemon_pokedex/resources/database/sqflite/sqflite_database.dart';
import 'package:pokemon_pokedex/resources/database/storage_provider.dart';
import 'package:pokemon_pokedex/resources/provider/pokemon_provider.dart';
import 'package:pokemon_pokedex/resources/settings/settings_provider.dart';
import 'package:pokemon_pokedex/screens/pokedexScreen/pokedex_screen.dart';
import 'package:pokemon_pokedex/screens/searchScreen/search_screen.dart';
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

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SettingsProvider>(
          create: (BuildContext context) => SettingsProvider(),
        ),
        ChangeNotifierProxyProvider<SettingsProvider, PokemonProvider>(
          create: (BuildContext context) => PokemonProvider(),
          update: (
            BuildContext context,
            SettingsProvider value,
            PokemonProvider previous,
          ) {
            PokemonProvider pokemons = PokemonProvider();
            pokemons.language = value.language;
            pokemons.pokemonAmountPerPage = value.pokemonAmountPerPage;
            return pokemons;
          },
        ),
        Provider<ApiProvider>(
          create: (BuildContext context) => ApiProvider(),
        ),
        ProxyProvider<ApiProvider, StorageProvider>(
          update: (
            BuildContext context,
            ApiProvider value,
            StorageProvider previous,
          ) =>
              SqfliteDatabase(apiProvider: value),
        ),
      ],
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
