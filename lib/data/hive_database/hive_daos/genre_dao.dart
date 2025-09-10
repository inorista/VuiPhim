import 'package:vuiphim/data/hive_database/hive_daos/base_dao.dart';
import 'package:vuiphim/data/hive_database/hive_entities/genre_entity/genre_entity.dart';

class GenreDao extends BaseDao<GenreEntity> {
  GenreDao() : super('genres');
}
