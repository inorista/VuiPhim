import 'package:injectable/injectable.dart';
import 'package:vuiphim/core/di/locator.dart';
import 'package:vuiphim/core/services/interfaces/iepisode_service.dart';
import 'package:vuiphim/core/services/interfaces/inetwork_service.dart';
import 'package:vuiphim/core/utils/extensions.dart';
import 'package:vuiphim/data/dtos/cast_response_dto/cast_response_dto.dart';
import 'package:vuiphim/data/dtos/movie_detail_dto/movie_detail_dto.dart';
import 'package:vuiphim/data/dtos/movie_response_dto/movie_response_dto.dart';
import 'package:vuiphim/data/hive_database/hive_daos/movie_dao.dart';
import 'package:vuiphim/data/hive_database/hive_daos/server_data_dao.dart';
import 'package:vuiphim/data/hive_database/hive_entities/move_entity/movie_entity.dart';
import 'package:vuiphim/core/services/interfaces/imovie_service.dart';
import 'package:dio/dio.dart';
import 'package:vuiphim/data/hive_database/hive_entities/server_data_entity/server_data_entity.dart';

@LazySingleton(as: IMovieService)
class MovieService implements IMovieService {
  final _movieDao = locator<MovieDao>();
  final _networkService = locator<INetworkService>();
  final _serverDataDao = locator<ServerDataDao>();
  final _episodeService = locator<IEpisodeService>();

  @override
  Future<List<MovieEntity>> getAllMovies() async {
    return _movieDao.getAll();
  }

  @override
  Future<MovieEntity?> getMovieById(int id) async {
    final movieList = await _movieDao.getAll();
    if (movieList.isNotEmpty) {
      return movieList.firstOrDefault((movie) => movie.id == id);
    }
    return null;
  }

  @override
  Future<MovieResponseDto> getPopularMovies({
    int page = 1,
    String language = 'vi-VN',
  }) async {
    CancelToken cancelToken = CancelToken();
    try {
      final movieDto = await _networkService.getPopularMovies(
        page: page,
        language: language,
        cancelToken: cancelToken,
      );
      return movieDto;
    } catch (e) {
      cancelToken.cancel();
      rethrow;
    }
  }

  @override
  Future<MovieResponseDto> getTopRatedMovies({
    int page = 1,
    String language = 'vi-VN',
  }) async {
    CancelToken cancelToken = CancelToken();
    try {
      final movieDto = await _networkService.getTopRatedMovies(
        page: page,
        cancelToken: cancelToken,
      );

      return movieDto;
    } catch (e) {
      cancelToken.cancel();
      rethrow;
    }
  }

  @override
  Future<MovieResponseDto> getUpcomingMovies({
    int page = 1,
    String language = 'vi-VN',
  }) async {
    CancelToken cancelToken = CancelToken();
    try {
      final movieDto = await _networkService.getUpcomingMovies(
        page: page,
        cancelToken: cancelToken,
      );

      return movieDto;
    } catch (e) {
      cancelToken.cancel();
      rethrow;
    }
  }

  @override
  Future<MovieDetailDto?> fetchMovieDetailFromId(
    String movieId, {
    String language = 'vi-VN',
  }) async {
    CancelToken cancelToken = CancelToken();
    try {
      final movieDetailDto = await _networkService.fetchMovieDetailFromId(
        movieId: movieId,
        cancelToken: cancelToken,
      );
      return movieDetailDto;
    } catch (e) {
      cancelToken.cancel();
      return null;
    }
  }

  @override
  Future<CastResponseDto?> fetchMovieCreditsFromId(
    String movieId, {
    String language = 'vi-VN',
  }) async {
    CancelToken cancelToken = CancelToken();
    try {
      final castDto = await _networkService.fetchMovieCreditsFromId(
        movieId: movieId,
        language: 'vi-VN',
        cancelToken: cancelToken,
      );
      return castDto;
    } catch (e) {
      cancelToken.cancel();
      return null;
    }
  }

  @override
  Future<MovieResponseDto> searchMovieByKeyword(
    String keyword, {
    int page = 1,
    String language = 'vi-VN',
    CancelToken? cancelToken,
  }) async {
    try {
      return await _networkService.searchMovieByKeyword(
        keyword,
        page: page,
        language: language,
        cancelToken: cancelToken,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<MovieResponseDto> getNowPlayingMovies({
    int page = 1,
    String language = 'vi-VN',
    CancelToken? cancelToken,
  }) async {
    try {
      return await _networkService.getNowPlayingMovies(
        page: page,
        language: language,
        cancelToken: cancelToken,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<MovieEntity, List<ServerDataEntity>>> getDownloadedMovies() async {
    final downloadedServerDatas = await _serverDataDao
        .getDownloadedServerDatas();

    if (downloadedServerDatas.isEmpty) {
      return {};
    } else {
      final Map<MovieEntity, List<ServerDataEntity>> downloadedMoviesMap = {};

      for (var serverData in downloadedServerDatas) {
        final episodeEntity = await _episodeService.getEpisodeById(
          serverData.episodeId ?? '',
        );
        if (episodeEntity == null) continue;
        final movieEntity = await getMovieById(episodeEntity.movieId);
        if (movieEntity == null) continue;
        if (downloadedMoviesMap.containsKey(movieEntity)) {
          downloadedMoviesMap[movieEntity]!.add(serverData);
        } else {
          downloadedMoviesMap[movieEntity] = [serverData];
        }
      }

      return downloadedMoviesMap;
    }
  }
}
