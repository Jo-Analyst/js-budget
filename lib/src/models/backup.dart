import 'dart:io';

import 'package:js_budget/src/utils/path.dart';

class Backup {
  static Future<String?> toGenerate() async {
    try {
      File ourDbFile = File(pathDatabase);

      Directory? folderPathForDbFile = Directory(directory);
      await folderPathForDbFile.create();
      await ourDbFile.copy(pathStorageDatabase);
    } catch (e) {
      return e.toString();
    }
    return null;
  }

  static Future<String?> restore(String filePath) async {
    try {
      File saveDBFile = File(filePath);

      await saveDBFile.copy(pathDatabase);
    } catch (e) {
      return e.toString();
    }
    return null;
  }
}
