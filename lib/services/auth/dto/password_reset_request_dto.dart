import 'package:json_annotation/json_annotation.dart';

import '../../base/base_dto.dart';

part 'password_reset_request_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class PasswordResetRequestDto implements BaseDto {
  @JsonKey(name: 'contact_info')
  final String contactInfo;

  @JsonKey(name: 'contact_type')
  final String contactType;

  PasswordResetRequestDto({
    required this.contactInfo,
    required this.contactType,
  });

  // Generated methods
  factory PasswordResetRequestDto.fromJson(Map<String, dynamic> json) =>
      _$PasswordResetRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PasswordResetRequestDtoToJson(this);
}