import 'package:injectable/injectable.dart';

import '../../../services/venue/response_dto/venue_response_dto.dart';
import '../../base/base_dto_mapper.dart';
import '../models/venue_model.dart';

@injectable
class VenueResponseDtoMapper implements BaseDtoMapper<VenueResponseDto, VenueModel> {
  @override
  VenueResponseDto toDto(VenueModel model) {
    return VenueResponseDto(
      name: model.name,
      address: model.address,
      description: model.description,
      capacity: model.capacity,
      id: model.id,
      createdAt: model.createdAt,
      updatedAt: model.updatedAt,
      gallery: null,
      nearbyAmenities: null,
      gettingThere: null,
      overview: null,
      latitude: null,
      longitude: null,
    );
  }

  @override
  VenueModel fromDto(VenueResponseDto dto) {
    return VenueModel(
      name: dto.name,
      address: dto.address,
      description: dto.description ?? "",
      capacity: dto.capacity,
      id: dto.id,
      createdAt: dto.createdAt,
      updatedAt: dto.updatedAt,
    );
  }
}
