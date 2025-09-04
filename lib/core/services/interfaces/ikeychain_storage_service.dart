abstract class IKeychainStorageService {
  Future<void> saveData(String key, String value);
  Future<String?> getData(String key);
  Future<void> deleteData(String key);
}
