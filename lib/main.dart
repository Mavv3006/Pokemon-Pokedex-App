import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokemon_pokedex/resources/api/api_provider.dart';
import 'package:pokemon_pokedex/resources/database/sqflite/sqflite_database.dart';
import 'package:pokemon_pokedex/resources/database/storage_provider.dart';
import 'package:pokemon_pokedex/resources/provider/all_pokemons.dart';
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
        ChangeNotifierProvider<AllPokemons>(
          create: (BuildContext context) {
            return AllPokemons();
          },
        ),
        Provider(
          create: (context) => ApiProvider(),
        ),
        ProxyProvider<ApiProvider, StorageProvider>(
          update: (
            BuildContext context,
            ApiProvider value,
            StorageProvider previous,
          ) {
            StorageProvider provider = SqfliteDatabase(apiProvider: value);
            _checkPokemonCount(value, provider);
            return provider;
          },
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

  Future<void> _checkPokemonCount(
    ApiProvider apiProvider,
    StorageProvider storageProvider,
  ) async {
    int remoteCount = await apiProvider.pokemonCount;
    if (await storageProvider.isUpToDate(remoteCount) == false) {
      storageProvider.update();
    }
  }
}
