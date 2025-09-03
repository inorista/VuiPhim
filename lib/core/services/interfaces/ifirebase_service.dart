abstract class IFirebaseService {
  Future<List<Map<String, dynamic>>> getDataFromCollection(
    String collectionPath,
  );
  Future<Map<String, dynamic>?> getDocumentFromCollection(
    String collectionPath,
    String documentId,
  );
  Future<void> getTmdbApiKey();
}
