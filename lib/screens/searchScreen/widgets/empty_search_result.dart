import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokemon_pokedex/utils/constants.dart';

class EmptySearchResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "No Data",
        style: GoogleFonts.lato(
          color: MyColors.DARK_BLUE,
          fontSize: 24,
        ),
      ),
    );
  }
}
