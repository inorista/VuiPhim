import 'package:injectable/injectable.dart';
import 'package:vuiphim/core/di/locator.dart';
import 'package:vuiphim/core/services/interfaces/iserver_data_service.dart';
import 'package:vuiphim/data/hive_database/hive_daos/server_data_dao.dart';
import 'package:vuiphim/data/hive_database/hive_entities/server_data_entity/server_data_entity.dart';

@LazySingleton()
class ServerDataService implements IServerDataService {
  final _serverDataDao = locator<ServerDataDao>();

  @override
  Future<ServerDataEntity?> getServerDataById(String id) {
    return _serverDataDao.getServerDataById(id);
  }

  @override
  Future<void> updateServerData(String id, ServerDataEntity serverData) {
    return _serverDataDao.update(id, serverData);
  }
}
