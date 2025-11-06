// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cast_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CastResponseDto _$CastResponseDtoFromJson(Map<String, dynamic> json) =>
    CastResponseDto(
      id: (json['id'] as num).toInt(),
      cast: (json['cast'] as List<dynamic>)
          .map((e) => CastDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CastResponseDtoToJson(CastResponseDto instance) =>
    <String, dynamic>{'id': instance.id, 'cast': instance.cast};
