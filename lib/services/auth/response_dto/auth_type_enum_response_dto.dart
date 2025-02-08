import 'package:billit_now/services/base/base_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_type_enum_response_dto.g.dart';

@JsonEnum(alwaysCreate: true)
enum AuthTypeEnumResponseDto implements BaseDto {
  login,
  signup
}