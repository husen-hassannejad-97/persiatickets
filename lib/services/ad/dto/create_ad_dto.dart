import 'package:json_annotation/json_annotation.dart';

import '../../base/base_dto.dart';

part 'create_ad_dto.g.dart';

@JsonSerializable()
class CreateAdDto implements BaseDto {
  final String title;
  final String description;
  final int priority;
  @JsonKey(name: 'page_location')
  final String pageLocation;
  @JsonKey(name: 'ad_type')
  final String adType;
  final String link;
  @JsonKey(name: 'link_title')
  final String linkTitle;

  CreateAdDto({
    required this.title,
    required this.description,
    required this.priority,
    required this.pageLocation,
    required this.adType,
    required this.link,
    required this.linkTitle,
  });

  factory CreateAdDto.fromJson(Map<String, dynamic> json) => _$CreateAdDtoFromJson(json);
  Map<String, dynamic> toJson() => _$CreateAdDtoToJson(this);
}