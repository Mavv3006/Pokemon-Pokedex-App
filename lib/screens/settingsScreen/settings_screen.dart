import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokemon_pokedex/screens/mainDrawer/main_drawer.dart';
import 'package:pokemon_pokedex/screens/settingsScreen/widgets/settings_tile.dart';
import 'package:pokemon_pokedex/screens/widgets/pokemon_app_bar.dart';
import 'package:pokemon_pokedex/utils/constants.dart';

class SettingsScreen extends StatelessWidget {
  final List<SettingsTile> settingsTileList = <SettingsTile>[
    SettingsTile(
      activeSetting: 'Sprache ändern',
      leading: 'Sprache ändern',
    ),
    SettingsTile(
      activeSetting: 'Sprache ändern',
      leading: 'Sprache ändern',
    ),
    SettingsTile(
      activeSetting: 'Sprache ändern',
      leading: 'Sprache ändern',
    ),
    SettingsTile(
      activeSetting: 'Sprache ändern',
      leading: 'Sprache ändern',
    ),
  ];

  @override
  Widget build(BuildContext context) {
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
