import 'package:flutter/material.dart';
import 'package:pokemon_pokedex/screens/drawer/widgets/drawer_tile.dart';
import 'package:pokemon_pokedex/utils/constants.dart';

class MainDrawer extends StatelessWidget {
  final List<DrawerTile> drawerTileList = <DrawerTile>[
    DrawerTile(
      title: "Pokédex",
      isActive: true,
    ),
    DrawerTile(title: "Suchen"),
    DrawerTile(title: "Einstellungen"),
  ];

  @override
  Widget build(BuildContext context) {
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
