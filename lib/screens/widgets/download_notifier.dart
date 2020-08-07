import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokemon_pokedex/utils/constants.dart';

class DownloadNotifier extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 195,
      width: 208,
      decoration: BoxDecoration(
        color: Color(0x333D7DCA),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Column(
        children: [
          CircularProgressIndicator(
            backgroundColor: MyColors.YELLOW,
          ),
          Text(
            "Download in progress",
            style: GoogleFonts.lato(
              color: MyColors.YELLOW,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
