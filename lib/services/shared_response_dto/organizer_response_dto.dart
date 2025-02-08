import 'package:billit_now/services/base/base_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'organizer_response_dto.g.dart';

@JsonSerializable()
class OrganizerResponseDto implements BaseDto {
  final int id;
  @JsonKey(name: 'firstname')
  final String firstName;
  @JsonKey(name: 'lastname')
  final String lastName;
  final String? image;
  @JsonKey(name: 'phonenumber')
  final String? phoneNumber;
  final String? email;
  final String? company;
  @JsonKey(name: 'office_number')
  final String? officeNumber;
  final String? address;
  @JsonKey(name: 'social_media_links')
  final Map<String, String>? socialMediaLinks;
  final String? bio;
  final String? website;

  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  OrganizerResponseDto({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.image,
    required this.phoneNumber,
    required this.email,
    required this.company,
    required this.officeNumber,
    required this.address,
    required this.socialMediaLinks,
    required this.bio,
    required this.website,
    required this.createdAt,
    required this.updatedAt
  });

  @factoryMethod
  factory OrganizerResponseDto.fromJson(Map<String, dynamic> json) => _$OrganizerResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$OrganizerResponseDtoToJson(this);
}