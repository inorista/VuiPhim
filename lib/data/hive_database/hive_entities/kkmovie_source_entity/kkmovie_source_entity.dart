import 'package:hive/hive.dart';
import 'package:vuiphim/data/hive_database/hive_database.dart';
import 'package:vuiphim/data/hive_database/hive_entities/episode_entity/episode_entity.dart';
import 'package:vuiphim/data/hive_database/hive_entities/kkmovie_movie_entity/kkmovie_movie_entity.dart';
import 'package:vuiphim/data/hive_database/hive_entities/move_entity/movie_entity.dart';

part 'kkmovie_source_entity.g.dart';

@HiveType(typeId: HiveBoxIds.kkMovieSourceBoxId)
class KkMovieSourceEntity {
  @HiveField(0)
  final bool? status;
  @HiveField(1)
  final String? msg;
  @HiveField(2)
  final KkMovieMovieEntity? movie;
  @HiveField(3)
  final List<EpisodeEntity> episodes;

  KkMovieSourceEntity({
    required this.status,
    required this.msg,
    required this.movie,
    required this.episodes,
  });
}
