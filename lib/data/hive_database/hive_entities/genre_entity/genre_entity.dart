import 'package:equatable/equatable.dart';
import 'package:hive_ce/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vuiphim/data/hive_database/hive_database.dart';

part 'genre_entity.g.dart';

@HiveType(typeId: HiveBoxIds.genreBoxId)
@JsonSerializable()
class GenreEntity extends Equatable {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;

  const GenreEntity({required this.id, required this.name});

  factory GenreEntity.fromJson(Map<String, dynamic> json) =>
      _$GenreEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GenreEntityToJson(this);

  @override
  List<Object?> get props => [id, name];
}
