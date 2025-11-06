import 'package:hive_ce/hive.dart';
import 'package:vuiphim/data/hive_database/hive_database.dart';
import 'package:vuiphim/data/hive_database/hive_entities/category_entity/category_entity.dart';
import 'package:vuiphim/data/hive_database/hive_entities/created_entity/created_entity.dart';
import 'package:vuiphim/data/hive_database/hive_entities/imdb_entity/imdb_entity.dart';
import 'package:vuiphim/data/hive_database/hive_entities/tmdb_entity/tmdb_entity.dart';

part 'kkmovie_movie_entity.g.dart';

@HiveType(typeId: HiveBoxIds.kkMovieMovieBoxId)
class KkMovieMovieEntity {
  @HiveField(0)
  final TmdbEntity? tmdb;
  @HiveField(1)
  final ImdbEntity? imdb;
  @HiveField(2)
  final CreatedEntity? created;
  @HiveField(3)
  final CreatedEntity? modified;
  @HiveField(4)
  final String? id;
  @HiveField(5)
  final String? name;
  @HiveField(6)
  final String? slug;
  @HiveField(7)
  final String? originName;
  @HiveField(8)
  final String? content;
  @HiveField(9)
  final String? type;
  @HiveField(10)
  final String? status;
  @HiveField(11)
  final String? posterUrl;
  @HiveField(12)
  final String? thumbUrl;
  @HiveField(13)
  final bool? isCopyright;
  @HiveField(14)
  final bool? subDocquyen;
  @HiveField(15)
  final bool? chieurap;
  @HiveField(16)
  final String? trailerUrl;
  @HiveField(17)
  final String? time;
  @HiveField(18)
  final String? episodeCurrent;
  @HiveField(19)
  final String? episodeTotal;
  @HiveField(20)
  final String? quality;
  @HiveField(21)
  final String? lang;
  @HiveField(22)
  final String? notify;
  @HiveField(23)
  final String? showtimes;
  @HiveField(24)
  final int? year;
  @HiveField(25)
  final int? view;
  @HiveField(26)
  final List<String> actor;
  @HiveField(27)
  final List<String> director;
  @HiveField(28)
  final List<CategoryEntity> category;
  @HiveField(29)
  final List<CategoryEntity> country;

  KkMovieMovieEntity({
    required this.tmdb,
    required this.imdb,
    required this.created,
    required this.modified,
    required this.id,
    required this.name,
    required this.slug,
    required this.originName,
    required this.content,
    required this.type,
    required this.status,
    required this.posterUrl,
    required this.thumbUrl,
    required this.isCopyright,
    required this.subDocquyen,
    required this.chieurap,
    required this.trailerUrl,
    required this.time,
    required this.episodeCurrent,
    required this.episodeTotal,
    required this.quality,
    required this.lang,
    required this.notify,
    required this.showtimes,
    required this.year,
    required this.view,
    required this.actor,
    required this.director,
    required this.category,
    required this.country,
  });
}
