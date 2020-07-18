class PokemonUtils {
  /// Returns the Uri for the front of a pokemon based on the id.
  static Uri getDefaultFrontImageFromId(int id) {
    return Uri.https(
      'raw.githubusercontent.com',
      '/PokeAPI/sprites/master/sprites/pokemon/$id.png',
    );
  }

  static int getTypeIdFromUrl(String url) {
    return int.parse(url.substring(31, url.length - 1));
  }
}
