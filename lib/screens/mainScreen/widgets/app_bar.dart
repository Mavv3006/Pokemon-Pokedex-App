import 'package:flutter/material.dart';
import 'package:pokemon_pokedex/utils/constants.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Radius borderRadius = const Radius.circular(30);
  final Widget child;
  final bool hasDrawer;

  const MainAppBar({
    Key key,
    this.child,
    this.hasDrawer = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        height: 111,
        decoration: BoxDecoration(
          color: MyColors.DARK_BLUE,
          borderRadius: BorderRadius.only(
            bottomRight: borderRadius,
            bottomLeft: borderRadius,
          ),
        ),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left:8.0),
              child: Icon(Icons.menu),
            ),
            Spacer(),
            child,
            Spacer(),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(71);
}
