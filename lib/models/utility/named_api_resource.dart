class NamedAPIResource {
  String name;
  String url;

  NamedAPIResource.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String;
    url = json['url'] as String;
  }
}
