import 'package:shared_preferences/shared_preferences.dart';

final class SharedPreferencesService {
  Future<String?> getString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<bool?> setString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
  }

  Future<bool?> getBool(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  Future<bool?> setBool(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setBool(key, value);
  }
}
