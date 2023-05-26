import 'dart:convert';

import 'base_network.dart';

class ApiDataSource {
  static ApiDataSource instance = ApiDataSource();

  var character;

  Future<List<dynamic>> loadChara() {
    return BaseNetwork.getList("characters");
    // "https://api.genshin.dev/characters"
  }

  Future<Map<String, dynamic>> loadDetailChara(String name) {
    return BaseNetwork.get("characters/$name");
    // "https://api.genshin.dev/characters/albedo"
  }

  Future<List<dynamic>> loadWeapon() {
    return BaseNetwork.getList("weapons");
    // "https://api.genshin.dev/weapons"
  }

  Future<Map<String, dynamic>> loadDetailWeapon(String name) {
    return BaseNetwork.get("weapons/$name"); // get api pizza
    // "https://api.genshin.dev/weapons/alley-hunter"
  }
}