// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ad_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdResponseDto _$AdResponseDtoFromJson(Map<String, dynamic> json) =>
    AdResponseDto(
      title: json['title'] as String,
      description: json['description'] as String,
      mediaUrls: (json['media_urls'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      priority: (json['priority'] as num).toInt(),
      pageLocation: json['page_location'] as String,
      adType: json['ad_type'] as String,
      link: json['link'] as String,
      linkTitle: json['link_title'] as String,
      mediaThumbnail: json['media_thumbnail'] as String?,
      mediaLogo: json['media_logo'] as String?,
      mediaType: json['media_type'] as String?,
      logo: json['logo'] as String?,
      id: (json['id'] as num).toInt(),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$AdResponseDtoToJson(AdResponseDto instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'media_urls': instance.mediaUrls,
      'priority': instance.priority,
      'page_location': instance.pageLocation,
      'ad_type': instance.adType,
      'link': instance.link,
      'link_title': instance.linkTitle,
      'media_thumbnail': instance.mediaThumbnail,
      'media_logo': instance.mediaLogo,
      'media_type': instance.mediaType,
      'logo': instance.logo,
      'id': instance.id,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };
