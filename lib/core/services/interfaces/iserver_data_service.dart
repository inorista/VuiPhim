import 'package:vuiphim/data/hive_database/hive_entities/server_data_entity/server_data_entity.dart';

abstract class IServerDataService {
  Future<ServerDataEntity?> getServerDataById(String id);
  Future<void> updateServerData(String id, ServerDataEntity serverData);
}
