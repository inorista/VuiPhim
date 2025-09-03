import 'package:vuiphim/core/hive_database/hive_entities/move_entity/movie_entity.dart';

abstract class IMovieService {
  Future<List<MovieEntity>> getAllMovies();
  Future<MovieEntity?> getMovieById(String id);
  Future<void> addMovie(MovieEntity movie);
  Future<void> updateMovie(MovieEntity movie);
  Future<void> deleteMovie(String id);
}
