import 'package:hive_ce/hive.dart';
import 'package:vuiphim/data/hive_database/hive_database.dart';

part 'tmdb_entity.g.dart';

@HiveType(typeId: HiveBoxIds.tmdbBoxId)
class TmdbEntity {
  @HiveField(0)
  final String? type;
  @HiveField(1)
  final String? id;
  @HiveField(2)
  final dynamic season;
  @HiveField(3)
  final double? voteAverage;
  @HiveField(4)
  final int? voteCount;

  TmdbEntity({
    required this.type,
    required this.id,
    required this.season,
    required this.voteAverage,
    required this.voteCount,
  });
}
