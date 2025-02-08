import 'package:json_annotation/json_annotation.dart';

import '../../base/base_dto.dart';

part 'record_ad_action_dto.g.dart';

@JsonSerializable()
class RecordAdActionDto implements BaseDto {
  @JsonKey(name: 'action_type')
  final String actionType;

  RecordAdActionDto({required this.actionType});

  factory RecordAdActionDto.fromJson(Map<String, dynamic> json) => _$RecordAdActionDtoFromJson(json);
  Map<String, dynamic> toJson() => _$RecordAdActionDtoToJson(this);
}