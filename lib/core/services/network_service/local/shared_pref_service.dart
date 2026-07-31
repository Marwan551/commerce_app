import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  static late SharedPreferences _sharedPreferences;

  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<void> setData(String key, dynamic value) async {
    if (value is String) {
      await _sharedPreferences.setString(key, value);
    } else if (value is int) {
      await _sharedPreferences.setInt(key, value);
    } else if (value is bool) {
      await _sharedPreferences.setBool(key, value);
    } else if (value is double) {
      await _sharedPreferences.setDouble(key, value);
    }
  }

  static dynamic getData(String key) {
    return _sharedPreferences.get(key);
  }

  static Future<void> removeData(String key) async {
    await _sharedPreferences.remove(key);
  }

  static Future<void> clearAllData() async {
    await _sharedPreferences.clear();
  }
}
