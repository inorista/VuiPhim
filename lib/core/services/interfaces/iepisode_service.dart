import 'package:vuiphim/data/hive_database/hive_entities/episode_entity/episode_entity.dart';

abstract class IEpisodeService {
  Future<List<EpisodeEntity>> getEpisodesByMovieId(int movieId);
}
