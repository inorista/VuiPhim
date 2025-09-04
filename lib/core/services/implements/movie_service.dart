import 'package:vuiphim/core/hive_database/hive_entities/move_entity/movie_entity.dart';
import 'package:vuiphim/core/services/interfaces/imovie_service.dart';

class MovieService implements IMovieService {
  @override
  Future<List<MovieEntity>> getAllMovies() async {
    // TODO: Implement getAllMovies
    throw UnimplementedError();
  }

  @override
  Future<MovieEntity?> getMovieById(String id) async {
    // TODO: Implement getMovieById
    throw UnimplementedError();
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
}
