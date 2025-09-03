import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cast_entity.g.dart';

@HiveType(typeId: 2)
@JsonSerializable()
class CastEntity extends Equatable {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String character;
  @HiveField(3)
  @JsonKey(name: 'profile_path')
  final String? profilePath;

  const CastEntity({
    required this.id,
    required this.name,
    required this.character,
    this.profilePath,
  });

  factory CastEntity.fromJson(Map<String, dynamic> json) =>
      _$CastEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CastEntityToJson(this);

  @override
  List<Object?> get props => [id, name, character, profilePath];
}
