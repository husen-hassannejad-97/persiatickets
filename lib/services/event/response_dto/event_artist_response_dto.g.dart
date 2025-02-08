// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_artist_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventArtistResponseDto _$EventArtistResponseDtoFromJson(
        Map<String, dynamic> json) =>
    EventArtistResponseDto(
      id: (json['id'] as num).toInt(),
      eventId: (json['event_id'] as num).toInt(),
      stateName: json['stage_name'] as String,
      realName: json['real_name'] as String?,
      nationality: json['nationality'] as String?,
      birthDate: json['birth_date'] == null
          ? null
          : DateTime.parse(json['birth_date'] as String),
      deathDate: json['death_date'] == null
          ? null
          : DateTime.parse(json['death_date'] as String),
      shortBio: json['short_bio'] as String?,
      fullBio: json['full_bio'] as String?,
      imageKey: json['image_key'] as String?,
      imageUrl: json['image_url'] as String?,
      gallery:
          (json['gallery'] as List<dynamic>?)?.map((e) => e as String).toList(),
      socialLinks: (json['social_links'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      genres:
          (json['genres'] as List<dynamic>?)?.map((e) => e as String).toList(),
      awards:
          (json['awards'] as List<dynamic>?)?.map((e) => e as String).toList(),
      isActive: json['is_active'] as bool,
      artistId: (json['artist_id'] as num).toInt(),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$EventArtistResponseDtoToJson(
        EventArtistResponseDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'event_id': instance.eventId,
      'artist_id': instance.artistId,
      'stage_name': instance.stateName,
      'real_name': instance.realName,
      'nationality': instance.nationality,
      'birth_date': instance.birthDate?.toIso8601String(),
      'death_date': instance.deathDate?.toIso8601String(),
      'short_bio': instance.shortBio,
      'full_bio': instance.fullBio,
      'image_key': instance.imageKey,
      'image_url': instance.imageUrl,
      'gallery': instance.gallery,
      'social_links': instance.socialLinks,
      'genres': instance.genres,
      'awards': instance.awards,
      'is_active': instance.isActive,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };
