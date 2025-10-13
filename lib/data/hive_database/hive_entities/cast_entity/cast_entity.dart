import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vuiphim/data/hive_database/hive_database.dart';

part 'cast_entity.g.dart';

@HiveType(typeId: HiveBoxIds.castBoxId)
@JsonSerializable()
class CastEntity extends Equatable {
  @HiveField(0)
  final bool adult;
  @HiveField(1)
  final int gender;
  @HiveField(2)
  final int id;
  @HiveField(3)
  @JsonKey(name: 'known_for_department')
  final String knownForDepartment;
  @HiveField(4)
  final String name;
  @HiveField(5)
  @JsonKey(name: 'original_name')
  final String originalName;
  @HiveField(6)
  final double popularity;
  @HiveField(7)
  @JsonKey(name: 'cast_id')
  final int? castId;
  @HiveField(8)
  final String? character;
  @HiveField(9)
  @JsonKey(name: 'profile_path')
  final String? profilePath;
  @HiveField(10)
  @JsonKey(name: 'credit_id')
  final String creditId;
  @HiveField(11)
  final int? order;
  @HiveField(12)
  final String? department;
  @HiveField(13)
  final String? job;

  const CastEntity({
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

  String get fullProfilePath =>
      'https://image.tmdb.org/t/p/w500${profilePath ?? ''}';

  factory CastEntity.fromJson(Map<String, dynamic> json) =>
      _$CastEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CastEntityToJson(this);

  @override
  List<Object?> get props => [
    adult,
    gender,
    id,
    knownForDepartment,
    name,
    originalName,
    popularity,
    castId,
    character,
    profilePath,
    creditId,
    order,
    department,
    job,
  ];
}
