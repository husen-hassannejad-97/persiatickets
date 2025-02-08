import 'package:billit_now/services/event/response_dto/event_artist_response_dto.dart';
import 'package:billit_now/services/event/response_dto/event_faq_response_dto.dart';
import 'package:billit_now/services/event/response_dto/event_program_response_dto.dart';
import 'package:billit_now/services/venue/response_dto/venue_response_dto.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../base/base_dto.dart';
import '../../shared_response_dto/organizer_response_dto.dart';
import '../../shared_response_dto/rate_comment_response_dto.dart';
import '../../shared_response_dto/sponsor_response_dto.dart';
import '../dto/event_category_dto.dart';
import 'event_guideline_response_dto.dart';
import 'event_specific_amenity_response_dto.dart';
import 'event_venue_facility_response_dto.dart';

part 'event_details_music_response_dto.g.dart';

@JsonSerializable()
class EventDetailsMusicResponseDto implements BaseDto {
  final String name;
  @JsonKey(name: 'file_url')
  final String? fileUrl;

  EventDetailsMusicResponseDto({
    required this.name,
    required this.fileUrl,
  });

  factory EventDetailsMusicResponseDto.fromJson(Map<String, dynamic> json) => _$EventDetailsMusicResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$EventDetailsMusicResponseDtoToJson(this);
}