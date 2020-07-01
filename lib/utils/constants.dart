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
  static ColorInformation bug = ColorInformation(0xffA8B820);
  static ColorInformation dark = ColorInformation(0xff705848);
  static ColorInformation dragon = ColorInformation(0xff7038F8);
  static ColorInformation electric = ColorInformation(0xffF8D030);
  static ColorInformation fairy = ColorInformation(0xffEE99AC);
  static ColorInformation fighting = ColorInformation(0xffC03028);
  static ColorInformation fire = ColorInformation(0xffF08030);
  static ColorInformation flying = ColorInformation(0xffA890F0);
  static ColorInformation ghost = ColorInformation(0xff705898);
  static ColorInformation grass = ColorInformation(0xff78C850);
  static ColorInformation ground = ColorInformation(0xffE0C068);
  static ColorInformation ice = ColorInformation(0xff98D8D8);
  static ColorInformation normal = ColorInformation(0xffA8A878);
  static ColorInformation poison = ColorInformation(0xffA040A0);
  static ColorInformation psychic = ColorInformation(0xffF85888);
  static ColorInformation rock = ColorInformation(0xffB8A038);
  static ColorInformation steel = ColorInformation(0xffB8B8D0);
  static ColorInformation water = ColorInformation(0xff6890F0);
  static ColorInformation unknown = ColorInformation(0xff68A090);
}
