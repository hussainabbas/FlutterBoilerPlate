import 'dart:convert';

import 'package:manawanui/data/models/user_details_response.dart';
import 'package:manawanui/helpers/resources/app_preference_resources.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> saveUserDetails(UserDetailsResponse? userDetails) async {
    final SharedPreferences prefs = await _prefs;
    final userDetailsJson = json.encode(userDetails);
    await prefs.setString(AppPreferenceResources.USER_DETAILS, userDetailsJson);
  }

  Future<UserDetailsResponse?> getUserDetails() async {
    final SharedPreferences prefs = await _prefs;
    final userDetailsJson =
        prefs.getString(AppPreferenceResources.USER_DETAILS);
    if (userDetailsJson != null) {
      final userDetails =
          UserDetailsResponse.fromJson(json.decode(userDetailsJson));
      return userDetails;
    }

    return null; // Return null if no user details are found
  }

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
