import 'package:injectable/injectable.dart';
import 'package:vuiphim/core/utils/extensions.dart';
import 'package:vuiphim/data/hive_database/hive_daos/base_dao.dart';
import 'package:vuiphim/data/hive_database/hive_entities/watching_movie_entity/watching_movie_entity.dart';

@LazySingleton()
class WatchingMovieDao extends BaseDao<WatchingMovieEntity> {
  WatchingMovieDao() : super('watching_movies');

  Future<WatchingMovieEntity?> getWatchingMovieDetailByMovieDetailId(
    int movieDetailId,
  ) async {
    final allMovieDetails = await getAll();
    return allMovieDetails.firstOrDefault(
      (detail) => detail.movieDetail.id == movieDetailId,
    );
  }
}
