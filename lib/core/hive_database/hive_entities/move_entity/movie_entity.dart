import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie_entity.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class MovieEntity extends Equatable {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String overview;
  @HiveField(3)
  @JsonKey(name: 'release_date')
  final String releaseDate;
  @HiveField(4)
  @JsonKey(name: 'poster_path')
  final String posterPath;
  @HiveField(5)
  @JsonKey(name: 'vote_average')
  final double voteAverage;
  @HiveField(6)
  @JsonKey(name: 'backdrop_path')
  final String backdropPath;

  const MovieEntity({
    required this.id,
    required this.title,
    required this.overview,
    required this.releaseDate,
    required this.posterPath,
    required this.voteAverage,
    required this.backdropPath,
  });

  factory MovieEntity.fromJson(Map<String, dynamic> json) =>
      _$MovieEntityFromJson(json);

  Map<String, dynamic> toJson() => _$MovieEntityToJson(this);

  String get posterUrl => 'https://image.tmdb.org/t/p/w500$posterPath';
  String get backdropUrl => 'https://image.tmdb.org/t/p/w500$backdropPath';

  @override
  List<Object?> get props => [
    id,
    title,
    overview,
    releaseDate,
    posterPath,
    voteAverage,
    backdropPath,
  ];
}
