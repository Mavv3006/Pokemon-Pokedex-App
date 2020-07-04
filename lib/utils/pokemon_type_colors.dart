import 'package:pokemon_pokedex/models/color_information.dart';

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

  static ColorInformation getById(int id) {
    switch (id) {
      case 1:
        return normal;
      case 2:
        return fighting;
      case 3:
        return flying;
      case 4:
        return poison;
      case 5:
        return ground;
      case 6:
        return rock;
      case 7:
        return bug;
      case 8:
        return ghost;
      case 9:
        return steel;
      case 10:
        return fire;
      case 11:
        return water;
      case 12:
        return grass;
      case 13:
        return electric;
      case 14:
        return psychic;
      case 15:
        return ice;
      case 16:
        return dragon;
      case 17:
        return dark;
      case 18:
        return fairy;
      default:
        return unknown;
    }
  }
}
