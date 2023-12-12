import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static late SharedPreferences _preferences;

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future setUser(String userId) async {
    await _preferences.setString('userId', userId);
  }

  static Future setPin(String userPin) async {
    await _preferences.setString('userPin', userPin);
  }

  static String? getUser() {
    return _preferences.getString('userId');
  }

  static Future getPin() async {
    return _preferences.getString('userPin');
  }

  static Future clearUser() async {
    await _preferences.remove('userId');
  }

  // Add this function to store the user's role
  static Future setUserRole(String userRole) async {
    await _preferences.setString('userRole', userRole);
  }

  // Add this function to retrieve the user's role
  static String? getUserRole() {
    return _preferences.getString('userRole');
  }
}
