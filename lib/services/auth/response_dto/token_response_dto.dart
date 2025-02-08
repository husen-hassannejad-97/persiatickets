import 'package:billit_now/services/base/base_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'token_response_dto.g.dart';

@JsonSerializable()
class TokenResponseDto implements BaseDto {
  @JsonKey(name: "token_type")
  String tokenType;
  @JsonKey(name: "access_token")
  String accessToken;
  @JsonKey(name: "refresh_token")
  String? refreshToken;
  String? deviceId;
  TokenResponseDto({
    required this.tokenType,
    required this.accessToken,
    required this.refreshToken,
    this.deviceId,
  });

  @factoryMethod
  factory TokenResponseDto.fromJson(Map<String, dynamic> map) => _$TokenResponseDtoFromJson(map);

  Map<String, dynamic> toJson() => _$TokenResponseDtoToJson(this);
}