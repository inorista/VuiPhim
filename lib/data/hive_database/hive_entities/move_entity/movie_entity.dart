import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vuiphim/data/dtos/movie_dto/movie_dto.dart';
import 'package:vuiphim/data/hive_database/hive_database.dart';
import 'package:vuiphim/core/utils/enum.dart';

part 'movie_entity.g.dart';

@HiveType(typeId: HiveBoxIds.movieBoxId)
@JsonSerializable()
class MovieEntity extends Equatable {
  @HiveField(0)
  final bool adult;
  @HiveField(1)
  @JsonKey(name: 'backdrop_path')
  final String backdropPath;
  @HiveField(2)
  @JsonKey(name: 'genre_ids')
  final List<int> genreIds;
  @HiveField(3)
  final int id;
  @HiveField(4)
  @JsonKey(name: 'original_language')
  final String originalLanguage;
  @HiveField(5)
  @JsonKey(name: 'original_title')
  final String originalTitle;
  @HiveField(6)
  final String overview;
  @HiveField(7)
  final double popularity;
  @HiveField(8)
  @JsonKey(name: 'poster_path')
  final String posterPath;
  @HiveField(9)
  @JsonKey(name: 'release_date')
  final String releaseDate;
  @HiveField(10)
  final String title;
  @HiveField(11)
  final bool video;
  @HiveField(12)
  @JsonKey(name: 'vote_average')
  final double voteAverage;
  @HiveField(13)
  @JsonKey(name: 'vote_count')
  final int voteCount;
  @HiveField(14)
  final MovieCategory? category;

  const MovieEntity({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
    this.category,
  });

  factory MovieEntity.fromJson(Map<String, dynamic> json) =>
      _$MovieEntityFromJson(json);

  Map<String, dynamic> toJson() => _$MovieEntityToJson(this);

  String get posterUrl => 'https://image.tmdb.org/t/p/original$posterPath';
  String get backdropUrl => 'https://image.tmdb.org/t/p/original$backdropPath';

  factory MovieEntity.fromDto(MovieDto dto, {MovieCategory? category}) {
    return MovieEntity(
      adult: dto.adult,
      backdropPath: dto.backdropPath ?? '',
      genreIds: dto.genreIds,
      id: dto.id,
      originalLanguage: dto.originalLanguage,
      originalTitle: dto.originalTitle,
      overview: dto.overview,
      popularity: dto.popularity,
      posterPath: dto.posterPath ?? '',
      releaseDate: dto.releaseDate,
      title: dto.title,
      video: dto.video,
      voteAverage: dto.voteAverage,
      voteCount: dto.voteCount,
      category: category,
    );
  }

  @override
  List<Object?> get props => [
    adult,
    backdropPath,
    genreIds,
    id,
    originalLanguage,
    originalTitle,
    overview,
    popularity,
    posterPath,
    releaseDate,
    title,
    video,
    voteAverage,
    voteCount,
    category,
  ];
}
