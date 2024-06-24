import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const authKey = 'kAuth';

  static String? jwt;

  static Future<String?> init() async {
    final prefs = await SharedPreferences.getInstance();
    jwt = prefs.getString(authKey);
    return jwt;
  }

  static Future<String?> saveJwt(String jwt) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(authKey, jwt);
    return jwt;
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(authKey);
  }
}
