// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:vuiphim/core/di/locator.dart' as _i1062;
import 'package:vuiphim/core/services/implements/background_sync.dart' as _i768;
import 'package:vuiphim/core/services/implements/episode_service.dart' as _i125;
import 'package:vuiphim/core/services/implements/ffmpeg_service.dart' as _i141;
import 'package:vuiphim/core/services/implements/firebase_service.dart'
    as _i713;
import 'package:vuiphim/core/services/implements/genre_service.dart' as _i134;
import 'package:vuiphim/core/services/implements/keychain_storage_service.dart'
    as _i927;
import 'package:vuiphim/core/services/implements/movie_service.dart' as _i650;
import 'package:vuiphim/core/services/implements/network_service.dart' as _i422;
import 'package:vuiphim/core/services/implements/path_provider_service.dart'
    as _i162;
import 'package:vuiphim/core/services/implements/server_data_service.dart'
    as _i29;
import 'package:vuiphim/core/services/interfaces/ibackground_sync.dart'
    as _i504;
import 'package:vuiphim/core/services/interfaces/iepisode_service.dart'
    as _i597;
import 'package:vuiphim/core/services/interfaces/iffmpeg_service.dart' as _i404;
import 'package:vuiphim/core/services/interfaces/ifirebase_service.dart'
    as _i575;
import 'package:vuiphim/core/services/interfaces/igenre_service.dart' as _i1053;
import 'package:vuiphim/core/services/interfaces/ikeychain_storage_service.dart'
    as _i811;
import 'package:vuiphim/core/services/interfaces/imovie_service.dart' as _i52;
import 'package:vuiphim/core/services/interfaces/inetwork_service.dart'
    as _i479;
import 'package:vuiphim/core/services/interfaces/ipath_provider_service.dart'
    as _i537;
import 'package:vuiphim/core/services/interfaces/iserver_data_service.dart'
    as _i302;
import 'package:vuiphim/data/hive_database/hive_daos/cast_dao.dart' as _i584;
import 'package:vuiphim/data/hive_database/hive_daos/episode_dao.dart' as _i666;
import 'package:vuiphim/data/hive_database/hive_daos/genre_dao.dart' as _i190;
import 'package:vuiphim/data/hive_database/hive_daos/movie_dao.dart' as _i38;
import 'package:vuiphim/data/hive_database/hive_daos/movie_detail_dao.dart'
    as _i279;
import 'package:vuiphim/data/hive_database/hive_daos/server_data_dao.dart'
    as _i207;
import 'package:vuiphim/data/resources/kkphim_rest_client.dart' as _i605;
import 'package:vuiphim/data/resources/rest_client.dart' as _i690;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i584.CastDao>(() => _i584.CastDao());
    gh.lazySingleton<_i666.EpisodeDao>(() => _i666.EpisodeDao());
    gh.lazySingleton<_i190.GenreDao>(() => _i190.GenreDao());
    gh.lazySingleton<_i38.MovieDao>(() => _i38.MovieDao());
    gh.lazySingleton<_i279.MovieDetailDao>(() => _i279.MovieDetailDao());
    gh.lazySingleton<_i207.ServerDataDao>(() => _i207.ServerDataDao());
    gh.lazySingleton<_i479.INetworkService>(() => _i422.NetworkService());
    gh.lazySingleton<_i597.IEpisodeService>(() => _i125.EpisodeService());
    gh.lazySingleton<_i575.IFirebaseService>(() => _i713.FirebaseService());
    gh.lazySingleton<_i52.IMovieService>(() => _i650.MovieService());
    gh.lazySingleton<_i404.IFFmpegService>(() => _i141.FFmpegService());
    gh.lazySingleton<_i302.IServerDataService>(() => _i29.ServerDataService());
    gh.lazySingleton<_i504.IBackgroundSync>(() => _i768.BackgroundSync());
    gh.lazySingleton<_i811.IKeychainStorageService>(
      () => _i927.KeychainStorageService(),
    );
    gh.lazySingleton<_i1053.IGenreService>(() => _i134.GenreService());
    gh.lazySingleton<_i537.IPathProviderService>(
      () => _i162.PathProviderService(),
    );
    gh.lazySingleton<_i361.Dio>(
      () => registerModule.provideKkphimDio(),
      instanceName: 'kkphimDio',
    );
    await gh.factoryAsync<_i361.Dio>(
      () => registerModule.provideTmdbDio(gh<_i811.IKeychainStorageService>()),
      instanceName: 'tmdbDio',
      preResolve: true,
    );
    gh.lazySingleton<_i605.KKPhimRestClient>(
      () => registerModule.provideKKPhimRestClient(
        gh<_i361.Dio>(instanceName: 'kkphimDio'),
      ),
    );
    gh.lazySingleton<_i690.RestClient>(
      () => registerModule.provideRestClient(
        gh<_i361.Dio>(instanceName: 'tmdbDio'),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i1062.RegisterModule {}
