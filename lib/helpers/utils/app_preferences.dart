import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  // Method to save a string value in shared preferences
  Future<void> saveString(String key, String value) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString(key, value);
  }

  // Method to retrieve a string value from shared preferences
  Future<String?> getString(String key) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString(key);
  }

  // Method to save an integer value in shared preferences
  Future<void> saveInt(String key, int value) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setInt(key, value);
  }

  // Method to retrieve an integer value from shared preferences
  Future<int?> getInt(String key) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getInt(key);
  }

  // Method to save a boolean value in shared preferences
  Future<void> saveBool(String key, bool value) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setBool(key, value);
  }

  // Method to retrieve a boolean value from shared preferences
  Future<bool?> getBool(String key) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getBool(key);
  }

  // Method to remove a specific key from shared preferences
  Future<void> remove(String key) async {
    final SharedPreferences prefs = await _prefs;
    prefs.remove(key);
  }

  // Method to clear all shared preferences
  Future<void> clear() async {
    final SharedPreferences prefs = await _prefs;
    prefs.clear();
  }
}
