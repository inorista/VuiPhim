import 'package:get_it/get_it.dart';
import 'package:vuiphim/core/services/implements/firebase_service.dart';
import 'package:vuiphim/core/services/implements/keychain_storage.dart';
import 'package:vuiphim/core/services/implements/movie_service.dart';
import 'package:vuiphim/core/services/interfaces/ifirebase_service.dart';
import 'package:vuiphim/core/services/interfaces/ikeychain_storage.dart';
import 'package:vuiphim/core/services/interfaces/imovie_service.dart'
    show IMovieService;

final locator = GetIt.instance;

class EnvironmentLocator {
  static Future<void> initLocator() async {
    locator.registerLazySingleton<IKeychainStorage>(() => KeychainStorage());
    locator.registerLazySingleton<IMovieService>(() => MovieService());
    locator.registerLazySingleton<IFirebaseService>(() => FirebaseService());
  }
}
