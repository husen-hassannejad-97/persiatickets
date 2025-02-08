import 'package:billit_now/services/auth/response_dto/auth_type_enum_response_dto.dart';
import 'package:billit_now/services/base/base_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'send_code_response_dto.g.dart';

@JsonSerializable()
class SendCodeResponseDto implements BaseDto {
  String message;
  AuthTypeEnumResponseDto type;
  SendCodeResponseDto({
    required this.message,
    required  this.type,
  });

  @factoryMethod
  factory SendCodeResponseDto.fromJson(Map<String, dynamic> map) => _$SendCodeResponseDtoFromJson(map);

  Map<String, dynamic> toJson() => _$SendCodeResponseDtoToJson(this);
}