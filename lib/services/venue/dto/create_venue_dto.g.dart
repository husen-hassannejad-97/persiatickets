// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_venue_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateVenueDto _$CreateVenueDtoFromJson(Map<String, dynamic> json) =>
    CreateVenueDto(
      name: json['name'] as String,
      address: json['address'] as String,
      description: json['description'] as String,
      capacity: (json['capacity'] as num).toInt(),
    );

Map<String, dynamic> _$CreateVenueDtoToJson(CreateVenueDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'address': instance.address,
      'description': instance.description,
      'capacity': instance.capacity,
    };
