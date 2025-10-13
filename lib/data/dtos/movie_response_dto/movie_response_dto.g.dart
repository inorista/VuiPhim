// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieResponseDto _$MovieResponseDtoFromJson(Map<String, dynamic> json) =>
    MovieResponseDto(
      page: (json['page'] as num).toInt(),
      results: (json['results'] as List<dynamic>)
          .map((e) => MovieDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPages: (json['total_pages'] as num).toInt(),
      totalResults: (json['total_results'] as num).toInt(),
    );

Map<String, dynamic> _$MovieResponseDtoToJson(MovieResponseDto instance) =>
    <String, dynamic>{
      'page': instance.page,
      'results': instance.results,
      'total_pages': instance.totalPages,
      'total_results': instance.totalResults,
    };
