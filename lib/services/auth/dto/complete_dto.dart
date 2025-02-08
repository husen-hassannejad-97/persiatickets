import 'package:json_annotation/json_annotation.dart';

import '../../base/base_dto.dart';

part 'complete_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class CompleteDto implements BaseDto {
  final String email;

  @JsonKey(name: 'phone_number')
  final String phoneNumber;

  final String password;

  @JsonKey(name: 'first_name')
  final String firstName;

  @JsonKey(name: 'last_name')
  final String lastName;

  CompleteDto({
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.firstName,
    required this.lastName,
  });

  // Generated methods
  factory CompleteDto.fromJson(Map<String, dynamic> json) =>
      _$CompleteDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CompleteDtoToJson(this);
}