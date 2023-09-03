import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  late SharedPreferences _pref;

  SharedPref() {
    initialize();
  }

  Future<void> initialize() async {
    _pref = await SharedPreferences.getInstance();
  }

  Future<bool> setBool({required String key, required bool value}) =>
      _pref.setBool(key, value);

  bool? getBool(String key) => _pref.getBool(key);

  Future<bool> setInt({required String key, required int value}) =>
      _pref.setInt(key, value);

  int? getInt(String key) => _pref.getInt(key);
}
