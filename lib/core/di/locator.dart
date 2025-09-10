import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:vuiphim/core/constants/api_constants.dart';
import 'package:vuiphim/data/hive_database/hive_daos/cast_dao.dart';
import 'package:vuiphim/data/hive_database/hive_daos/genre_dao.dart';
import 'package:vuiphim/data/hive_database/hive_daos/movie_dao.dart';
import 'package:vuiphim/data/hive_database/hive_daos/movie_detail_dao.dart';
import 'package:vuiphim/core/resources/rest_client.dart';
import 'package:vuiphim/core/services/implements/background_sync.dart';
import 'package:vuiphim/core/services/implements/firebase_service.dart';
import 'package:vuiphim/core/services/implements/keychain_storage_service.dart';
import 'package:vuiphim/core/services/implements/movie_service.dart';
import 'package:vuiphim/core/services/interfaces/ibackground_sync.dart';
import 'package:vuiphim/core/services/interfaces/ifirebase_service.dart';
import 'package:vuiphim/core/services/interfaces/ikeychain_storage_service.dart';
import 'package:vuiphim/core/services/interfaces/imovie_service.dart'
    show IMovieService;

final locator = GetIt.instance;
final Dio dio = Dio();

class EnvironmentLocator {
  static Future<void> setupServiceLocator() async {
    // Register Services
    locator.registerLazySingleton<IKeychainStorageService>(
      () => KeychainStorageService(),
    );
    locator.registerLazySingleton<IMovieService>(() => MovieService());
    locator.registerLazySingleton<IFirebaseService>(() => FirebaseService());
    locator.registerLazySingleton<IBackgroundSync>(() => BackgroundSync());

    // Register DAOs
    locator.registerLazySingleton<MovieDao>(() => MovieDao());
    locator.registerLazySingleton<GenreDao>(() => GenreDao());
    locator.registerLazySingleton<CastDao>(() => CastDao());
    locator.registerLazySingleton<MovieDetailDao>(() => MovieDetailDao());
  }

  static Future<void> setupRestClient() async {
    // Register RestClient
    final apiKey = await locator<IKeychainStorageService>().getData(
      ApiConstants.tmdbKey,
    );

    dio.options = BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      headers: {"Authorization": "Bearer $apiKey"},
    );

    locator.registerLazySingleton<RestClient>(() => RestClient(dio));
  }
}

RestClient getRestClient() {
  return locator<RestClient>();
}
