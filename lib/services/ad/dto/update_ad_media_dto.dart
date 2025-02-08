import 'package:json_annotation/json_annotation.dart';

import '../../base/base_dto.dart';

part 'update_ad_media_dto.g.dart';

@JsonSerializable()
class UpdateAdMediaDto implements BaseDto {
  @JsonKey(name: 'media_file')
  final String mediaFile;
  @JsonKey(name: 'media_thumbnail')
  final String mediaThumbnail;
  @JsonKey(name: 'media_logo')
  final String mediaLogo;
  final String logo;

  UpdateAdMediaDto({
    required this.mediaFile,
    required this.mediaThumbnail,
    required this.mediaLogo,
    required this.logo,
  });

  factory UpdateAdMediaDto.fromJson(Map<String, dynamic> json) => _$UpdateAdMediaDtoFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateAdMediaDtoToJson(this);
}