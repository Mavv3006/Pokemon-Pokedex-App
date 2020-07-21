import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokemon_pokedex/screens/drawer/main_drawer.dart';
import 'package:pokemon_pokedex/screens/searchScreen/widgets/search_body.dart';
import 'package:pokemon_pokedex/utils/constants.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.BLUE,
      drawer: MainDrawer(),
      appBar: AppBar(
        bottom: PreferredSize(
          child: Container(),
          preferredSize: Size.fromHeight(5),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
          ),
        ),
        iconTheme: IconThemeData(color: MyColors.YELLOW),
        title: TextField(
          maxLines: 1,
          controller: _textEditingController,
          enableSuggestions: false,
          keyboardType: TextInputType.visiblePassword,
          autocorrect: false,
          cursorColor: MyColors.YELLOW,
          textInputAction: TextInputAction.search,
          style: GoogleFonts.lato(
            textStyle: Theme.of(context).textTheme.headline6.copyWith(
                  color: MyColors.SEARCH,
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                ),
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: MyColors.BLUE_ACCENT),
            ),
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            suffixIcon: Icon(
              Icons.search,
              color: MyColors.SEARCH,
              size: 30,
            ),
            hintText: "Suche",
            hintStyle: GoogleFonts.lato(
              textStyle: Theme.of(context).textTheme.headline6.copyWith(
                    color: MyColors.SEARCH,
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                  ),
            ),
          ),
        ),
      ),
      body: SearchBody(),
    );
  }
}
