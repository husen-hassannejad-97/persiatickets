import 'package:json_annotation/json_annotation.dart';

import '../../base/base_dto.dart';
import '../../shared_dto/device_info_dto.dart';

part 'login_google_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class LoginGoogleDto implements BaseDto {
  final String token;
  final DeviceInfoDto device;

  LoginGoogleDto({
    required this.token,
    required this.device,
  });

  // Generated methods
  factory LoginGoogleDto.fromJson(Map<String, dynamic> json) =>
      _$LoginGoogleDtoFromJson(json);

  Map<String, dynamic> toJson() => _$LoginGoogleDtoToJson(this);
}