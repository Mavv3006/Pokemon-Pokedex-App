import 'package:flutter/material.dart';
import 'package:to_string/to_string.dart';

part 'color_information.g.dart';

@ToString()
class ColorInformation {
  Color color;
  double luminance;
  Color textColor;

  ColorInformation(int colorInt) {
    color = Color(colorInt);
    luminance = color.computeLuminance();
    textColor = luminance > 0.5 ? Colors.black : Colors.white;
  }

  @override
  String toString() {
    return _$ColorInformationToString(this);
  }
}
