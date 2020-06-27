class NamedAPIResource {
  final String name;
  final String url;

  NamedAPIResource({
    this.name,
    this.url,
  });

  static NamedAPIResource fromJSON(Map<String, dynamic> element) {
    try {
      return NamedAPIResource(
        name: element['name'] as String,
        url: element['url'] as String,
      );
    } catch (e) {
      print('nothing found');
    }
    return NamedAPIResource();
  }
}
