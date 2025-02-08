// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_ad_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateAdDto _$UpdateAdDtoFromJson(Map<String, dynamic> json) => UpdateAdDto(
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
      mediaThumbnail: json['media_thumbnail'] as String,
      mediaLogo: json['media_logo'] as String,
      logo: json['logo'] as String,
    );

Map<String, dynamic> _$UpdateAdDtoToJson(UpdateAdDto instance) =>
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
      'logo': instance.logo,
    };
