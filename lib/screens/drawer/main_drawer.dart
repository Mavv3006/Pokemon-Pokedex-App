import 'package:flutter/material.dart';
import 'package:pokemon_pokedex/models/language.dart';
import 'package:pokemon_pokedex/models/utility/pokemon_base_information.dart';
import 'package:pokemon_pokedex/resources/database/storage_provider.dart';
import 'package:pokemon_pokedex/screens/drawer/widgets/drawer_tile.dart';
import 'package:pokemon_pokedex/utils/constants.dart';
import 'package:pokemon_pokedex/utils/routes.dart';
import 'package:provider/provider.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final StorageProvider database = Provider.of<StorageProvider>(context);

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
          database.update();
        },
      ),
      DrawerTile(
        title: "Read DB",
        onTap: () async {
          List<PokemonBaseInformation> list =
              await database.getAll(Language.german());
          print(list.toString());
        },
      ),
      DrawerTile(
        title: "Search 'Bis'",
        onTap: () async {
          List<PokemonBaseInformation> list = await database.search("Bis");
          print(list.toString());
        },
      ),
      DrawerTile(
        title: "Search 'ak'",
        onTap: () async {
          List<PokemonBaseInformation> list = await database.search("ak");
          print(list.toString());
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
