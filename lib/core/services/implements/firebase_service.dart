import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:vuiphim/core/constants/api_constants.dart';
import 'package:vuiphim/core/di/locator.dart';
import 'package:vuiphim/core/services/interfaces/ifirebase_service.dart';
import 'package:vuiphim/core/services/interfaces/ikeychain_storage_service.dart';

@LazySingleton(as: IFirebaseService)
class FirebaseService implements IFirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final IKeychainStorageService _keychainStorageService =
      locator<IKeychainStorageService>();

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
  Future<String?> getTmdbApiKey() async {
    final data = await getDocumentFromCollection(
      ApiConstants.collectionPath,
      ApiConstants.documentPath,
    );
    if (data != null) {
      await _keychainStorageService.saveData(
        ApiConstants.tmdbKey,
        data[ApiConstants.tmdbKey],
      );
    }
    return data?[ApiConstants.tmdbKey];
  }
}
