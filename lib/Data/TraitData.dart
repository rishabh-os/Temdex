class Trait {
  late String name;
  late String wikiUrl;
  late String description;
  late String effect;

  Trait(
      {required this.name,
      required this.wikiUrl,
      required this.description,
      required this.effect});

  Trait.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    wikiUrl = json['wikiUrl'];
    description = json['description'];
    effect = json['effect'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['wikiUrl'] = wikiUrl;
    data['description'] = description;
    data['effect'] = effect;
    return data;
  }
}
