import 'package:vuiphim/core/utils/extensions.dart';
import 'package:vuiphim/data/hive_database/hive_daos/base_dao.dart';
import 'package:vuiphim/data/hive_database/hive_entities/movie_detail_entity/movie_detail_entity.dart';

class MovieDetailDao extends BaseDao<MovieDetailEntity> {
  MovieDetailDao() : super('movie_details');

  Future<MovieDetailEntity?> getMovieDetailById(int movieId) async {
    final allMovieDetails = await getAll();
    return allMovieDetails.firstOrDefault((detail) => detail.id == movieId);
  }
}
