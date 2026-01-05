import 'package:vuiphim/data/hive_database/hive_daos/base_dao.dart';
import 'package:injectable/injectable.dart';
import 'package:vuiphim/data/hive_database/hive_entities/episode_entity/episode_entity.dart';

@LazySingleton()
class EpisodeDao extends BaseDao<EpisodeEntity> {
  EpisodeDao() : super('episodes');
}
