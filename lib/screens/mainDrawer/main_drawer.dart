import 'package:flutter/material.dart';
import 'package:pokemon_pokedex/screens/mainDrawer/widgets/drawer_tile.dart';
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
        onTap: () => Navigator.pushReplacementNamed(
          context,
          Routes.settings,
        ),
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
