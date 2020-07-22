import 'package:flutter/material.dart';
import 'package:pokemon_pokedex/utils/constants.dart';

class SearchItem extends StatelessWidget {
  final int number;
  final String name;
  final String picture;

  const SearchItem({Key key, this.number, this.name, this.picture})
      : super(key: key);

  Widget _getText(String text) {
    return Text(
      text,
      style: TextStyle(
        color: MyColors.DARK_BLUE,
        fontSize: 19,
        fontWeight: FontWeight.w900,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: kElevationToShadow[3],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.network(
            picture,
            height: 80,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _getText('$number'),
              SizedBox(width: 15),
              _getText(name),
            ],
          ),
        ],
      ),
    );
  }
}
