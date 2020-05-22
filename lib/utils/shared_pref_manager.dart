import 'dart:async';
import 'dart:core';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefManager {
  static SharedPreferences _sharedPreferences = null;

  static Future<SharedPreferences> getSharedPref() async {
    if (_sharedPreferences == null) {
      _sharedPreferences = await SharedPreferences.getInstance();
    }
    return _sharedPreferences;
  }

  static Future<bool> setValue(String key, String value) async {
    return _sharedPreferences.setString(key, value);
  }

  static Future<String> getValue(String key) async {
    return _sharedPreferences.getString(key);
  }

  static Future<bool> removeAll() async {
    return _sharedPreferences.clear();
  }
}