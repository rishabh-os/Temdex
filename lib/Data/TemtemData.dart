class Temtem {
  late int number;
  late String name;
  List<String>? types;
  String? portraitWikiUrl;
  String? wikiUrl;
  late Stats stats;
  late List<String> traits;
  Details? details;
  late List<Techniques> techniques;
  List<String>? trivia;
  Evolution? evolution;
  String? wikiPortraitUrlLarge;
  List<Locations>? locations;
  String? icon;
  String? lumaIcon;
  late GenderRatio genderRatio;
  late int catchRate;
  late num hatchMins;
  TvYields? tvYields;
  late String gameDescription;
  String? wikiRenderStaticUrl;
  String? wikiRenderAnimatedUrl;
  String? wikiRenderStaticLumaUrl;
  String? wikiRenderAnimatedLumaUrl;
  String? renderStaticImage;
  String? renderStaticLumaImage;
  String? renderAnimatedImage;
  String? renderAnimatedLumaImage;

  Temtem(
      {this.number = 0,
      this.name = "Null",
      this.types,
      this.portraitWikiUrl,
      this.wikiUrl,
      required this.stats,
      this.traits = const ["None"],
      this.details,
      required this.techniques,
      this.trivia,
      this.evolution,
      this.wikiPortraitUrlLarge,
      this.locations,
      this.icon,
      this.lumaIcon,
      required this.genderRatio,
      this.catchRate = 0,
      this.hatchMins = 0,
      required this.tvYields,
      this.gameDescription = "No game description provided",
      this.wikiRenderStaticUrl,
      this.wikiRenderAnimatedUrl,
      this.wikiRenderStaticLumaUrl,
      this.wikiRenderAnimatedLumaUrl,
      this.renderStaticImage,
      this.renderStaticLumaImage,
      this.renderAnimatedImage,
      this.renderAnimatedLumaImage});

  Temtem.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    name = json['name'];
    types = json['types'].cast<String>();
    portraitWikiUrl = json['portraitWikiUrl'];
    wikiUrl = json['wikiUrl'];
    stats = (json['stats'] != null ? Stats.fromJson(json['stats']) : null)!;
    traits = json['traits'].cast<String>();
    details =
        json['details'] != null ? Details.fromJson(json['details']) : null;
    if (json['techniques'] != null) {
      techniques = <Techniques>[];
      json['techniques'].forEach((v) {
        techniques.add(Techniques.fromJson(v));
      });
    }
    trivia = json['trivia'].cast<String>();
    evolution = json['evolution'] != null
        ? Evolution.fromJson(json['evolution'])
        : null;
    wikiPortraitUrlLarge = json['wikiPortraitUrlLarge'];
    if (json['locations'] != null) {
      locations = <Locations>[];
      json['locations'].forEach((v) {
        locations!.add(Locations.fromJson(v));
      });
    }
    icon = json['icon'];
    lumaIcon = json['lumaIcon'];

    genderRatio = GenderRatio.fromJson(json['genderRatio']);

    catchRate = json['catchRate'];
    hatchMins = json['hatchMins'];
    tvYields = (json['tvYields'] != null
        ? TvYields.fromJson(json['tvYields'])
        : null)!;
    gameDescription = json['gameDescription'];
    wikiRenderStaticUrl = json['wikiRenderStaticUrl'];
    wikiRenderAnimatedUrl = json['wikiRenderAnimatedUrl'];
    wikiRenderStaticLumaUrl = json['wikiRenderStaticLumaUrl'];
    wikiRenderAnimatedLumaUrl = json['wikiRenderAnimatedLumaUrl'];
    renderStaticImage = json['renderStaticImage'];
    renderStaticLumaImage = json['renderStaticLumaImage'];
    renderAnimatedImage = json['renderAnimatedImage'];
    renderAnimatedLumaImage = json['renderAnimatedLumaImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['number'] = number;
    data['name'] = name;
    data['types'] = types;
    data['portraitWikiUrl'] = portraitWikiUrl;
    data['wikiUrl'] = wikiUrl;
    data['stats'] = stats.toJson();
    data['traits'] = traits;
    if (details != null) {
      data['details'] = details!.toJson();
    }
    data['techniques'] = techniques.map((v) => v.toJson()).toList();
    data['trivia'] = trivia;
    if (evolution != null) {
      data['evolution'] = evolution!.toJson();
    }
    data['wikiPortraitUrlLarge'] = wikiPortraitUrlLarge;
    if (locations != null) {
      data['locations'] = locations!.map((v) => v.toJson()).toList();
    }
    data['icon'] = icon;
    data['lumaIcon'] = lumaIcon;
    data['genderRatio'] = genderRatio.toJson();
    data['catchRate'] = catchRate;
    data['hatchMins'] = hatchMins;
    if (tvYields != null) {
      data['tvYields'] = tvYields!.toJson();
    }
    data['gameDescription'] = gameDescription;
    data['wikiRenderStaticUrl'] = wikiRenderStaticUrl;
    data['wikiRenderAnimatedUrl'] = wikiRenderAnimatedUrl;
    data['wikiRenderStaticLumaUrl'] = wikiRenderStaticLumaUrl;
    data['wikiRenderAnimatedLumaUrl'] = wikiRenderAnimatedLumaUrl;
    data['renderStaticImage'] = renderStaticImage;
    data['renderStaticLumaImage'] = renderStaticLumaImage;
    data['renderAnimatedImage'] = renderAnimatedImage;
    data['renderAnimatedLumaImage'] = renderAnimatedLumaImage;
    return data;
  }
}

