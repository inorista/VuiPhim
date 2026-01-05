import 'package:injectable/injectable.dart';
import 'package:vuiphim/core/di/locator.dart';
import 'package:vuiphim/core/services/interfaces/iepisode_service.dart';
import 'package:vuiphim/core/utils/extensions.dart';
import 'package:vuiphim/data/hive_database/hive_daos/episode_dao.dart'
    show EpisodeDao;
import 'package:vuiphim/data/hive_database/hive_entities/episode_entity/episode_entity.dart'
    show EpisodeEntity;

@LazySingleton(as: IEpisodeService)
class EpisodeService implements IEpisodeService {
  final _episodeDao = locator<EpisodeDao>();
  @override
  Future<List<EpisodeEntity>> getEpisodesByMovieId(int movieId) async {
    final allEpisodes = await _episodeDao.getAll();
    return allEpisodes.where((episode) => episode.movieId == movieId).toList();
  }

  @override
  Future<void> saveEpisodes(List<EpisodeEntity> episodes) async {
    final episodeMap = {for (var episode in episodes) episode.id: episode};
    await _episodeDao.updateAll(episodeMap);
  }

  @override
  Future<EpisodeEntity?> getEpisodeById(String episodeId) async {
    final allEpisodes = await _episodeDao.getAll();
    return allEpisodes.firstOrDefault((episode) => episode.id == episodeId);
  }
}
