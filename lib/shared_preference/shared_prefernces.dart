import 'dart:convert';

import 'package:dakshattendance/const/global.dart';

class SharedPref {
  var _prefs;

  static Future save(String key, value) async {
    try {
      return PrefObj.preferences!.put(key, json.encode(value));
    } catch (e) {
      return null;
    }
  }

  static Future read(String key) async {
    try {
      return PrefObj.preferences!.containsKey(key)
          ? json.decode(PrefObj.preferences!.get(key))
          : null;
    } catch (e) {
      return null;
    }
  }

  static Future remove(String key) async {
    return PrefObj.preferences!.delete(key);
  }
}
