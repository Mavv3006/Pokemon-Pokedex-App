import 'package:flutter/material.dart';
import 'package:pokemon_pokedex/utils/constants.dart';

class PokemonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final Widget leading;
  final bool centerTitle;
  final Color backgroundColor;

  const PokemonAppBar({
    Key key,
    this.title,
    this.centerTitle = false,
    this.backgroundColor,
    this.leading,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 5);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(30),
          bottomLeft: Radius.circular(30),
        ),
      ),
      iconTheme: IconThemeData(color: MyColors.YELLOW),
      title: title,
      centerTitle: centerTitle,
      backgroundColor: backgroundColor,
      leading: leading,
    );
  }
}
