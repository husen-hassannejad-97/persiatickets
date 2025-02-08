import 'package:json_annotation/json_annotation.dart';

import '../../base/base_dto.dart';
import '../../shared_dto/device_info_dto.dart';

part 'verify_code_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class VerifyCodeDto implements BaseDto {
  @JsonKey(name: 'contact_info')
  final String contactInfo;

  @JsonKey(name: 'contact_type')
  final String contactType;

  final String? username;
  final String? phone;
  final String? email;
  final DeviceInfoDto device;

  final String code;

  VerifyCodeDto({
    required this.contactInfo,
    required this.contactType,
    this.username,
    this.phone,
    this.email,
    required this.device,
    required this.code,
  });

  // Generated methods
  factory VerifyCodeDto.fromJson(Map<String, dynamic> json) =>
      _$VerifyCodeDtoFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyCodeDtoToJson(this);
}