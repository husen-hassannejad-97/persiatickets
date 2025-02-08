import 'package:billit_now/services/base/base_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'verify_signup_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class VerifySignupDto implements BaseDto {
  @JsonKey(name: 'contact_info')
  final String contactInfo;

  @JsonKey(name: 'contact_type')
  final String contactType;

  final String code;

  VerifySignupDto({
    required this.contactInfo,
    required this.contactType,
    required this.code,
  });

  factory VerifySignupDto.fromJson(Map<String, dynamic> json) =>
      _$VerifySignupDtoFromJson(json);

  // A method to convert a ContactInfo instance to a JSON map.
  Map<String, dynamic> toJson() => _$VerifySignupDtoToJson(this);
}
