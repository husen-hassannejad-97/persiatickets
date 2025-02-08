import 'package:json_annotation/json_annotation.dart';

import '../../base/base_dto.dart';

part 'ad_response_dto.g.dart';

@JsonSerializable()
class AdResponseDto implements BaseDto {
  final String title;
  final String description;
  @JsonKey(name: 'media_urls')
  final List<String> mediaUrls;
  final int priority;
  @JsonKey(name: 'page_location')
  final String pageLocation;
  @JsonKey(name: 'ad_type')
  final String adType;
  final String link;
  @JsonKey(name: 'link_title')
  final String linkTitle;
  @JsonKey(name: 'media_thumbnail')
  final String? mediaThumbnail;
  @JsonKey(name: 'media_logo')
  final String? mediaLogo;
  @JsonKey(name: 'media_type')
  final String? mediaType;
  final String? logo;
  final int id;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  AdResponseDto({
    required this.title,
    required this.description,
    required this.mediaUrls,
    required this.priority,
    required this.pageLocation,
    required this.adType,
    required this.link,
    required this.linkTitle,
    this.mediaThumbnail,
    this.mediaLogo,
    this.mediaType,
    this.logo,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AdResponseDto.fromJson(Map<String, dynamic> json) => _$AdResponseDtoFromJson(json);
  Map<String, dynamic> toJson() => _$AdResponseDtoToJson(this);
}