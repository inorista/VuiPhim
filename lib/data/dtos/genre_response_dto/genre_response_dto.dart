import 'package:json_annotation/json_annotation.dart';
import 'package:vuiphim/data/dtos/genre_dto/genre_dto.dart';
part 'genre_response_dto.g.dart';

@JsonSerializable()
class GenreResponseDto {
  List<GenreDto> genres;

  GenreResponseDto({required this.genres});

  factory GenreResponseDto.fromJson(Map<String, dynamic> json) =>
      _$GenreResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GenreResponseDtoToJson(this);
}
