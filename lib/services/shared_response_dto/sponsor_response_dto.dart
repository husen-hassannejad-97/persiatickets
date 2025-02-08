import 'package:billit_now/services/base/base_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sponsor_response_dto.g.dart';

@JsonSerializable()
class SponsorResponseDto implements BaseDto {
  final int id;
  final String name;
  @JsonKey(name: 'logo_url')
  final String? logoUrl;
  final String? website;
  final String? description;

  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  SponsorResponseDto({
    required this.id,
    required this.name,
    required this.logoUrl,
    required this.website,
    required this.description,
    required this.createdAt,
    required this.updatedAt
  });

  @factoryMethod
  factory SponsorResponseDto.fromJson(Map<String, dynamic> json) => _$SponsorResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SponsorResponseDtoToJson(this);
}