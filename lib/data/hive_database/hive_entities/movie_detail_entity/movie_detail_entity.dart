import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:vuiphim/data/dtos/movie_detail_dto/movie_detail_dto.dart';
import 'package:vuiphim/data/hive_database/hive_database.dart';
import 'package:vuiphim/data/hive_database/hive_entities/genre_entity/genre_entity.dart';
part 'movie_detail_entity.g.dart';

@HiveType(typeId: HiveBoxIds.movieDetailBoxId)
class MovieDetailEntity extends Equatable {
  @HiveField(0)
  final bool adult;
  @HiveField(1)
  final String? backdropPath;
  @HiveField(2)
  final int budget;
  @HiveField(3)
  final List<GenreEntity> genres;
  @HiveField(4)
  final String homepage;
  @HiveField(5)
  final int id;
  @HiveField(6)
  final String? imdbId;
  @HiveField(7)
  final List<String> originCountry;
  @HiveField(8)
  final String originalLanguage;
  @HiveField(9)
  final String originalTitle;
  @HiveField(10)
  final String overview;
  @HiveField(11)
  final double popularity;
  @HiveField(12)
  final String? posterPath;
  @HiveField(13)
  final String releaseDate;
  @HiveField(14)
  final int revenue;
  @HiveField(15)
  final int runtime;
  @HiveField(16)
  final String status;
  @HiveField(17)
  final String tagline;
  @HiveField(18)
  final String title;
  @HiveField(19)
  final bool video;
  @HiveField(20)
  final double voteAverage;
  @HiveField(21)
  final int voteCount;

  const MovieDetailEntity({
    required this.adult,
    required this.backdropPath,
    required this.budget,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.imdbId,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.revenue,
    required this.runtime,
    required this.status,
    required this.tagline,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory MovieDetailEntity.fromDto(MovieDetailDto dto) {
    return MovieDetailEntity(
      adult: dto.adult,
      backdropPath: dto.backdropPath ?? '',
      budget: dto.budget,
      genres: dto.genres.map((genreDto) => genreDto.toEntity()).toList(),
      homepage: dto.homepage,
      id: dto.id,
      imdbId: dto.imdbId,
      originCountry: dto.originCountry,
      originalLanguage: dto.originalLanguage,
      originalTitle: dto.originalTitle,
      overview: dto.overview,
      popularity: dto.popularity,
      posterPath: dto.posterPath ?? '',
      releaseDate: dto.releaseDate,
      revenue: dto.revenue,
      runtime: dto.runtime,
      status: dto.status,
      tagline: dto.tagline,
      title: dto.title,
      video: dto.video,
      voteAverage: dto.voteAverage,
      voteCount: dto.voteCount,
    );
  }

  String get posterUrl => 'https://image.tmdb.org/t/p/original$posterPath';
  String get backdropUrl => 'https://image.tmdb.org/t/p/original$backdropPath';

  @override
  List<Object?> get props => [
    adult,
    backdropPath,
    budget,
    genres,
    homepage,
    id,
    imdbId,
    originCountry,
    originalLanguage,
    originalTitle,
    overview,
    popularity,
    posterPath,
    releaseDate,
    revenue,
    runtime,
    status,
    tagline,
    title,
    video,
    voteAverage,
    voteCount,
  ];
}
