import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:vuiphim/core/constants/api_constants.dart';
import 'package:vuiphim/core/services/interfaces/ifirebase_service.dart';
import 'package:vuiphim/core/services/interfaces/ikeychain_storage_service.dart';
import 'package:vuiphim/data/resources/kkphim_rest_client.dart';
import 'package:vuiphim/data/resources/rest_client.dart';
import 'locator.config.dart';

final locator = GetIt.instance;
@InjectableInit()
Future<void> configureDependencies() async => locator.init();

@module
abstract class RegisterModule {
  @preResolve
  @Named('tmdbDio')
  Future<Dio> provideTmdbDio(
    IKeychainStorageService keychainStorageService,
  ) async {
    final dio = Dio();
    String? apiKey = await keychainStorageService.getData(ApiConstants.tmdbKey);
    apiKey ??= await locator<IFirebaseService>().getTmdbApiKey();
    dio.options = BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      headers: {"Authorization": "Bearer $apiKey"},
    );

    return dio;
  }

  @lazySingleton
  @Named('kkphimDio')
  Dio provideKkphimDio() {
    final dio = Dio();
    dio.options = BaseOptions(baseUrl: ApiConstants.kkphimBaseUrl);
    return dio;
  }

  @lazySingleton
  RestClient provideRestClient(@Named('tmdbDio') Dio dio) => RestClient(dio);

  @lazySingleton
  KKPhimRestClient provideKKPhimRestClient(@Named('kkphimDio') Dio dio) =>
      KKPhimRestClient(dio);
}

RestClient getRestClient() {
  return locator<RestClient>();
}

KKPhimRestClient getKKPhimRestClient() {
  return locator<KKPhimRestClient>();
}
