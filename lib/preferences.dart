import 'package:shared_preferences/shared_preferences.dart';

class preferences{

  static SharedPreferences ? prefs;

  static Future init() async =>
      prefs = await SharedPreferences.getInstance();

  static Future setToken(String token) async =>
      await prefs?.setString('token', token);

  static String getToken() =>
      prefs?.getString('token') ?? 'Invalid token!';

  static Future setUserId(int userId) async =>
      await prefs?.setInt('userId', userId);

  static int getUserId() =>
      prefs?.getInt('userId') ?? 1;

  static Future setUsername(String username) async =>
      await prefs?.setString('username', username);

  static String getUsername() =>
      prefs?.getString('username') ?? 'username';

  static Future setFirstName(String firstName) async =>
      await prefs?.setString('firstName', firstName);

  static String getFirstName() =>
      prefs?.getString('firstName') ?? 'firstName';

  static Future setLastName(String lastName) async =>
      await prefs?.setString('lastName', lastName);

  static String getLastName() =>
      prefs?.getString('lastName') ?? 'lastName';

  static Future setEmail(String email) async =>
      await prefs?.setString('email', email);

  static String getEmail() =>
      prefs?.getString('email') ?? 'email';

}