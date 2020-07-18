import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokemon_pokedex/utils/constants.dart';

class DrawerTile extends StatelessWidget {
  final String title;
  final bool isActive;
  final VoidCallback onTap;

  const DrawerTile({
    Key key,
    this.onTap,
    @required this.title,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: GestureDetector(
        //TODO: implement routing
        onTap: onTap,
        child: Container(
          width: 180,
          height: 50,
          alignment: Alignment.center,
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: isActive ? MyColors.DARK_BLUE : MyColors.BLUE,
          ),
          child: Text(
            title,
            style: GoogleFonts.russoOne(
              textStyle: Theme.of(context).textTheme.bodyText2.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: MyColors.YELLOW,
                    letterSpacing: 1.2,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
