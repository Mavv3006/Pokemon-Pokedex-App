import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokemon_pokedex/utils/constants.dart';

class SearchTextfield extends StatefulWidget {
  final Function(String) onValueChanged;
  final Function(String) onSubmitted;

  SearchTextfield({
    Key key,
    this.onValueChanged,
    this.onSubmitted,
  }) : super(key: key);

  @override
  _SearchTextfieldState createState() => _SearchTextfieldState();
}

class _SearchTextfieldState extends State<SearchTextfield> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: widget.onValueChanged,
      onSubmitted: widget.onSubmitted,
      maxLines: 1,
      controller: _controller,
      enableSuggestions: false,
      keyboardType: TextInputType.visiblePassword,
      autocorrect: false,
      cursorColor: MyColors.YELLOW,
      textInputAction: TextInputAction.search,
      style: GoogleFonts.lato(
        textStyle: Theme.of(context).textTheme.headline6.copyWith(
              color: MyColors.YELLOW,
              fontSize: 30,
              fontWeight: FontWeight.w900,
            ),
      ),
      decoration: InputDecoration(
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        suffixIcon: Icon(
          Icons.search,
          color: MyColors.YELLOW,
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
    );
  }
}
