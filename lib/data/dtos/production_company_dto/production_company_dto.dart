import 'package:json_annotation/json_annotation.dart';

part 'production_company_dto.g.dart';

@JsonSerializable()
class ProductionCompanyDto {
  final int id;
  @JsonKey(name: 'logo_path')
  final String? logoPath;
  final String name;
  @JsonKey(name: 'origin_country')
  final String originCountry;

  ProductionCompanyDto({
    required this.id,
    required this.logoPath,
    required this.name,
    required this.originCountry,
  });

  factory ProductionCompanyDto.fromJson(Map<String, dynamic> json) =>
      _$ProductionCompanyDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProductionCompanyDtoToJson(this);
}
