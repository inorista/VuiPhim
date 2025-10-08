import 'package:dio/dio.dart';
import 'package:vuiphim/core/di/locator.dart';
import 'package:vuiphim/core/services/interfaces/inetwork_service.dart';
import 'package:vuiphim/data/dtos/cast_response_dto/cast_response_dto.dart';
import 'package:vuiphim/data/dtos/genre_response_dto/genre_response_dto.dart';
import 'package:vuiphim/data/dtos/movie_detail_dto/movie_detail_dto.dart';
import 'package:vuiphim/data/dtos/movie_response_dto/movie_response_dto.dart';

class NetworkService implements INetworkService {
  @override
  Future<MovieResponseDto> getNowPlayingMovies({
    int page = 1,
    String language = 'vi-VN',
    CancelToken? cancelToken,
  }) async {
    try {
      return await getRestClient().getNowPlayingMovies(
        page: page,
        language: language,
        cancelToken: cancelToken,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<MovieDetailDto> fetchMovieDetailFromId({
    required String movieId,
    String language = 'vi-VN',
    CancelToken? cancelToken,
  }) async {
    try {
      return await getRestClient().fetchMovieDetailFromId(
        movieId,
        language: language,
        cancelToken: cancelToken,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<GenreResponseDto> getMovieGenres(CancelToken? cancelToken) async {
    try {
      return await getRestClient().getMovieGenres(cancelToken: cancelToken);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<MovieResponseDto> getMoviesByGenre({
    required int genreId,
    int page = 1,
    CancelToken? cancelToken,
  }) async {
    try {
      return await getRestClient().getMoviesByGenre(
        genreId: genreId,
        page: page,
        cancelToken: cancelToken,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<MovieResponseDto> getPopularMovies({
    int page = 1,
    String language = 'vi-VN',
    CancelToken? cancelToken,
  }) async {
    try {
      return await getRestClient().getPopularMovies(
        page: page,
        language: language,
        cancelToken: cancelToken,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<MovieResponseDto> getTopRatedMovies({
    int page = 1,
    String language = 'vi-VN',
    CancelToken? cancelToken,
  }) async {
    try {
      return await getRestClient().getTopRatedMovies(
        page: page,
        language: language,
        cancelToken: cancelToken,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<MovieResponseDto> getUpcomingMovies({
    int page = 1,
    String language = 'vi-VN',
    CancelToken? cancelToken,
  }) async {
    try {
      return await getRestClient().getUpcomingMovies(
        page: page,
        language: language,
        cancelToken: cancelToken,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<CastResponseDto> fetchMovieCreditsFromId({
    required String movieId,
    String language = 'vi-VN',
    CancelToken? cancelToken,
  }) async {
    try {
      return await getRestClient().fetchMovieCreditsFromId(
        movieId,
        language: language,
        cancelToken: cancelToken,
      );
    } catch (e) {
      rethrow;
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
      final movieDto = await getRestClient().getMovieByKeyword(
        query: keyword,
        page: page,
        language: language,
        cancelToken: cancelToken,
      );
      return movieDto;
    } catch (e) {
      rethrow;
    }
  }
}
