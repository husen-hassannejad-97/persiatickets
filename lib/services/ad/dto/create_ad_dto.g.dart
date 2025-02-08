// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_ad_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateAdDto _$CreateAdDtoFromJson(Map<String, dynamic> json) => CreateAdDto(
      title: json['title'] as String,
      description: json['description'] as String,
      priority: (json['priority'] as num).toInt(),
      pageLocation: json['page_location'] as String,
      adType: json['ad_type'] as String,
      link: json['link'] as String,
      linkTitle: json['link_title'] as String,
    );

Map<String, dynamic> _$CreateAdDtoToJson(CreateAdDto instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'priority': instance.priority,
      'page_location': instance.pageLocation,
      'ad_type': instance.adType,
      'link': instance.link,
      'link_title': instance.linkTitle,
    };
