import 'package:flutter/material.dart';
import 'package:pokemon_pokedex/screens/mainDrawer/main_drawer.dart';
import 'package:pokemon_pokedex/screens/widgets/pokemon_app_bar.dart';
import 'package:pokemon_pokedex/screens/searchScreen/widgets/search_body.dart';
import 'package:pokemon_pokedex/screens/searchScreen/widgets/search_textfield.dart';
import 'package:pokemon_pokedex/utils/constants.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _textEditingController = TextEditingController();

  String query = "";

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  _changeValue(String value) {
    setState(() {
      query = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.BLUE,
      drawer: MainDrawer(),
      appBar: PokemonAppBar(
        title: SearchTextfield(
          onSubmitted: _changeValue,
          onValueChanged: _changeValue,
        ),
      ),
      body: SearchBody(query: query),
    );
  }
}
