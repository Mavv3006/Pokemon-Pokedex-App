import 'package:flutter/material.dart';

class ColorInformation {
  final Color color;
  final double luminance;
  Color textColor;

  ColorInformation(
    this.color, {
    this.luminance,
    this.textColor,
  });
}
