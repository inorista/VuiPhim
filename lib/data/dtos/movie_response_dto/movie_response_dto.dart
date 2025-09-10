import 'package:json_annotation/json_annotation.dart';
import 'package:vuiphim/data/dtos/movie_dto/movie_dto.dart';
part 'movie_response_dto.g.dart';

@JsonSerializable()
class MovieResponseDto {
  final int page;
  final List<MovieDto> results;
  @JsonKey(name: 'total_pages')
  final int totalPages;
  @JsonKey(name: 'total_results')
  final int totalResults;

  MovieResponseDto({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory MovieResponseDto.fromJson(Map<String, dynamic> json) =>
      _$MovieResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MovieResponseDtoToJson(this);
}
