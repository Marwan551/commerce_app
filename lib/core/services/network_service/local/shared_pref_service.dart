import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefKeys {
  static const String user = 'user';
  static const String token = 'token';
}

class SharedPrefHelper {
  SharedPrefHelper._();
  static final SharedPrefHelper _instance = SharedPrefHelper._();
  factory SharedPrefHelper() => _instance;

  static late SharedPreferences _sharedPreferences;

  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> setData(String key, dynamic value) async {
    if (value is String) {
      await _sharedPreferences.setString(key, value);
    } else if (value is int) {
      await _sharedPreferences.setInt(key, value);
    } else if (value is bool) {
      await _sharedPreferences.setBool(key, value);
    } else if (value is double) {
      await _sharedPreferences.setDouble(key, value);
    } else if (value is Map<String, dynamic>) {
      await _sharedPreferences.setString(key, jsonEncode(value));
    }
  }

  dynamic getData(String key) {
    return _sharedPreferences.get(key);
  }

  Map<String, dynamic>? getMap(String key) {
    final data = _sharedPreferences.getString(key);
    if (data != null) {
      return jsonDecode(data) as Map<String, dynamic>;
    }
    return null;
  }

  Future<void> removeData(String key) async {
    await _sharedPreferences.remove(key);
  }

  Future<void> clearAllData() async {
    await _sharedPreferences.clear();
  }
}
