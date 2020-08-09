import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokemon_pokedex/resources/settings/settings_provider.dart';
import 'package:pokemon_pokedex/screens/mainDrawer/main_drawer.dart';
import 'package:pokemon_pokedex/screens/settingsScreen/widgets/settings_tile.dart';
import 'package:pokemon_pokedex/screens/widgets/pokemon_app_bar.dart';
import 'package:pokemon_pokedex/utils/constants.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(
      context,
      listen: true,
    );

    final List<SettingsTile> settingsTileList = [
      SettingsTile(
        leading: 'Sprache ändern',
        activeSetting: settingsProvider.language.name,
        onPressed: () => settingsProvider.logActiveLanguageFromDatabase,
      ),
      SettingsTile(
        leading: 'Pokémon pro Seite',
        activeSetting: settingsProvider.pokemonAmountPerPage.toString(),
        onPressed: () => settingsProvider.logPokemonAmountPerPageFromDatabase,
      ),
    ];
    return Scaffold(
      backgroundColor: MyColors.BLUE,
      appBar: PokemonAppBar(
        title: Text(
          'Settings',
          style: GoogleFonts.lato(
            textStyle: Theme.of(context).textTheme.headline6.copyWith(
                  color: MyColors.YELLOW,
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                ),
          ),
        ),
        centerTitle: true,
      ),
      drawer: MainDrawer(),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
        itemBuilder: (context, index) => settingsTileList[index],
        itemCount: settingsTileList.length,
        separatorBuilder: (context, index) => SizedBox.fromSize(
          size: Size.fromHeight(20),
        ),
        physics: NeverScrollableScrollPhysics(),
      ),
    );
  }
}
