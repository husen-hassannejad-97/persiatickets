// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sponsor_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SponsorResponseDto _$SponsorResponseDtoFromJson(Map<String, dynamic> json) =>
    SponsorResponseDto(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      logoUrl: json['logo_url'] as String?,
      website: json['website'] as String?,
      description: json['description'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$SponsorResponseDtoToJson(SponsorResponseDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'logo_url': instance.logoUrl,
      'website': instance.website,
      'description': instance.description,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };
