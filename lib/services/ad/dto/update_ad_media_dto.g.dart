// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_ad_media_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateAdMediaDto _$UpdateAdMediaDtoFromJson(Map<String, dynamic> json) =>
    UpdateAdMediaDto(
      mediaFile: json['media_file'] as String,
      mediaThumbnail: json['media_thumbnail'] as String,
      mediaLogo: json['media_logo'] as String,
      logo: json['logo'] as String,
    );

Map<String, dynamic> _$UpdateAdMediaDtoToJson(UpdateAdMediaDto instance) =>
    <String, dynamic>{
      'media_file': instance.mediaFile,
      'media_thumbnail': instance.mediaThumbnail,
      'media_logo': instance.mediaLogo,
      'logo': instance.logo,
    };
