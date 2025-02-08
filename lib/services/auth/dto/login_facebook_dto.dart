import 'package:json_annotation/json_annotation.dart';

import '../../base/base_dto.dart';
import '../../shared_dto/device_info_dto.dart';

part 'login_facebook_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class LoginFacebookDto implements BaseDto {
  final String token;
  final DeviceInfoDto device;

  LoginFacebookDto({
    required this.token,
    required this.device,
  });

  // Generated methods
  factory LoginFacebookDto.fromJson(Map<String, dynamic> json) =>
      _$LoginFacebookDtoFromJson(json);

  Map<String, dynamic> toJson() => _$LoginFacebookDtoToJson(this);
}