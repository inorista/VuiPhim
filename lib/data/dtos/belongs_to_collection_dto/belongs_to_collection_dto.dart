import 'package:json_annotation/json_annotation.dart';

part 'belongs_to_collection_dto.g.dart';

@JsonSerializable()
class BelongsToCollectionDto {
  final int id;
  final String name;
  @JsonKey(name: 'poster_path')
  final String? posterPath;
  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;

  BelongsToCollectionDto({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.backdropPath,
  });

  factory BelongsToCollectionDto.fromJson(Map<String, dynamic> json) =>
      _$BelongsToCollectionDtoFromJson(json);

  Map<String, dynamic> toJson() => _$BelongsToCollectionDtoToJson(this);
}
