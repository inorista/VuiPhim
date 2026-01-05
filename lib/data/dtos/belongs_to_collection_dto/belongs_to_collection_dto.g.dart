// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'belongs_to_collection_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BelongsToCollectionDto _$BelongsToCollectionDtoFromJson(
  Map<String, dynamic> json,
) => BelongsToCollectionDto(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  posterPath: json['poster_path'] as String?,
  backdropPath: json['backdrop_path'] as String?,
);

Map<String, dynamic> _$BelongsToCollectionDtoToJson(
  BelongsToCollectionDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'poster_path': instance.posterPath,
  'backdrop_path': instance.backdropPath,
};
