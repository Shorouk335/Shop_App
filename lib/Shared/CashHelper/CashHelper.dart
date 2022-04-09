
import 'package:shared_preferences/shared_preferences.dart';

class CashHelper {
  static SharedPreferences? sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> savebool({
    required String key,
    required bool value,
  }) async {
    return await sharedPreferences!.setBool(key, value);
  }
  static Future<bool> saveString({
    required String key,
    required String value,
  }) async {
    return await sharedPreferences!.setString(key, value);
  }


  static dynamic getDate({
    required String key,
  }) async {
    return await sharedPreferences!.get(key)  ;
  }

  static Future<bool> removeDate({
    required String key,
  }) async {
    return await sharedPreferences!.remove(key);
  }
}
