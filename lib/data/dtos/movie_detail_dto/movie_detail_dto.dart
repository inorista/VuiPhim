import 'package:json_annotation/json_annotation.dart';
import 'package:vuiphim/data/dtos/belongs_to_collection_dto/belongs_to_collection_dto.dart';
import 'package:vuiphim/data/dtos/genre_dto/genre_dto.dart';
import 'package:vuiphim/data/dtos/production_company_dto/production_company_dto.dart';
import 'package:vuiphim/data/dtos/production_country_dto/production_country_dto.dart';
import 'package:vuiphim/data/dtos/spoken_language_dto/spoken_language_dto.dart';

part 'movie_detail_dto.g.dart';

@JsonSerializable()
class MovieDetailDto {
  final bool adult;
  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;
  @JsonKey(name: 'belongs_to_collection')
  final BelongsToCollectionDto? belongsToCollection;
  final int budget;
  final List<GenreDto> genres;
  final String homepage;
  final int id;
  @JsonKey(name: 'imdb_id')
  final String? imdbId;
  @JsonKey(name: 'origin_country')
  final List<String> originCountry;
  @JsonKey(name: 'original_language')
  final String originalLanguage;
  @JsonKey(name: 'original_title')
  final String originalTitle;
  final String overview;
  final double popularity;
  @JsonKey(name: 'poster_path')
  final String? posterPath;
  @JsonKey(name: 'production_companies')
  final List<ProductionCompanyDto> productionCompanies;
  @JsonKey(name: 'production_countries')
  final List<ProductionCountryDto> productionCountries;
  @JsonKey(name: 'release_date')
  final String releaseDate;
  final int revenue;
  final int runtime;
  @JsonKey(name: 'spoken_languages')
  final List<SpokenLanguageDto> spokenLanguages;
  final String status;
  final String tagline;
  final String title;
  final bool video;
  @JsonKey(name: 'vote_average')
  final double voteAverage;
  @JsonKey(name: 'vote_count')
  final int voteCount;

  MovieDetailDto({
    required this.adult,
    required this.backdropPath,
    required this.belongsToCollection,
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
    required this.productionCompanies,
    required this.productionCountries,
    required this.releaseDate,
    required this.revenue,
    required this.runtime,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory MovieDetailDto.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDetailDtoToJson(this);
}
