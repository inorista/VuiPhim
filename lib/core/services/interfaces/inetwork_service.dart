import 'package:dio/dio.dart';
import 'package:vuiphim/data/dtos/cast_response_dto/cast_response_dto.dart';
import 'package:vuiphim/data/dtos/genre_response_dto/genre_response_dto.dart';
import 'package:vuiphim/data/dtos/movie_detail_dto/movie_detail_dto.dart';
import 'package:vuiphim/data/dtos/movie_response_dto/movie_response_dto.dart';

abstract class INetworkService {
  Future<MovieResponseDto> getNowPlayingMovies({
    int page = 1,
    String language = 'vi-VN',
    CancelToken? cancelToken,
  });
  Future<GenreResponseDto> getMovieGenres(CancelToken? cancelToken);
  Future<MovieResponseDto> getMoviesByGenre({
    required int genreId,
    int page = 1,
    CancelToken? cancelToken,
  });

  Future<MovieResponseDto> getPopularMovies({
    int page = 1,
    String language = 'vi-VN',
    CancelToken? cancelToken,
  });
  Future<MovieResponseDto> getTopRatedMovies({
    int page = 1,
    String language = 'vi-VN',
    CancelToken? cancelToken,
  });
  Future<MovieResponseDto> getUpcomingMovies({
    int page = 1,
    String language = 'vi-VN',
    CancelToken? cancelToken,
  });
  Future<MovieDetailDto> fetchMovieDetailFromId({
    required String movieId,
    String language = 'vi-VN',
    CancelToken? cancelToken,
  });

  Future<CastResponseDto> fetchMovieCreditsFromId({
    required String movieId,
    String language = 'vi-VN',
    CancelToken? cancelToken,
  });

  Future<MovieResponseDto> searchMovieByKeyword(
    String keyword, {
    int page = 1,
    String language = 'vi-VN',
    CancelToken? cancelToken,
  });
}
