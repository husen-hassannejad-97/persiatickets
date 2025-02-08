// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_venue_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateVenueDto _$UpdateVenueDtoFromJson(Map<String, dynamic> json) =>
    UpdateVenueDto(
      name: json['name'] as String,
      address: json['address'] as String,
      description: json['description'] as String,
      capacity: (json['capacity'] as num).toInt(),
    );

Map<String, dynamic> _$UpdateVenueDtoToJson(UpdateVenueDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'address': instance.address,
      'description': instance.description,
      'capacity': instance.capacity,
    };
