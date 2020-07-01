import 'package:flutter/material.dart';

class ColorInformation {
  Color color;
  double luminance;
  Color textColor;

  ColorInformation(int colorInt) {
    color = Color(colorInt);
    luminance = color.computeLuminance();
    textColor = luminance > 0.5 ? Colors.black : Colors.white;
  }
}
