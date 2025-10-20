import 'package:injectable/injectable.dart';
import 'package:vuiphim/core/di/locator.dart';
import 'package:vuiphim/core/services/interfaces/iwatching_movie_service.dart';
import 'package:vuiphim/data/hive_database/hive_daos/watching_movie_dao.dart';
import 'package:vuiphim/data/hive_database/hive_entities/watching_movie_entity/watching_movie_entity.dart';

@LazySingleton(as: IWatchingMovieService)
class WatchingMovieService implements IWatchingMovieService {
  final _watchingMovieDao = locator<WatchingMovieDao>();

  @override
  Future<List<WatchingMovieEntity>> getAllWatchingMovies() async {
    return await _watchingMovieDao.getAll();
  }

  @override
  Future<WatchingMovieEntity?> getWatchingMovie(int movieDetailId) async {
    final watchingMovie = await _watchingMovieDao
        .getWatchingMovieDetailByMovieDetailId(movieDetailId);
    return watchingMovie;
  }

  @override
  Future<void> saveWatchingMovie(WatchingMovieEntity watchingMovie) async {
    await _watchingMovieDao.update(watchingMovie.movieDetail.id, watchingMovie);
  }
}
