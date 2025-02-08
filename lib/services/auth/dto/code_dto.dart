import 'package:json_annotation/json_annotation.dart';

import '../../base/base_dto.dart';
import '../../shared_dto/device_info_dto.dart';

part 'code_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class CodeDto implements BaseDto {
  @JsonKey(name: 'contact_info')
  final String contactInfo;

  @JsonKey(name: 'contact_type')
  final String contactType;

  final String? username;
  final String? phone;
  final String? email;
  final DeviceInfoDto device;

  CodeDto({
    required this.contactInfo,
    required this.contactType,
    this.username,
    this.phone,
    this.email,
    required this.device,
  });

  // Generated methods
  factory CodeDto.fromJson(Map<String, dynamic> json) =>
      _$CodeDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CodeDtoToJson(this);
}