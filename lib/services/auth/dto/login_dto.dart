import 'package:json_annotation/json_annotation.dart';

import '../../base/base_dto.dart';
import '../../shared_dto/device_info_dto.dart';

part 'login_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class LoginDto implements BaseDto {
  @JsonKey(name: 'contact_info')
  final String contactInfo;

  @JsonKey(name: 'contact_type')
  final String contactType;

  final String password;

  @JsonKey(name: 'remember_me')
  final bool rememberMe;

  final DeviceInfoDto device;

  LoginDto({
    required this.contactInfo,
    required this.contactType,
    required this.password,
    required this.rememberMe,
    required this.device,
  });

  // Generated methods
  factory LoginDto.fromJson(Map<String, dynamic> json) =>
      _$LoginDtoFromJson(json);

  Map<String, dynamic> toJson() => _$LoginDtoToJson(this);
}