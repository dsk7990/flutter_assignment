import 'package:shared_preferences/shared_preferences.dart';

class StorageUtil {
  static StorageUtil? _storageUtil;
  static SharedPreferences? _preferences;

  static Future<StorageUtil?> getInstance() async {
    if (_storageUtil == null) {
      // keep local instance till it is fully initialized.
      var secureStorage = StorageUtil._();
      await secureStorage._init();
      _storageUtil = secureStorage;
    }
    return _storageUtil;
  }

  StorageUtil._();
  Future _init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // get string
  static String getString(String key, {String defValue = ''}) {
    print(key + " <> getString");
    if (_preferences == null) {
      return defValue;
    }
    return _preferences!.getString(key) ?? defValue;
  }

  // put string
  static Future<bool> putString(String key, String value) {
    // print(key + "<>" + value);
    print(key + "<>" + value);
    return _preferences!.setString(key, value);
  }

  // get boolean
  static bool getBoolean(String key, {bool defValue = false}) {
    if (_preferences == null) return defValue;
    return _preferences!.getBool(key) ?? defValue;
  }

  // put boolean
  static Future<bool> putBoolean(String key, bool value) {
    return _preferences!.setBool(key, value);
  }

  // get int
  static int getInt(String key, {int defValue = 0}) {
    print("$defValue<>");
    if (_preferences == null) return defValue;
    return _preferences!.getInt(key) ?? defValue;
  }

  // put int
  static Future<bool> putInt(String key, int value) {
    return _preferences!.setInt(key, value);
  }
}
