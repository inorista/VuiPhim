import 'package:dio/dio.dart';
import 'package:vuiphim/data/dtos/cast_response_dto/cast_response_dto.dart';
import 'package:vuiphim/data/dtos/movie_detail_dto/movie_detail_dto.dart';
import 'package:vuiphim/data/dtos/movie_response_dto/movie_response_dto.dart';
import 'package:vuiphim/data/hive_database/hive_entities/move_entity/movie_entity.dart';

abstract class IMovieService {
  Future<List<MovieEntity>> getAllMovies();
  Future<MovieEntity?> getMovieById(int id);

  // FETCH MOVIE FROM SERVER
  Future<MovieResponseDto> getPopularMovies({
    int page = 1,
    String language = 'vi-VN',
  });

  Future<MovieResponseDto> getTopRatedMovies({
    int page = 1,
    String language = 'vi-VN',
  });

  Future<MovieResponseDto> getUpcomingMovies({
    int page = 1,
    String language = 'vi-VN',
  });

  Future<MovieDetailDto?> fetchMovieDetailFromId(
    String movieId, {
    String language = 'vi-VN',
  });

  Future<CastResponseDto?> fetchMovieCreditsFromId(
    String movieId, {
    String language = 'vi-VN',
  });

  Future<MovieResponseDto> searchMovieByKeyword(
    String keyword, {
    int page = 1,
    String language = 'vi-VN',
    CancelToken? cancelToken,
  });

  Future<MovieResponseDto> getNowPlayingMovies({
    int page = 1,
    String language = 'vi-VN',
    CancelToken? cancelToken,
  });
}
