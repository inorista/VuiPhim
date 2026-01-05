import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:vuiphim/core/di/locator.dart';
import 'package:vuiphim/core/services/interfaces/inetwork_service.dart';
import 'package:vuiphim/data/dtos/cast_response_dto/cast_response_dto.dart';
import 'package:vuiphim/data/dtos/genre_response_dto/genre_response_dto.dart';
import 'package:vuiphim/data/dtos/movie_detail_dto/movie_detail_dto.dart';
import 'package:vuiphim/data/dtos/movie_response_dto/movie_response_dto.dart';

// Top-level functions for parsing in a separate isolate
MovieResponseDto _parseMovieResponseDto(Map<String, dynamic> json) {
  return MovieResponseDto.fromJson(json);
}

MovieDetailDto _parseMovieDetailDto(Map<String, dynamic> json) {
  return MovieDetailDto.fromJson(json);
}

GenreResponseDto _parseGenreResponseDto(Map<String, dynamic> json) {
  return GenreResponseDto.fromJson(json);
}

CastResponseDto _parseCastResponseDto(Map<String, dynamic> json) {
  return CastResponseDto.fromJson(json);
}

@LazySingleton(as: INetworkService)
class NetworkService implements INetworkService {
  @override
  Future<MovieResponseDto> getNowPlayingMovies({
    int page = 1,
    String language = 'vi-VN',
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await getRestClient().getNowPlayingMovies(
        page: page,
        language: language,
        cancelToken: cancelToken,
      );
      return await compute(
          _parseMovieResponseDto, response as Map<String, dynamic>);
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
      final response = await getRestClient().fetchMovieDetailFromId(
        movieId,
        language: language,
        cancelToken: cancelToken,
      );
      return await compute(
          _parseMovieDetailDto, response as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<GenreResponseDto> getMovieGenres(CancelToken? cancelToken) async {
    try {
      final response =
          await getRestClient().getMovieGenres(cancelToken: cancelToken);
      return await compute(
          _parseGenreResponseDto, response as Map<String, dynamic>);
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
      final response = await getRestClient().getMoviesByGenre(
        genreId: genreId,
        page: page,
        cancelToken: cancelToken,
      );
      return await compute(
          _parseMovieResponseDto, response as Map<String, dynamic>);
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
      final response = await getRestClient().getPopularMovies(
        page: page,
        language: language,
        cancelToken: cancelToken,
      );
      return await compute(
          _parseMovieResponseDto, response as Map<String, dynamic>);
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
      final response = await getRestClient().getTopRatedMovies(
        page: page,
        language: language,
        cancelToken: cancelToken,
      );
      return await compute(
          _parseMovieResponseDto, response as Map<String, dynamic>);
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
      final response = await getRestClient().getUpcomingMovies(
        page: page,
        language: language,
        cancelToken: cancelToken,
      );
      return await compute(
          _parseMovieResponseDto, response as Map<String, dynamic>);
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
      final response = await getRestClient().fetchMovieCreditsFromId(
        movieId,
        language: language,
        cancelToken: cancelToken,
      );
      return await compute(
          _parseCastResponseDto, response as Map<String, dynamic>);
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
      final response = await getRestClient().getMovieByKeyword(
        query: keyword,
        page: page,
        language: language,
        cancelToken: cancelToken,
      );
      return await compute(
          _parseMovieResponseDto, response as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }
}
