import 'package:shared_preferences/shared_preferences.dart';
import 'utils.dart';

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
      await prefs?.setString('username', capitalize(username));

  static String getUsername() =>
      prefs?.getString('username') ?? 'username';

  static Future setFirstName(String firstName) async =>
      await prefs?.setString('firstName', capitalize(firstName));

  static String getFirstName() =>
      prefs?.getString('firstName') ?? 'firstName';

  static Future setLastName(String lastName) async =>
      await prefs?.setString('lastName', capitalize(lastName));

  static String getLastName() =>
      prefs?.getString('lastName') ?? 'lastName';

  static Future setEmail(String email) async =>
      await prefs?.setString('email', email);

  static String getEmail() =>
      prefs?.getString('email') ?? 'email';

  static Future setTelephone(String telephone) async =>
      await prefs?.setString('telephone', telephone);

  static String getTelephone() =>
      prefs?.getString('telephone') ?? '999000123';

  static Future setSubscribers(int subscribers) async =>
      await prefs?.setInt('subscribers', subscribers);

  static int getSubscribers() =>
      prefs?.getInt('subscribers') ?? 1;

  static Future setSubscriptions(int subscriptions) async =>
      await prefs?.setInt('subscriptions', subscriptions);

  static int getSubscriptions() =>
      prefs?.getInt('subscriptions') ?? 1;

}