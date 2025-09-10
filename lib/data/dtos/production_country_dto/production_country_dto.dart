import 'package:json_annotation/json_annotation.dart';

part 'production_country_dto.g.dart';

@JsonSerializable()
class ProductionCountryDto {
  @JsonKey(name: 'iso_3166_1')
  final String iso31661;
  final String name;

  ProductionCountryDto({required this.iso31661, required this.name});

  factory ProductionCountryDto.fromJson(Map<String, dynamic> json) =>
      _$ProductionCountryDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProductionCountryDtoToJson(this);
}
