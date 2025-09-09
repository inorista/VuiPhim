import 'package:vuiphim/core/dtos/cast_response_dto/cast_response_dto.dart';
import 'package:vuiphim/core/dtos/movie_detail_dto/movie_detail_dto.dart';
import 'package:vuiphim/core/dtos/movie_response_dto/movie_response_dto.dart';
import 'package:vuiphim/core/hive_database/hive_entities/move_entity/movie_entity.dart';

abstract class IMovieService {
  Future<List<MovieEntity>> getAllMovies();
  Future<MovieEntity?> getMovieById(int id);
  Future<void> addMovie(MovieEntity movie);
  Future<void> updateMovie(MovieEntity movie);
  Future<void> deleteMovie(String id);

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
}
