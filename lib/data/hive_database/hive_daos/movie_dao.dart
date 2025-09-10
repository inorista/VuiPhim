import 'package:vuiphim/data/hive_database/hive_entities/move_entity/movie_entity.dart';
import 'package:vuiphim/data/hive_database/hive_daos/base_dao.dart';

class MovieDao extends BaseDao<MovieEntity> {
  MovieDao() : super('movies');
}
