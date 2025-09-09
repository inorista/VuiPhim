import 'package:json_annotation/json_annotation.dart';
import 'package:vuiphim/core/hive_database/hive_entities/cast_entity/cast_entity.dart';

part 'cast_dto.g.dart';

@JsonSerializable()
class CastDto {
  final bool adult;
  final int gender;
  final int id;
  @JsonKey(name: 'known_for_department')
  final String knownForDepartment;
  final String name;
  @JsonKey(name: 'original_name')
  final String originalName;
  final double popularity;
  @JsonKey(name: 'cast_id')
  final int? castId;
  final String? character;
  @JsonKey(name: 'profile_path')
  final String? profilePath;
  @JsonKey(name: 'credit_id')
  final String creditId;
  final int? order;
  final String? department;
  final String? job;

  CastDto({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    this.castId,
    this.character,
    this.profilePath,
    required this.creditId,
    this.order,
    this.department,
    this.job,
  });

  factory CastDto.fromJson(Map<String, dynamic> json) =>
      _$CastDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CastDtoToJson(this);

  CastEntity toEntity() => CastEntity(
    adult: adult,
    gender: gender,
    id: id,
    knownForDepartment: knownForDepartment,
    name: name,
    originalName: originalName,
    popularity: popularity,
    castId: castId,
    character: character,
    profilePath: profilePath,
    creditId: creditId,
    order: order,
    department: department,
    job: job,
  );
}
