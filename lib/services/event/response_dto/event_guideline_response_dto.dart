import 'package:billit_now/services/base/base_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_guideline_response_dto.g.dart';

@JsonSerializable()
class EventGuidelineResponseDto implements BaseDto {
  final int id;
  @JsonKey(name: 'event_id')
  final int eventId;
  @JsonKey(name: 'guideline_id')
  final int? guidelineId;
  @JsonKey(name: 'custom_name')
  final String? customName;
  @JsonKey(name: 'custom_description')
  final String? customDescription;

  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  EventGuidelineResponseDto({
    required this.id,
    required this.eventId,
    required this.guidelineId,
    required this.customDescription,
    required this.customName,
    required this.createdAt,
    required this.updatedAt
  });

  @factoryMethod
  factory EventGuidelineResponseDto.fromJson(Map<String, dynamic> json) => _$EventGuidelineResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$EventGuidelineResponseDtoToJson(this);
}