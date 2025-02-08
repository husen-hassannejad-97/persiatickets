// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'venue_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VenueResponseDto _$VenueResponseDtoFromJson(Map<String, dynamic> json) =>
    VenueResponseDto(
      name: json['name'] as String,
      address: json['address'] as String,
      description: json['description'] as String?,
      gallery:
          (json['gallery'] as List<dynamic>?)?.map((e) => e as String).toList(),
      nearbyAmenities: json['nearby_amenities'] as String?,
      gettingThere: (json['getting_there'] as List<dynamic>?)
          ?.map((e) =>
              GettingThereResponseDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      overview: json['overview'] as String?,
      capacity: (json['capacity'] as num).toInt(),
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      id: (json['id'] as num).toInt(),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$VenueResponseDtoToJson(VenueResponseDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
      'description': instance.description,
      'capacity': instance.capacity,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'overview': instance.overview,
      'getting_there': instance.gettingThere,
      'nearby_amenities': instance.nearbyAmenities,
      'gallery': instance.gallery,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };
