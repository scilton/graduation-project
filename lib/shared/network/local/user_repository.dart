import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {

  static Future<void> saveUserRole({required String role}) async {
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();

    await sharedPreferences.setString('role', role);
  }
  static Future<void> deleteUserRole() async {
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();

    await sharedPreferences.remove('role');
  }
  static Future<String?> getUserRole() async {
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();

    return sharedPreferences.getString('role');
  }

  UserRepository();
}