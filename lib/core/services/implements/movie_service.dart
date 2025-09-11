import 'package:vuiphim/core/di/locator.dart';
import 'package:vuiphim/core/utils/extensions.dart';
import 'package:vuiphim/data/dtos/cast_response_dto/cast_response_dto.dart';
import 'package:vuiphim/data/dtos/movie_detail_dto/movie_detail_dto.dart';
import 'package:vuiphim/data/dtos/movie_response_dto/movie_response_dto.dart';
import 'package:vuiphim/data/hive_database/hive_daos/movie_dao.dart';
import 'package:vuiphim/data/hive_database/hive_entities/move_entity/movie_entity.dart';
import 'package:vuiphim/core/services/interfaces/imovie_service.dart';
import 'package:dio/dio.dart';

class MovieService implements IMovieService {
  final _movieDao = locator<MovieDao>();

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
  Future<void> addMovie(MovieEntity movie) async {
    // TODO: Implement addMovie
    throw UnimplementedError();
  }

  @override
  Future<void> updateMovie(MovieEntity movie) async {
    // TODO: Implement updateMovie
    throw UnimplementedError();
  }

  @override
  Future<void> deleteMovie(String id) async {
    // TODO: Implement deleteMovie
    throw UnimplementedError();
  }

  @override
  Future<MovieResponseDto> getPopularMovies({
    int page = 1,
    String language = 'vi-VN',
  }) async {
    CancelToken cancelToken = CancelToken();
    final movieDto = await getRestClient().getPopularMovies(
      page: page,
      language: language,
      cancelToken: cancelToken,
    );
    return movieDto;
  }

  @override
  Future<MovieResponseDto> getTopRatedMovies({
    int page = 1,
    String language = 'vi-VN',
  }) async {
    CancelToken cancelToken = CancelToken();
    final movieDto = await getRestClient().getTopRatedMovies(
      page: page,
      language: language,
      cancelToken: cancelToken,
    );
    return movieDto;
  }

  @override
  Future<MovieResponseDto> getUpcomingMovies({
    int page = 1,
    String language = 'vi-VN',
  }) async {
    CancelToken cancelToken = CancelToken();
    final movieDto = await getRestClient().getUpcomingMovies(
      page: page,
      language: language,
      cancelToken: cancelToken,
    );
    return movieDto;
  }

  @override
  Future<MovieDetailDto?> fetchMovieDetailFromId(
    String movieId, {
    String language = 'vi-VN',
  }) async {
    CancelToken cancelToken = CancelToken();
    try {
      final movieDetailDto = await getRestClient().fetchMovieDetailFromId(
        movieId,
        language: language,
        cancelToken: cancelToken,
      );
      return movieDetailDto;
    } catch (e) {
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
      final castDto = await getRestClient().fetchMovieCreditsFromId(
        movieId,
        language: language,
        cancelToken: cancelToken,
      );
      return castDto;
    } catch (e) {
      return null;
    }
  }
}
