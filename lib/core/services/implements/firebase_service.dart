import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vuiphim/core/constants/api_constants.dart';
import 'package:vuiphim/core/di/locator.dart';
import 'package:vuiphim/core/services/interfaces/ifirebase_service.dart';
import 'package:vuiphim/core/services/interfaces/ikeychain_storage.dart';

class FirebaseService implements IFirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<List<Map<String, dynamic>>> getDataFromCollection(
    String collectionPath,
  ) async {
    final snapshot = await _firestore.collection(collectionPath).get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  @override
  Future<Map<String, dynamic>?> getDocumentFromCollection(
    String collectionPath,
    String documentId,
  ) async {
    final snapshot = await _firestore
        .collection(collectionPath)
        .doc(documentId)
        .get();
    return snapshot.data();
  }

  @override
  Future<void> getTmdbApiKey() async {
    final data = await getDocumentFromCollection(
      ApiConstants.apiCollection,
      ApiConstants.apiDocument,
    );
    if (data != null) {
      await locator<IKeychainStorage>().saveData(
        ApiConstants.tmdbApiKey,
        data[ApiConstants.tmdbApiKey],
      );
    }
  }
}
