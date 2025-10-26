import 'package:vuiphim/core/di/locator.dart';
import 'package:vuiphim/core/services/interfaces/iepisode_service.dart';
import 'package:vuiphim/data/hive_database/hive_daos/episode_dao.dart'
    show EpisodeDao;
import 'package:vuiphim/data/hive_database/hive_entities/episode_entity/episode_entity.dart'
    show EpisodeEntity;

class EpisodeService implements IEpisodeService {
  final _episodeDao = locator<EpisodeDao>();
  @override
  Future<List<EpisodeEntity>> getEpisodesByMovieId(int movieId) async {
    final allEpisodes = await _episodeDao.getAll();
    return allEpisodes.where((episode) => episode.movieId == movieId).toList();
  }
}
