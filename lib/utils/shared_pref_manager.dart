import 'dart:async';
import 'dart:core';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefManager {
  SharedPreferences _sharedPreferences = null;

  Future<SharedPreferences> getSharedPref() async {
    if (_sharedPreferences == null) {
      _sharedPreferences = await SharedPreferences.getInstance();
    }
    return _sharedPreferences;
  }

  Future<bool> setValue(String key, String value) async {
    return _sharedPreferences.setString(key, value);
  }

  Future<String> getValue(String key) async {
    return _sharedPreferences.getString(key);
  }

  Future<bool> removeAll() async {
    return _sharedPreferences.clear();
  }
}