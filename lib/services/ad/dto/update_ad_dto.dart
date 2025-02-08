import 'package:json_annotation/json_annotation.dart';

import '../../base/base_dto.dart';

part 'update_ad_dto.g.dart';

@JsonSerializable()
class UpdateAdDto implements BaseDto {
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
  final String mediaThumbnail;
  @JsonKey(name: 'media_logo')
  final String mediaLogo;
  final String logo;

  UpdateAdDto({
    required this.title,
    required this.description,
    required this.mediaUrls,
    required this.priority,
    required this.pageLocation,
    required this.adType,
    required this.link,
    required this.linkTitle,
    required this.mediaThumbnail,
    required this.mediaLogo,
    required this.logo,
  });

  factory UpdateAdDto.fromJson(Map<String, dynamic> json) => _$UpdateAdDtoFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateAdDtoToJson(this);
}