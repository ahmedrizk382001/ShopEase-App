import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences prefs;

  static init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future<bool> setString(String key, String value) async {
    return await prefs.setString(key, value);
  }

  static Future<bool> setbool(String key, bool value) async {
    return await prefs.setBool(key, value);
  }

  static String? getString(String key) {
    return prefs.getString(key);
  }

  static bool? getBool(String key) {
    return prefs.getBool(key);
  }

  static Future<bool> removeData(String key) {
    return prefs.remove(key);
  }
}