class Stats {
  late int hp;
  late int sta;
  late int spd;
  late int atk;
  late int def;
  late int spatk;
  late int spdef;
  late int total;

  Stats(
      {this.hp = 0,
      this.sta = 0,
      this.spd = 0,
      this.atk = 0,
      this.def = 0,
      this.spatk = 0,
      this.spdef = 0,
      this.total = 0});

  Stats.fromJson(Map<String, dynamic> json) {
    hp = json['hp'];
    sta = json['sta'];
    spd = json['spd'];
    atk = json['atk'];
    def = json['def'];
    spatk = json['spatk'];
    spdef = json['spdef'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hp'] = hp;
    data['sta'] = sta;
    data['spd'] = spd;
    data['atk'] = atk;
    data['def'] = def;
    data['spatk'] = spatk;
    data['spdef'] = spdef;
    data['total'] = total;
    return data;
  }
}

class Details {
  Height? height;
  Weight? weight;

  Details({this.height, this.weight});

  Details.fromJson(Map<String, dynamic> json) {
    height = json['height'] != null ? Height.fromJson(json['height']) : null;
    weight = json['weight'] != null ? Weight.fromJson(json['weight']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (height != null) {
      data['height'] = height!.toJson();
    }
    if (weight != null) {
      data['weight'] = weight!.toJson();
    }
    return data;
  }
}

class Height {
  int? cm;
  int? inches;

  Height({this.cm, this.inches});

  Height.fromJson(Map<String, dynamic> json) {
    cm = json['cm'];
    inches = json['inches'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cm'] = cm;
    data['inches'] = inches;
    return data;
  }
}

class Weight {
  int? kg;
  int? lbs;

  Weight({this.kg, this.lbs});

  Weight.fromJson(Map<String, dynamic> json) {
    kg = json['kg'];
    lbs = json['lbs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['kg'] = kg;
    data['lbs'] = lbs;
    return data;
  }
}

class Techniques {
  String name = "";
  String source = "";
  int? levels;

  Techniques({required this.name, required this.source, this.levels});

  Techniques.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    source = json['source'];
    levels = json['levels'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['source'] = source;
    data['levels'] = levels;
    return data;
  }
}

class Evolution {
  int? stage;
  List<EvolutionTree>? evolutionTree;
  bool? evolves;
  String? type;

  Evolution({this.stage, this.evolutionTree, this.evolves, this.type});

  Evolution.fromJson(Map<String, dynamic> json) {
    stage = json['stage'];
    if (json['evolutionTree'] != null) {
      evolutionTree = <EvolutionTree>[];
      json['evolutionTree'].forEach((v) {
        evolutionTree!.add(EvolutionTree.fromJson(v));
      });
    }
    evolves = json['evolves'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['stage'] = stage;
    if (evolutionTree != null) {
      data['evolutionTree'] = evolutionTree!.map((v) => v.toJson()).toList();
    }
    data['evolves'] = evolves;
    data['type'] = type;
    return data;
  }
}

class EvolutionTree {
  int? number;
  String? name;
  int? stage;
  int? levels;
  bool? trading;
  TraitMapping? traitMapping;

