import 'package:injectable/injectable.dart';
import 'package:vuiphim/core/utils/extensions.dart';
import 'package:vuiphim/data/hive_database/hive_daos/base_dao.dart';
import 'package:vuiphim/data/hive_database/hive_entities/server_data_entity/server_data_entity.dart';

@LazySingleton()
class ServerDataDao extends BaseDao<ServerDataEntity> {
  ServerDataDao() : super('server_data');

  Future<ServerDataEntity?> getServerDataById(String id) async {
    final allMovieDetails = await getAll();
    return allMovieDetails.firstOrDefault((item) => item.id == id);
  }
}
