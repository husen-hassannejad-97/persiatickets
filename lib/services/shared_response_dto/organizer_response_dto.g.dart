// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organizer_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrganizerResponseDto _$OrganizerResponseDtoFromJson(
        Map<String, dynamic> json) =>
    OrganizerResponseDto(
      id: (json['id'] as num).toInt(),
      firstName: json['firstname'] as String,
      lastName: json['lastname'] as String,
      image: json['image'] as String?,
      phoneNumber: json['phonenumber'] as String?,
      email: json['email'] as String?,
      company: json['company'] as String?,
      officeNumber: json['office_number'] as String?,
      address: json['address'] as String?,
      socialMediaLinks:
          (json['social_media_links'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      bio: json['bio'] as String?,
      website: json['website'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$OrganizerResponseDtoToJson(
        OrganizerResponseDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstname': instance.firstName,
      'lastname': instance.lastName,
      'image': instance.image,
      'phonenumber': instance.phoneNumber,
      'email': instance.email,
      'company': instance.company,
      'office_number': instance.officeNumber,
      'address': instance.address,
      'social_media_links': instance.socialMediaLinks,
      'bio': instance.bio,
      'website': instance.website,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };
