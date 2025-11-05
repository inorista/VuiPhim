import 'package:injectable/injectable.dart';
import 'package:vuiphim/core/di/locator.dart';
import 'package:vuiphim/core/services/interfaces/iserver_data_service.dart';
import 'package:vuiphim/data/hive_database/hive_daos/server_data_dao.dart';
import 'package:vuiphim/data/hive_database/hive_entities/server_data_entity/server_data_entity.dart';

@LazySingleton(as: IServerDataService)
class ServerDataService implements IServerDataService {
  final _serverDataDao = locator<ServerDataDao>();

  @override
  Future<ServerDataEntity?> getServerDataById(String id) async {
    return await _serverDataDao.getServerDataById(id);
  }

  @override
  Future<List<ServerDataEntity>> getServerDataByEpisodeId(
    String episodeId,
  ) async {
    return await _serverDataDao.getServerDataByEpisodeId(episodeId);
  }

  @override
  Future<void> saveServerData(List<ServerDataEntity> serverData) async {
    await _serverDataDao.saveServerData(serverData);
  }

  @override
  Future<void> updateServerData(String id, ServerDataEntity serverData) async {
    await _serverDataDao.update(id, serverData);
  }
}
