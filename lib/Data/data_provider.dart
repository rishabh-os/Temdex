import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import 'package:temtem_wiki/Data/TechniqueData.dart';
import 'package:temtem_wiki/Data/TemtemData.dart';
import 'package:temtem_wiki/Data/TraitData.dart';

class TemtemNotifier extends StateNotifier<List<Temtem>> {
  TemtemNotifier() : super([]);

  void getData() async {
    Response response;
    response = await get(Uri.parse('https://temtem-api.mael.tech/api/temtems'));

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      List<Temtem> y = data.map((e) => Temtem.fromJson(e)).toList();
      state = y;
    } else {
      throw Exception();
    }
  }
}

final temtemProvider =
    StateNotifierProvider<TemtemNotifier, List<Temtem>>((ref) {
  return TemtemNotifier();
});

class TraitNotifier extends StateNotifier<List<Trait>> {
  TraitNotifier() : super([]);

  void getData() async {
    Response response;
    response = await get(Uri.parse('https://temtem-api.mael.tech/api/traits'));

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      List<Trait> y = data.map((e) => Trait.fromJson(e)).toList();
      state = y;
    } else {
      throw Exception();
    }
  }
}

final traitProvider = StateNotifierProvider<TraitNotifier, List<Trait>>((ref) {
  return TraitNotifier();
});

class TechniqueNotifier extends StateNotifier<List<TechniqueData>> {
  TechniqueNotifier() : super([]);

  void getData() async {
    Response response;
    response =
        await get(Uri.parse('https://temtem-api.mael.tech/api/techniques'));
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      List<TechniqueData> y =
          data.map((e) => TechniqueData.fromJson(e)).toList();
      state = y;
    } else {
      throw Exception();
    }
  }
}

final techniqueProvider =
    StateNotifierProvider<TechniqueNotifier, List<TechniqueData>>((ref) {
  return TechniqueNotifier();
});

final profileImageProvider = StateProvider<String>((ref) {
  // ? This implementation seems a bit janky as I have to update the value twice but it works for now so /shruggie
  final box = GetStorage();

  if (box.read("profiletype") == null) {
    box.write("profiletype", "Stickers");
  }
  String ppvalue = box.read("profiletype");
  return ppvalue;
});
