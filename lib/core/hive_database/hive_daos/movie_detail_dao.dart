import 'package:vuiphim/core/hive_database/hive_daos/base_dao.dart';
import 'package:vuiphim/core/hive_database/hive_entities/movie_detail_entity/movie_detail_entity.dart';

class MovieDetailDao extends BaseDao<MovieDetailEntity> {
  MovieDetailDao() : super('movie_details');
}
