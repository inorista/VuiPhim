// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'genre_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenreDto _$GenreDtoFromJson(Map<String, dynamic> json) => GenreDto(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
    );

Map<String, dynamic> _$GenreDtoToJson(GenreDto instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
