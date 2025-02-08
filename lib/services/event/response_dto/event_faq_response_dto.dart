import 'package:billit_now/services/base/base_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_faq_response_dto.g.dart';

@JsonSerializable()
class EventFaqResponseDto implements BaseDto {
  final int id;
  @JsonKey(name: 'event_id')
  final int eventId;
  @JsonKey(name: 'faq_id')
  final int? faqId;
  @JsonKey(name: 'custom_question')
  final String? customQuestion;
  @JsonKey(name: 'custom_answer')
  final String? customAnswer;

  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  EventFaqResponseDto({
    required this.id,
    required this.eventId,
    required this.faqId,
    required this.customQuestion,
    required this.customAnswer,
    required this.createdAt,
    required this.updatedAt
  });

  @factoryMethod
  factory EventFaqResponseDto.fromJson(Map<String, dynamic> json) => _$EventFaqResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$EventFaqResponseDtoToJson(this);
}