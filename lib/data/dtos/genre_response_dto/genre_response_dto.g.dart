// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'genre_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenreResponseDto _$GenreResponseDtoFromJson(Map<String, dynamic> json) =>
    GenreResponseDto(
      genres: (json['genres'] as List<dynamic>)
          .map((e) => GenreDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GenreResponseDtoToJson(GenreResponseDto instance) =>
    <String, dynamic>{
      'genres': instance.genres,
    };
