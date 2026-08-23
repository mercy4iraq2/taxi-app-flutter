import 'package:shared_preferences/shared_preferences.dart';

class SecureStorageService {
  static final SecureStorageService _instance = SecureStorageService._internal();
  late SharedPreferences _prefs;
  bool _initialized = false;

  factory SecureStorageService() {
    return _instance;
  }

  SecureStorageService._internal();

  // Initialize shared preferences
  Future<void> init() async {
    if (!_initialized) {
      _prefs = await SharedPreferences.getInstance();
      _initialized = true;
    }
  }

  // Save string value
  Future<bool> saveString(String key, String value) async {
    return await _prefs.setString(key, value);
  }

  // Get string value
  String? getString(String key) {
    return _prefs.getString(key);
  }

  // Save boolean value
  Future<bool> saveBoolean(String key, bool value) async {
    return await _prefs.setBool(key, value);
  }

  // Get boolean value
  bool? getBoolean(String key) {
    return _prefs.getBool(key);
  }

  // Save integer value
  Future<bool> saveInteger(String key, int value) async {
    return await _prefs.setInt(key, value);
  }

  // Get integer value
  int? getInteger(String key) {
    return _prefs.getInt(key);
  }

  // Remove value
  Future<bool> remove(String key) async {
    return await _prefs.remove(key);
  }

  // Clear all
  Future<bool> clearAll() async {
    return await _prefs.clear();
  }

  // Check if key exists
  bool containsKey(String key) {
    return _prefs.containsKey(key);
  }
}
