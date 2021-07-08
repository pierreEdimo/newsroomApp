import 'package:newsroom/main.dart';

class StorageManager {
  static void saveData(String key, String value) async {
    await storage.write(key: key, value: value);
  }

  static Future<dynamic> readData(String key) async {
    var keys = await storage.read(key: key);
    return keys;
  }
}
