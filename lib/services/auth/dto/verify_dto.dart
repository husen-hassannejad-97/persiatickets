import 'package:json_annotation/json_annotation.dart';

import '../../base/base_dto.dart';

part 'verify_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class VerifyDto implements BaseDto {
  @JsonKey(name: 'contact_info')
  final String contactInfo;

  @JsonKey(name: 'contact_type')
  final String contactType;

  final String code;

  VerifyDto({
    required this.contactInfo,
    required this.contactType,
    required this.code,
  });

  // Generated methods
  factory VerifyDto.fromJson(Map<String, dynamic> json) =>
      _$VerifyDtoFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyDtoToJson(this);
}