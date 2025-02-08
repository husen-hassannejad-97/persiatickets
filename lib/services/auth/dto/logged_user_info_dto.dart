import 'package:billit_now/services/base/base_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'logged_user_info_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class LoggedUserInfoDto implements BaseDto {
  @JsonKey(name: 'sub')
  final String sub;

  @JsonKey(name: 'email')
  final String email;

  @JsonKey(name: 'username')
  final String username;

  @JsonKey(name: 'token_version')
  final int tokenVersion;

  @JsonKey(name: 'first_name')
  final String firstName;

  @JsonKey(name: 'last_name')
  final String lastName;

  @JsonKey(name: 'profile_picture_url')
  final String? profileImg;

  @JsonKey(name: 'exp')
  final int exp;

  @JsonKey(name: 'jti')
  final String jti;

  @JsonKey(name: 'type')
  final String type;

  LoggedUserInfoDto({
    required this.sub,
    required this.email,
    required this.username,
    required this.tokenVersion,
    required this.firstName,
    required this.lastName,
    required this.profileImg,
    required this.exp,
    required this.jti,
    required this.type,
  });

  // Generated methods
  factory LoggedUserInfoDto.fromJson(Map<String, dynamic> json) =>
      _$LoggedUserInfoDtoFromJson(json);

  Map<String, dynamic> toJson() => _$LoggedUserInfoDtoToJson(this);
}
