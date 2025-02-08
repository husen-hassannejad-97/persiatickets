import 'package:billit_now/services/shared_dto/device_info_dto.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../base/base_dto.dart';

part 'send_code_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class SendCodeDto implements BaseDto {

  final String? email;

  @JsonKey(name: 'phone_number')
  final String? phoneNumber;

  final DeviceInfoDto deviceInfo;

  SendCodeDto({
    this.email,
    this.phoneNumber,
    required this.deviceInfo,
  });

  // Generated methods
  factory SendCodeDto.fromJson(Map<String, dynamic> json) =>
      _$SendCodeDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SendCodeDtoToJson(this);
}