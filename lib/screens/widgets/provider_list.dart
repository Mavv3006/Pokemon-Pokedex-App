import 'package:flutter/material.dart';
import 'package:pokemon_pokedex/resources/api/api_provider.dart';
import 'package:pokemon_pokedex/resources/database/sqflite/sqflite_database.dart';
import 'package:pokemon_pokedex/resources/database/storage_provider.dart';
import 'package:pokemon_pokedex/resources/provider/pokemon_provider.dart';
import 'package:pokemon_pokedex/resources/settings/settings_provider.dart';
import 'package:provider/provider.dart';

class ProviderList extends StatelessWidget {
  final Widget child;

  const ProviderList({Key key, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SettingsProvider>(
          create: (BuildContext context) => SettingsProvider(),
        ),
        ProxyProvider<SettingsProvider, ApiProvider>(
          update: (
            BuildContext context,
            SettingsProvider value,
            ApiProvider previous,
          ) {
            ApiProvider apiProvider = ApiProvider();
            apiProvider.settingsProvider = value;
            return apiProvider;
          },
        ),
        ProxyProvider<ApiProvider, StorageProvider>(
          lazy: false,
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
        ChangeNotifierProxyProvider3<SettingsProvider, ApiProvider,
            StorageProvider, PokemonProvider>(
          create: (BuildContext context) => PokemonProvider(),
          update: (
            BuildContext context,
            SettingsProvider settingsProvider,
            ApiProvider apiProvider,
            StorageProvider storageProvider,
            PokemonProvider _,
          ) {
            PokemonProvider pokemons = PokemonProvider();
            pokemons.apiProvider = apiProvider;
            pokemons.settingsProvider = settingsProvider;
            pokemons.storageProvider = storageProvider;
            return pokemons;
          },
        ),
      ],
      child: child,
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
