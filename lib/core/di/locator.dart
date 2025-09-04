import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:vuiphim/core/resources/rest_client.dart';
import 'package:vuiphim/core/services/implements/firebase_service.dart';
import 'package:vuiphim/core/services/implements/keychain_storage_service.dart';
import 'package:vuiphim/core/services/implements/movie_service.dart';
import 'package:vuiphim/core/services/interfaces/ifirebase_service.dart';
import 'package:vuiphim/core/services/interfaces/ikeychain_storage_service.dart';
import 'package:vuiphim/core/services/interfaces/imovie_service.dart'
    show IMovieService;

final locator = GetIt.instance;
final Dio dio = Dio();

class EnvironmentLocator {
  static Future<void> initLocator() async {
    locator.registerLazySingleton<RestClient>(() => RestClient(dio));
    locator.registerLazySingleton<IKeychainStorageService>(
      () => KeychainStorageService(),
    );
    locator.registerLazySingleton<IMovieService>(() => MovieService());
    locator.registerLazySingleton<IFirebaseService>(() => FirebaseService());
  }
}
