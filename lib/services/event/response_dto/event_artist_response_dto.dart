import 'package:billit_now/services/base/base_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_artist_response_dto.g.dart';

@JsonSerializable()
class EventArtistResponseDto implements BaseDto {
  final int id;
  @JsonKey(name: 'event_id')
  final int eventId;
  @JsonKey(name: 'artist_id')
  final int artistId;
  @JsonKey(name: 'stage_name')
  final String stateName;
  @JsonKey(name: 'real_name')
  final String? realName;
  final String? nationality;
  @JsonKey(name: 'birth_date')
  final DateTime? birthDate;
  @JsonKey(name: 'death_date')
  final DateTime? deathDate;
  @JsonKey(name: 'short_bio')
  final String? shortBio;
  @JsonKey(name: 'full_bio')
  final String? fullBio;
  @JsonKey(name: 'image_key')
  final String? imageKey;
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  final List<String>? gallery;
  @JsonKey(name: 'social_links')
  final Map<String, String>? socialLinks;
  final List<String>? genres;
  @JsonKey(name: 'awards')
  final List<String>? awards;
  @JsonKey(name: 'is_active')
  final bool isActive;

  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  EventArtistResponseDto({
    required this.id,
    required this.eventId,
    required this.stateName,
    required this.realName,
    required this.nationality,
    required this.birthDate,
    required this.deathDate,
    required this.shortBio,
    required this.fullBio,
    required this.imageKey,
    required this.imageUrl,
    required this.gallery,
    required this.socialLinks,
    required this.genres,
    required this.awards,
    required this.isActive,
    required this.artistId,
    required this.createdAt,
    required this.updatedAt
  });

  @factoryMethod
  factory EventArtistResponseDto.fromJson(Map<String, dynamic> json) => _$EventArtistResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$EventArtistResponseDtoToJson(this);
}