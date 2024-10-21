import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static const String _isLoggedInKey = 'isLoggedIn';
  static const String _loginExpiryKey = 'loginExpiry';

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  Future<void> setLoggedIn(bool value, {DateTime? expiryTime}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, value);
    if (expiryTime != null) {
      await prefs.setString(_loginExpiryKey, expiryTime.toIso8601String());
    }
  }

  Future<bool> isLoginExpired() async {
    final prefs = await SharedPreferences.getInstance();
    final expiryString = prefs.getString(_loginExpiryKey);
    if (expiryString == null) return true; // Default to expired if not set
    final expiryTime = DateTime.parse(expiryString);
    return DateTime.now().isAfter(expiryTime);
  }
}
