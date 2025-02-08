import 'package:billit_now/services/base/base_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rate_comment_response_dto.g.dart';

@JsonSerializable()
class RateCommentResponseDto implements BaseDto {
  final int id;
  @JsonKey(name: 'event_id')
  final int eventId;
  final double? rating;
  final String? comment;
  @JsonKey(name: 'is_approved')
  final bool isApproved;

  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  RateCommentResponseDto({
    required this.id,
    required this.eventId,
    required this.rating,
    required this.comment,
    required this.isApproved,
    required this.createdAt,
    required this.updatedAt
  });

  @factoryMethod
  factory RateCommentResponseDto.fromJson(Map<String, dynamic> json) => _$RateCommentResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RateCommentResponseDtoToJson(this);
}