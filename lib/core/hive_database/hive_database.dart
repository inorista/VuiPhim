import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class HiveDatabase {
  Future<void> setupHiveDatabase() async {
    Directory document = await getApplicationDocumentsDirectory();
    Hive.init(document.path);
  }
}
