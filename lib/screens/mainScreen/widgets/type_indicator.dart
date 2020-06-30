import 'package:flutter/material.dart';
import 'package:pokemon_pokedex/models/color_information.dart';

class TypeIndicator extends StatelessWidget {
  final ColorInformation typeColor;
  final String typeName;

  TypeIndicator({
    Key key,
    this.typeColor,
    this.typeName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(18, 2, 18, 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: typeColor.color,
      ),
      height: 20,
      constraints: BoxConstraints(minWidth: 58, maxHeight: 25),
      alignment: Alignment.center,
      child: Text(
        typeName,
        overflow: TextOverflow.fade,
        softWrap: false,
        style: TextStyle(
          color: typeColor.textColor,
          fontSize: 12,
        ),
      ),
    );
  }
}
