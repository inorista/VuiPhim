import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:vuiphim/core/services/interfaces/ikeychain_storage_service.dart';

class KeychainStorageService implements IKeychainStorageService {
  static const storage = FlutterSecureStorage();

  @override
  Future<void> saveData(String key, String value) async {
    await storage.write(key: key, value: value);
  }

  @override
  Future<String?> getData(String key) async {
    return await storage.read(key: key);
  }

  @override
  Future<void> deleteData(String key) async {
    await storage.delete(key: key);
  }
}
