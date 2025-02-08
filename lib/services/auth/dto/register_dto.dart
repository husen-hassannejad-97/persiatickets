import 'package:json_annotation/json_annotation.dart';

import '../../base/base_dto.dart';
import '../../shared_dto/device_info_dto.dart';

part 'register_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class RegisterDto implements BaseDto {
  @JsonKey(name: 'contact_info')
  final String contactInfo;

  @JsonKey(name: 'contact_type')
  final String contactType;

  final String password;

  @JsonKey(name: 'first_name')
  final String firstName;

  @JsonKey(name: 'last_name')
  final String lastName;

  final DeviceInfoDto device;

  RegisterDto({
    required this.contactInfo,
    required this.contactType,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.device,
  });

  // Generated methods
  factory RegisterDto.fromJson(Map<String, dynamic> json) =>
      _$RegisterDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterDtoToJson(this);
}