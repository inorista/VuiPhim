import 'package:injectable/injectable.dart';
import 'package:vuiphim/core/di/locator.dart';
import 'package:vuiphim/core/services/interfaces/iepisode_service.dart';
import 'package:vuiphim/core/services/interfaces/imovie_service.dart';
import 'package:vuiphim/core/services/interfaces/iserver_data_service.dart';
import 'package:vuiphim/core/utils/extensions.dart';
import 'package:vuiphim/data/hive_database/hive_daos/server_data_dao.dart';
import 'package:vuiphim/data/hive_database/hive_entities/move_entity/movie_entity.dart';
import 'package:vuiphim/data/hive_database/hive_entities/server_data_entity/server_data_entity.dart';

@LazySingleton(as: IServerDataService)
class ServerDataService implements IServerDataService {
  final _serverDataDao = locator<ServerDataDao>();
  final _movieService = locator<IMovieService>();
  final _episodeService = locator<IEpisodeService>();

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

  @override
  Future<List<ServerDataEntity>> getContinueWatchingList() async {
    return await _serverDataDao.getContinueWatchingList();
  }

  @override
  Future<MovieEntity?> getMovieByEpisodeId(String episodeId) async {
    final episode = await _episodeService.getEpisodeById(episodeId);
    return episode == null
        ? null
        : await _movieService.getMovieById(episode.movieId);
  }
}
