import 'package:json_annotation/json_annotation.dart';

import '../../base/base_dto.dart';

part 'record_ad_action_response_dto.g.dart';

@JsonSerializable()
class RecordAdActionResponseDto implements BaseDto {
  final int id;
  @JsonKey(name: 'ad_id')
  final int adId;
  @JsonKey(name: 'action_type')
  final String actionType;
  final DateTime timestamp;

  RecordAdActionResponseDto({
    required this.id,
    required this.adId,
    required this.actionType,
    required this.timestamp,
  });

  factory RecordAdActionResponseDto.fromJson(Map<String, dynamic> json) => _$RecordAdActionResponseDtoFromJson(json);
  Map<String, dynamic> toJson() => _$RecordAdActionResponseDtoToJson(this);
}