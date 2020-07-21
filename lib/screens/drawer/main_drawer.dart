import 'package:flutter/material.dart';
import 'package:pokemon_pokedex/models/database/base_information_database.dart';
import 'package:pokemon_pokedex/models/language.dart';
import 'package:pokemon_pokedex/screens/drawer/widgets/drawer_tile.dart';
import 'package:pokemon_pokedex/screens/searchScreen/search_screen.dart';
import 'package:pokemon_pokedex/utils/constants.dart';
import 'package:pokemon_pokedex/utils/routes.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<DrawerTile> drawerTileList = <DrawerTile>[
      DrawerTile(
        title: "Pokédex",
        onTap: () => Navigator.pushReplacementNamed(
          context,
          Routes.pokedex,
        ),
      ),
      DrawerTile(
        title: "Suchen",
        onTap: () => Navigator.pushReplacementNamed(
          context,
          Routes.search,
        ),
      ),
      DrawerTile(
        title: "Einstellungen",
        onTap: () => print("hi"),
      ),
      DrawerTile(
        title: "Update DB",
        onTap: () async {
          final BaseInformationDatabase database = BaseInformationDatabase();
          await database.init();
          database.updateBaseInformation();
        },
      ),
      DrawerTile(
        title: "Read DB",
        onTap: () async {
          final BaseInformationDatabase database = BaseInformationDatabase();
          await database.init();
          await database.getBaseInformation(Language.german());
        },
      ),
      DrawerTile(
        title: "Print DB",
        onTap: () async {
          final BaseInformationDatabase database = BaseInformationDatabase();
          await database.init();
          await database.printContent();
        },
      ),
      DrawerTile(
        title: "Search 'Bis'",
        onTap: () async {
          final BaseInformationDatabase database = BaseInformationDatabase();
          await database.init();
          print("Searching for 'Bis'");
          await database.search("Bis");
        },
      ),
      DrawerTile(
        title: "Search 'ak'",
        onTap: () async {
          final BaseInformationDatabase database = BaseInformationDatabase();
          await database.init();
          print("Searching for 'ak'");
          await database.search("ak");
        },
      ),
    ];

    return Container(
      padding: const EdgeInsets.only(top: 20),
      color: MyColors.BLUE_ACCENT,
      width: 250,
      child: ListView.separated(
        itemBuilder: (context, index) => drawerTileList[index],
        itemCount: drawerTileList.length,
        separatorBuilder: (context, index) => SizedBox.fromSize(
          size: Size.fromHeight(20),
        ),
        physics: NeverScrollableScrollPhysics(),
      ),
    );
  }
}
