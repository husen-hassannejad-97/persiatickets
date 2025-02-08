import 'package:json_annotation/json_annotation.dart';
import '../../base/base_dto.dart';
import 'token_response_dto.dart';

part 'token_wrapper_response_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class TokenWrapperResponseDto implements BaseDto {
  final String message;
  final TokenResponseDto? token;

  TokenWrapperResponseDto({
    required this.message,
    required this.token,
  });

  // Generated methods
  factory TokenWrapperResponseDto.fromJson(Map<String, dynamic> json) =>
      _$TokenWrapperResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TokenWrapperResponseDtoToJson(this);
}