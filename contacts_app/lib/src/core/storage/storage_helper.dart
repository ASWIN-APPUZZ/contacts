import 'package:contacts_app/src/core/storage/storage_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageHelper {
  Future<String?> readData(StorageKeys key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString(key.name);
    return data;
  }

  writeData(StorageKeys key, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key.name, value);
  }

  Future<String?> clearAllData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
