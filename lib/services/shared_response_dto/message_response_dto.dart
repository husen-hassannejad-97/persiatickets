import 'package:json_annotation/json_annotation.dart';

import '../base/base_dto.dart';

part 'message_response_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class MessageResponseDto implements BaseDto {
  final String message;

  MessageResponseDto({
    required this.message,
  });

  // Generated methods
  factory MessageResponseDto.fromJson(Map<String, dynamic> json) =>
      _$MessageResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MessageResponseDtoToJson(this);
}