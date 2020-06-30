import 'package:flutter/material.dart';
import 'package:pokemon_pokedex/models/color_information.dart';

class MyColors {
  static const int YELLOW_INT = 0xffffcb05;
  static const int DARK_BLUE_INT = 0xff003a70;
  static const int BLUE_INT = 0xff3d7dca;
  static const int BLUE_ACCENT_INT = 0xff2c60a0;

  static const Color YELLOW = const Color(0xffffcb05);
  static const Color DARK_BLUE = const Color(0xff003a70);
  static const Color BLUE = const Color(0xff3d7dca);
  static const Color BLUE_ACCENT = const Color(0xff2c60a0);
}

class MyMaterialColors {
  static const MaterialColor YELLOW = const MaterialColor(
    MyColors.YELLOW_INT,
    <int, Color>{
      50: MyColors.YELLOW,
      100: MyColors.YELLOW,
      200: MyColors.YELLOW,
      300: MyColors.YELLOW,
      400: MyColors.YELLOW,
      500: MyColors.YELLOW,
      600: MyColors.YELLOW,
      700: MyColors.YELLOW,
      800: MyColors.YELLOW,
      900: MyColors.YELLOW,
    },
  );
  static const MaterialColor DARK_BLUE = const MaterialColor(
    MyColors.DARK_BLUE_INT,
    <int, Color>{
      50: MyColors.DARK_BLUE,
      100: MyColors.DARK_BLUE,
      200: MyColors.DARK_BLUE,
      300: MyColors.DARK_BLUE,
      400: MyColors.DARK_BLUE,
      500: MyColors.DARK_BLUE,
      600: MyColors.DARK_BLUE,
      700: MyColors.DARK_BLUE,
      800: MyColors.DARK_BLUE,
      900: MyColors.DARK_BLUE,
    },
  );
  static const MaterialColor BLUE = const MaterialColor(
    MyColors.BLUE_INT,
    <int, Color>{
      50: MyColors.BLUE,
      100: MyColors.BLUE,
      200: MyColors.BLUE,
      300: MyColors.BLUE,
      400: MyColors.BLUE,
      500: MyColors.BLUE,
      600: MyColors.BLUE,
      700: MyColors.BLUE,
      800: MyColors.BLUE,
      900: MyColors.BLUE,
    },
  );
  static const MaterialColor BLUE_ACCENT = const MaterialColor(
    MyColors.BLUE_ACCENT_INT,
    <int, Color>{
      50: MyColors.BLUE_ACCENT,
      100: MyColors.BLUE_ACCENT,
      200: MyColors.BLUE_ACCENT,
      300: MyColors.BLUE_ACCENT,
      400: MyColors.BLUE_ACCENT,
      500: MyColors.BLUE_ACCENT,
      600: MyColors.BLUE_ACCENT,
      700: MyColors.BLUE_ACCENT,
      800: MyColors.BLUE_ACCENT,
      900: MyColors.BLUE_ACCENT,
    },
  );
}

class PokemonTypeColors {
  static ColorInformation poison = ColorInformation(
    const Color(0xff682a68),
    luminance: const Color(0xff682a68).computeLuminance(),
    textColor: const Color(0xff682a68).computeLuminance() > 0.5
        ? Colors.black
        : Colors.white,
  );
  static ColorInformation yellow = ColorInformation(
    const Color(MyColors.YELLOW_INT),
    luminance: const Color(MyColors.YELLOW_INT).computeLuminance(),
    textColor: const Color(MyColors.YELLOW_INT).computeLuminance() > 0.5
        ? Colors.black
        : Colors.white,
  );
  static ColorInformation white = ColorInformation(
    const Color(0xffffffff),
    luminance: const Color(0xffffffff).computeLuminance(),
    textColor: const Color(0xffffffff).computeLuminance() > 0.5
        ? Colors.black
        : Colors.white,
  );
}
