import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import 'package:vuiphim/data/hive_database/hive_database.dart';
import 'package:vuiphim/data/hive_database/hive_entities/server_data_entity/server_data_entity.dart';

part 'episode_entity.g.dart';

@HiveType(typeId: HiveBoxIds.episodeBoxId)
class EpisodeEntity {
  @HiveField(0)
  final String? serverName;
  @HiveField(1)
  final String id;
  @HiveField(2)
  final int movieId;

  EpisodeEntity({required this.serverName, required this.movieId, String? id})
    : id = id ?? const Uuid().v4();
}
