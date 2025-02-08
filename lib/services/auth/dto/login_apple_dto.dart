import 'package:json_annotation/json_annotation.dart';

import '../../base/base_dto.dart';
import '../../shared_dto/device_info_dto.dart';

part 'login_apple_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class LoginAppleDto implements BaseDto {
  @JsonKey(name: 'identity_token')
  final String identityToken;
  final DeviceInfoDto device;

  LoginAppleDto({
    required this.identityToken,
    required this.device,
  });

  // Generated methods
  factory LoginAppleDto.fromJson(Map<String, dynamic> json) =>
      _$LoginAppleDtoFromJson(json);

  Map<String, dynamic> toJson() => _$LoginAppleDtoToJson(this);
}