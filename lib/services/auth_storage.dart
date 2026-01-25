import 'package:shared_preferences/shared_preferences.dart';

class AuthStorage {
  static Future<void> saveUser(String userId, String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("user_id", userId);
    await prefs.setString("username", username);
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey("user_id");
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
