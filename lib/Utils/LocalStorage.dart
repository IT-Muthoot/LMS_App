import 'package:shared_preferences/shared_preferences.dart';

class LocalStore {
  saveData(String key, dynamic value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(key, value.toString());
  }

  dynamic get(key) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(key) ?? "";
  }

  static clearAll() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.clear();
  }
}
