import 'package:vuiphim/data/hive_database/hive_entities/episode_entity/episode_entity.dart';
import 'package:vuiphim/data/hive_database/hive_entities/server_data_entity/server_data_entity.dart';

class EpisodeUIModel {
  final EpisodeEntity episode;
  final List<ServerDataEntity> serverDatas;

  EpisodeUIModel({required this.episode, required this.serverDatas});
}
