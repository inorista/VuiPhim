import 'package:vuiphim/data/hive_database/hive_entities/cast_entity/cast_entity.dart';
import 'package:vuiphim/data/hive_database/hive_daos/base_dao.dart';

class CastDao extends BaseDao<CastEntity> {
  CastDao() : super('casts');
}
