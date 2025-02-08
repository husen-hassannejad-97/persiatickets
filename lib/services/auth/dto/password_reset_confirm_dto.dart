import 'package:json_annotation/json_annotation.dart';

import '../../base/base_dto.dart';

part 'password_reset_confirm_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class PasswordResetConfirmDto implements BaseDto {
  final String token;

  @JsonKey(name: 'new_password')
  final String newPassword;

  PasswordResetConfirmDto({
    required this.token,
    required this.newPassword,
  });

  // Generated methods
  factory PasswordResetConfirmDto.fromJson(Map<String, dynamic> json) =>
      _$PasswordResetConfirmDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PasswordResetConfirmDtoToJson(this);
}