  EvolutionTree(
      {this.number,
      this.name,
      this.stage,
      this.levels,
      this.trading,
      this.traitMapping});

  EvolutionTree.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    name = json['name'];
    stage = json['stage'];
    levels = json['levels'];
    trading = json['trading'];
    traitMapping = json['traitMapping'] != null
        ? TraitMapping.fromJson(json['traitMapping'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['number'] = number;
    data['name'] = name;
    data['stage'] = stage;
    data['levels'] = levels;
    data['trading'] = trading;
    if (traitMapping != null) {
      data['traitMapping'] = traitMapping!.toJson();
    }
    return data;
  }
}

class TraitMapping {
  String? botanophobia;
  String? coldNatured;
  String? receptive;
  String? fastCharge;

  TraitMapping(
      {this.botanophobia, this.coldNatured, this.receptive, this.fastCharge});

  TraitMapping.fromJson(Map<String, dynamic> json) {
    botanophobia = json['Botanophobia'];
    coldNatured = json['Cold-Natured'];
    receptive = json['Receptive'];
    fastCharge = json['Fast Charge'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Botanophobia'] = botanophobia;
    data['Cold-Natured'] = coldNatured;
    data['Receptive'] = receptive;
    data['Fast Charge'] = fastCharge;
    return data;
  }
}

class Locations {
  String? location;
  String? place;
  String? note;
  String? island;
  String? frequency;
  String? level;
  Freetem? freetem;

  Locations(
      {this.location,
      this.place,
      this.note,
      this.island,
      this.frequency,
      this.level,
      this.freetem});

  Locations.fromJson(Map<String, dynamic> json) {
    location = json['location'];
    place = json['place'];
    note = json['note'];
    island = json['island'];
    frequency = json['frequency'];
    level = json['level'];
    freetem =
        json['freetem'] != null ? Freetem.fromJson(json['freetem']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['location'] = location;
    data['place'] = place;
    data['note'] = note;
    data['island'] = island;
    data['frequency'] = frequency;
    data['level'] = level;
    if (freetem != null) {
      data['freetem'] = freetem!.toJson();
    }
    return data;
  }
}

class Freetem {
  int? minLevel;
  int? maxLevel;
  int? minPansuns;
  int? maxPansuns;

  Freetem({this.minLevel, this.maxLevel, this.minPansuns, this.maxPansuns});

  Freetem.fromJson(Map<String, dynamic> json) {
    minLevel = json['minLevel'];
    maxLevel = json['maxLevel'];
    minPansuns = json['minPansuns'];
    maxPansuns = json['maxPansuns'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['minLevel'] = minLevel;
    data['maxLevel'] = maxLevel;
    data['minPansuns'] = minPansuns;
    data['maxPansuns'] = maxPansuns;
    return data;
  }
}

class GenderRatio {
  int? male;
  int? female;

  GenderRatio({this.male, this.female});

  GenderRatio.fromJson(Map<String, dynamic> json) {
    male = json['male'];
    female = json['female'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['male'] = male;
    data['female'] = female;
    return data;
  }
}

class TvYields {
  int? hp;
  int? sta;
  int? spd;
  int? atk;
  int? def;
  int? spatk;
  int? spdef;

  TvYields(
      {this.hp,
      this.sta,
      this.spd,
      this.atk,
      this.def,
      this.spatk,
      this.spdef});

  TvYields.fromJson(Map<String, dynamic> json) {
    hp = json['hp'];
    sta = json['sta'];
    spd = json['spd'];
    atk = json['atk'];
    def = json['def'];
    spatk = json['spatk'];
    spdef = json['spdef'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hp'] = hp;
    data['sta'] = sta;
    data['spd'] = spd;
    data['atk'] = atk;
    data['def'] = def;
    data['spatk'] = spatk;
    data['spdef'] = spdef;
    return data;
  }
}
