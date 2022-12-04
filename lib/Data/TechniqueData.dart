class TechniqueData {
  String? name;
  String? wikiUrl;
  String? type;
  String? classs;
  String? classIcon;
  int? damage;
  int? staminaCost;
  int? hold;
  String? priority;
  String? priorityIcon;
  String? synergy;
  List<SynergyEffects>? synergyEffects;
  String? targets;
  String? description;
  String? effectText;
  String? synergyText;
  // ? Makeshift solution, as currently is blank for all
  List<SynergyEffects>? effects;

  TechniqueData(
      {this.name,
      this.wikiUrl,
      this.type,
      this.classs,
      this.classIcon,
      this.damage,
      this.staminaCost,
      this.hold,
      this.priority,
      this.priorityIcon,
      this.synergy,
      this.synergyEffects,
      this.targets,
      this.description,
      this.effectText,
      this.synergyText,
      this.effects});

  TechniqueData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    wikiUrl = json['wikiUrl'];
    type = json['type'];
    classs = json['class'];
    classIcon = json['classIcon'];
    damage = json['damage'];
    staminaCost = json['staminaCost'];
    hold = json['hold'];
    priority = json['priority'];
    priorityIcon = json['priorityIcon'];
    synergy = json['synergy'];
    if (json['synergyEffects'] != null) {
      synergyEffects = <SynergyEffects>[];
      json['synergyEffects'].forEach((v) {
        synergyEffects!.add(SynergyEffects.fromJson(v));
      });
    }
    targets = json['targets'];
    description = json['description'];
    effectText = json['effectText'];
    synergyText = json['synergyText'];
    if (json['effects'] != null) {
      effects = <SynergyEffects>[];
      json['effects'].forEach((v) {
        effects!.add(v.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['wikiUrl'] = wikiUrl;
    data['type'] = type;
    data['classs'] = classs;
    data['classIcon'] = classIcon;
    data['damage'] = damage;
    data['staminaCost'] = staminaCost;
    data['hold'] = hold;
    data['priority'] = priority;
    data['priorityIcon'] = priorityIcon;
    data['synergy'] = synergy;
    if (synergyEffects != null) {
      data['synergyEffects'] = synergyEffects!.map((v) => v.toJson()).toList();
    }
    data['targets'] = targets;
    data['description'] = description;
    data['effectText'] = effectText;
    data['synergyText'] = synergyText;
    if (effects != null) {
      data['effects'] = effects!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SynergyEffects {
  String? effect;
  String? type;
  int? damage;

  SynergyEffects({this.effect, this.type, this.damage});

  SynergyEffects.fromJson(Map<String, dynamic> json) {
    effect = json['effect'];
    type = json['type'];
    damage = json['damage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['effect'] = effect;
    data['type'] = type;
    data['damage'] = damage;
    return data;
  }
}
