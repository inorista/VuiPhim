import 'package:json_annotation/json_annotation.dart';
import 'package:vuiphim/core/hive_database/hive_entities/genre_entity/genre_entity.dart';
part 'genre_dto.g.dart';

@JsonSerializable()
class GenreDto {
  final int id;
  final String name;

  GenreDto({required this.id, required this.name});

  factory GenreDto.fromJson(Map<String, dynamic> json) =>
      _$GenreDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GenreDtoToJson(this);

  GenreEntity toEntity() {
    return GenreEntity(id: id, name: name);
  }
}
