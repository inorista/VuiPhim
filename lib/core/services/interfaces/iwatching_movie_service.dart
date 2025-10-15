import 'package:vuiphim/data/hive_database/hive_entities/watching_movie_entity/watching_movie_entity.dart';

abstract class IWatchingMovieService {
  Future<void> saveWatchingMovie(WatchingMovieEntity watchingMovie);
  Future<WatchingMovieEntity?> getWatchingMovie(int movieDetailId);
  Future<List<WatchingMovieEntity>> getAllWatchingMovies();
}
